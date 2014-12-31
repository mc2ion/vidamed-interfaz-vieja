package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import domain.Protocol;

public class GetEstimationProtocols implements DatabaseCommand {
	
	private String estimationid;
	
	public GetEstimationProtocols(String estimationid){
		this.estimationid = estimationid;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<Protocol> list = new ArrayList<Protocol>();
		try {
			ps = conn.prepareStatement("exec dbo.GetEstimationProtocols '" + estimationid + "'");
			rs = ps.executeQuery();

			while (rs.next()) {
				Protocol u = new Protocol();
				u.setProtocolID(rs.getLong(2));
				u.setName(rs.getString(3));
				u.setDiagnosis(rs.getString(4));
				u.setTotal(rs.getString(5));
				u.setTotalWithPercentage(rs.getString(6));
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
