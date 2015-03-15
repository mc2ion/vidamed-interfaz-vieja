package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AddPatientService implements DatabaseCommand {
	
	private Long admissionId;
	private Long serviceId;
		
	public AddPatientService(Long admissionId, Long serviceId){
		this.admissionId = admissionId;
		this.serviceId 	 = serviceId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		Long serviceID = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.AddPatientService " + admissionId + ", " + serviceId);
			rs = ps.executeQuery();
			if (rs.next()) {
				serviceID = rs.getLong(1);
			}
		}
		finally {
			ps.close();
		}		
		
		return serviceID;
	}
}
