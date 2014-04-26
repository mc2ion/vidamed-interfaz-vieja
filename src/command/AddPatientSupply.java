package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AddPatientSupply implements DatabaseCommand {
	
	private Long admissionId;
	private Long supplyId;
	private String amount;
		
	public AddPatientSupply(Long admissionId, Long supplyId, String amount){
		this.admissionId = admissionId;
		this.supplyId 	 = supplyId;
		this.amount 	 = amount;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.AddPatientSupply " + admissionId + ", " + supplyId + ", '" + amount + "'");
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
