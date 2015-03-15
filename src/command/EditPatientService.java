package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditPatientService implements DatabaseCommand {
	
	private Long servicePatientId;
	private String fileName;
	private String reportName;
		
	public EditPatientService(Long servicePatientId, String fileName, String reportName){
		this.servicePatientId 	 = servicePatientId;
		this.fileName 	 		 = fileName;
		this.reportName			 = reportName;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.EditPatientService '" + fileName + "', " +  servicePatientId + ", '"+ reportName + "'");
			ps.execute();
		}
		catch(Exception e){
			return -1L;
		}
		finally {
			ps.close();
		}		
		
		return this.servicePatientId;
	}

}
