package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditPatientSupply implements DatabaseCommand {
	
	private Long supplyPatientId;
	private String amount;
		
	public EditPatientSupply(Long supplyPatientId, String amount){
		this.supplyPatientId 	 = supplyPatientId;
		this.amount 	 		 = amount;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.EditPatientSupply " + supplyPatientId + ", '" +  amount + "'");
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
