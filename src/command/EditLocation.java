package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditLocation implements DatabaseCommand {
	
	private Long admissionId;
	private Long bedId;
	
	public EditLocation(Long admissionId, Long bedId){
		this.admissionId = admissionId;
		this.bedId 		 = bedId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.EditLocation " + admissionId + "," + bedId);
			ps.execute();
		}
		catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		finally {
			ps.close();
		}		
		return 1;
	}

}
