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
				u.setName(rs.getString(2));
				u.setDiagnosis(rs.getString(3));
				u.setProtocolScaleID(rs.getLong(4));
				u.setProtocolScaleName(rs.getString(5));
				u.setBussinessRuleMicroID(rs.getLong(6));
				u.setBussinessRuleMicroName(rs.getString(7));
				u.setGeneratedCostTypeID(rs.getLong(8));
				u.setCost(rs.getString(9), rs.getDouble(9));
				u.setEstimationCost(rs.getString(10), rs.getDouble(10));
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
