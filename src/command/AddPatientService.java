package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AddPatientService implements DatabaseCommand {
	
	private Long admissionId;
	private Long serviceId;
	private String fileName;
		
	public AddPatientService(Long admissionId, Long serviceId, String fileName){
		this.admissionId = admissionId;
		this.serviceId 	 = serviceId;
		this.fileName 	 = fileName;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.AddPatientService " + admissionId + ", " + serviceId + ", '" + fileName + "'");
			ps.execute();
		}
		catch(Exception e){
			return 0;
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
