package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RemovePatient implements DatabaseCommand {

	private Long patientID;
	
	public RemovePatient(Long patientID){
		this.patientID = patientID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.RemovePatient " + patientID);
			ps.execute();
		}
		catch(Exception E){
			return 0;
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
