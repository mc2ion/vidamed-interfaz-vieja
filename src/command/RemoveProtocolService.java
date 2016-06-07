package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RemoveProtocolService implements DatabaseCommand {
	
	private Long protocolID;
	private Long protocolScaleID;
	private Long serviceID;
	
	
	public RemoveProtocolService(String protocolID, String protocolScaleID, String serviceID){
		this.protocolID 		= Long.valueOf(protocolID);
		this.protocolScaleID 	= Long.valueOf(protocolScaleID);
		this.serviceID 			= Long.valueOf(serviceID);
		
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.RemoveProtocolService " + protocolID + "," + protocolScaleID + "," + serviceID);
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
