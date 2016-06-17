package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RemovePatientAdditionalService implements DatabaseCommand {
	
	private Long id;
	
	public RemovePatientAdditionalService(Long id){
		this.id = id;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.RemovePatientAdditionalService " + id);
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
