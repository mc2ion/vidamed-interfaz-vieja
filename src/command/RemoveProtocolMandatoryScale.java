package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RemoveProtocolMandatoryScale implements DatabaseCommand {
	
	private Long protocolID;
	
	
	
	public RemoveProtocolMandatoryScale(String protocolID){
		this.protocolID 		= Long.valueOf(protocolID);
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.RemoveProtocolMandatoryScale " + protocolID);
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
