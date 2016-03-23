package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AddPatientSupply implements DatabaseCommand {
	
	private Long admissionId;
	private Long supplyInventoryId;
	private String amount;
	private Long protocolScaleId;
		
	public AddPatientSupply(Long admissionId, Long supplyInventoryId, String amount, Long protocolScaleId){
		this.admissionId = admissionId;
		this.supplyInventoryId 	 = supplyInventoryId;
		this.amount 	 = amount;
		this.protocolScaleId = protocolScaleId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.AddPatientSupply " + admissionId + ", " + supplyInventoryId + ", '" + amount + "', " + protocolScaleId);
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
