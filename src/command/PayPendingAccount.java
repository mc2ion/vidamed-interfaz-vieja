package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class PayPendingAccount implements DatabaseCommand {
	
	private Long billId;
	private String documentNumber;
	private String bank;
	
	public PayPendingAccount(Long billId, String documentNumber, String bank){
		this.billId = billId;
		this.documentNumber = documentNumber;
		this.bank = bank;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.PayAccount " + billId + ", '" + documentNumber + "', '" + bank + "'");
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
