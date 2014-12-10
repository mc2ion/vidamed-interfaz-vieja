package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AddProtocolSupply implements DatabaseCommand {
	
	private Double amount;
	private Long protocolId;
	private Long protocolScaleId;
	private Long supplyId;
			
	public AddProtocolSupply(String amount, String protocolId, String protocolScaleId, String supplyId) {
		this.amount 		 	= Double.valueOf(amount);
		this.protocolId 		= Long.valueOf(protocolId);
		this.protocolScaleId 	= Long.valueOf(protocolScaleId);
		this.supplyId 	 		= Long.valueOf(supplyId);
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement("exec dbo.AddProtocolSupply " + protocolId + ", " + protocolScaleId + ", " + 
					supplyId + ", " + amount);
			ps.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}	
		
		return (Long) new Long(1);
	}

}
