package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RemovePatientSupply implements DatabaseCommand {
	
	private Long supplyPatientId;
	
	public RemovePatientSupply(Long supplyPatientId){
		this.supplyPatientId = supplyPatientId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.RemovePatientSupply " + supplyPatientId);
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
