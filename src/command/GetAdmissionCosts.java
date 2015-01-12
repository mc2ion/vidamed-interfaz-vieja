package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import domain.Cost;

public class GetAdmissionCosts implements DatabaseCommand {
	Long admissionId;
	
	public GetAdmissionCosts(Long admissionId){
		this.admissionId = admissionId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<Cost> costs = new ArrayList<Cost>();;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetAdmissionCosts " + admissionId);
			rs = ps.executeQuery();

			while (rs.next()) {
				Cost u = new Cost();
				u.setName(rs.getString(1));
				u.setCost(rs.getString(2), rs.getDouble(2));
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
