package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditPatientService implements DatabaseCommand {
	
	private Long servicePatientId;
	private String fileName;
		
	public EditPatientService(Long servicePatientId, String fileName){
		this.servicePatientId 	 = servicePatientId;
		this.fileName 	 		 = fileName;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.EditPatientService '" + fileName + "', " +  servicePatientId);
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
