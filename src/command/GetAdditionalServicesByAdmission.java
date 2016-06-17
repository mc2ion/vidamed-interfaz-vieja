package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.PatientAdditionalService;

public class GetAdditionalServicesByAdmission implements DatabaseCommand {
	
	private Long id;
	
	public GetAdditionalServicesByAdmission(long id){
		this.id = id;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		

		ArrayList<PatientAdditionalService> list = new ArrayList<PatientAdditionalService>();
				
				
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetAdditionalServicesByAdmission " + id);
			rs = ps.executeQuery();

			while (rs.next()) {
				PatientAdditionalService u = new PatientAdditionalService();
				u.setPatientAdditionalServiceID(rs.getLong(1));
				u.setAdmissionID(rs.getLong(2));
				u.setAdditionalServiceID(rs.getLong(3));
				u.setAdditionalServiceName(rs.getString(4));
				u.setBussinessRuleMicroID(rs.getLong(5));
				u.setBussinessRuleMicroName(rs.getString(6));
				u.setAmount(rs.getDouble(7));
				u.setAdditionalServiceDate(rs.getString(8));
				
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
