package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RemoveProtocolSupply implements DatabaseCommand {
	
	private Long protocolID;
	private Long protocolScaleID;
	private Long supplyID;
	
	
	public RemoveProtocolSupply(String protocolID, String protocolScaleID, String supplyID){
		this.protocolID 		= Long.valueOf(protocolID);
		this.protocolScaleID 	= Long.valueOf(protocolScaleID);
		this.supplyID 			= Long.valueOf(supplyID);
		
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.RemoveProtocolSupply " + protocolID + "," + protocolScaleID + "," + supplyID);
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
