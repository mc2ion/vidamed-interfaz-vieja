package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import domain.ProtocolScale;

public class GetEstimationProtocolScale implements DatabaseCommand {
	
	private String estimationid;
	private String protocolid;
	
	
	public GetEstimationProtocolScale(String estimationid, String protocolid){
		this.estimationid = estimationid;
		this.protocolid   = protocolid;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<ProtocolScale> list = new ArrayList<ProtocolScale>();
		try {
			ps = conn.prepareStatement("exec dbo.GetEstimationProtocolScale '" + estimationid + "', '" + protocolid + "'");
			rs = ps.executeQuery();

			while (rs.next()) {
				ProtocolScale u = new ProtocolScale();
				u.setProtocolScaleID(rs.getLong(1));
				u.setName(rs.getString(2));
				u.setBussinessRuleMicroID(rs.getLong(3));
				u.setIsMandatory(rs.getLong(4));
				u.setGeneratedCostTypeID(rs.getLong(5));
				u.setGeneratedCostTypeName(rs.getString(6));
				u.setCost(rs.getString(7), rs.getDouble(7));
				u.setTotal(rs.getString(8), rs.getDouble(8));
				u.setBussinessRuleMicroName(rs.getString(9));
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
