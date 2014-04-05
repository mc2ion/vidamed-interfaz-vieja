package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class CloseCashBox implements DatabaseCommand {
	
	private Long cashBoxID;
	private Long userID;
	private Double amount;
	
	public CloseCashBox(Long cashBoxID, Long userID, Double amount){
		this.cashBoxID = cashBoxID;
		this.userID = userID;
		this.amount = amount;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.CloseCashBox " + cashBoxID + ", " + userID + ", " + amount);
			ps.execute();
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
