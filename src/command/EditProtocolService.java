package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditProtocolService implements DatabaseCommand {
	
	private Double amount;
	private Long protocolId;
	private Long protocolScaleId;
	private Long serviceId;
			
	public EditProtocolService(String amount, String protocolId, String protocolScaleId, String serviceId) {
		this.amount 		 	= Double.valueOf(amount);
		this.protocolId 		= Long.valueOf(protocolId);
		this.protocolScaleId 	= Long.valueOf(protocolScaleId);
		this.serviceId 	 		= Long.valueOf(serviceId);
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement("exec dbo.EditProtocolService " + amount + "," + protocolId + ", " + protocolScaleId + ", " + 
					serviceId);
			ps.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}	
		
		return (Long) new Long(1);
	}

}