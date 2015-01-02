package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import domain.Protocol;

public class GetDetailedEstimationScaleToPrint implements DatabaseCommand {
	
	private String estimationid;
	
	public GetDetailedEstimationScaleToPrint(String estimationid){
		this.estimationid = estimationid;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<Protocol> list = new ArrayList<Protocol>();
		try {
			ps = conn.prepareStatement("exec dbo.GetDetailedEstimationScaleToPrint '" + estimationid + "'");
			rs = ps.executeQuery();

			while (rs.next()) {
				Protocol u = new Protocol();
				u.setProtocolID(rs.getLong(1));
				u.setDiagnosis(rs.getString(2));
				u.setName(rs.getString(3));
				u.setTotal(rs.getString(4));
				u.setTotalWithPercentage(rs.getString(5));
				u.setBussinessRuleMicroName(rs.getString(6));
				u.setCost(rs.getString(7));
				u.setEstimationCost(rs.getString(8));
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
