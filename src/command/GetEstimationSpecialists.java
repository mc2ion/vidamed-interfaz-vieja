package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import domain.EstimationSpecialist;

public class GetEstimationSpecialists implements DatabaseCommand {
	
	private String estimationid;
	private String protocolid;
	
	public GetEstimationSpecialists(String estimationid, String protocolid){
		this.estimationid = estimationid;
		this.protocolid   = protocolid;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<EstimationSpecialist> list = new ArrayList<EstimationSpecialist>();
		try {
			ps = conn.prepareStatement("exec dbo.GetEstimationSpecialists '" + estimationid + "', '" + protocolid + "'");
			rs = ps.executeQuery();

			while (rs.next()) {
				EstimationSpecialist u = new EstimationSpecialist();
				u.setProtocolScaleID(rs.getLong(3));
				u.setUnitID(rs.getLong(4));
				u.setSpecialistID(rs.getLong(5));
				list.add(u);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		return list;
	}
}
