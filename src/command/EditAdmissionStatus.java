package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditAdmissionStatus implements DatabaseCommand {
	
	private Long statusId;
	private Long admissionId;
		
	public EditAdmissionStatus(Long statusId, Long admissionId) {
		this.statusId = statusId;
		this.admissionId = admissionId;
		
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement("exec dbo.UpdateAdmissionStatus " + statusId + ", " + 
						admissionId);
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
