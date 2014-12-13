package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AddProtocolMandatoryScale implements DatabaseCommand {
	
	private Long protocolId;
	private Long protocolScaleId;
			
	public AddProtocolMandatoryScale(String protocolId, String protocolScaleId) {
		this.protocolId 		= Long.valueOf(protocolId);
		this.protocolScaleId 	= Long.valueOf(protocolScaleId);
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement("exec dbo.AddProtocolMandatoryScale " + protocolId + ", " + protocolScaleId);
			ps.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}	
		
		return (Long) new Long(1);
	}

}
