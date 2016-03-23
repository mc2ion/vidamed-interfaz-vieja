package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.Protocol;

public class GetCompactAdmissionCosts implements DatabaseCommand {
	Long admissionId;
	
	public GetCompactAdmissionCosts(Long admissionId){
		this.admissionId = admissionId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		ArrayList<Protocol> costs = new ArrayList<Protocol>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetCompactAdmissionCosts " + admissionId);
			rs = ps.executeQuery();

			while (rs.next()) {
				Protocol u = new Protocol();
				u.setBussinessRuleMicroID(rs.getLong(1));
				u.setBussinessRuleMicroName(rs.getString(2));
				u.setCost(rs.getString(3), rs.getDouble(3));
				u.setEstimationCost(rs.getString(4), rs.getDouble(4));
				costs.add(u);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return costs;
	}
}
