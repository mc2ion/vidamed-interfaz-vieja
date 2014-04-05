package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class OpenCashBox implements DatabaseCommand {
	
	private Long cashBoxID;
	private Long userID;
	private Double initialAmount;
	
	public OpenCashBox(Long cashBoxID, Long userID, Double initialAmount){
		this.cashBoxID = cashBoxID;
		this.userID = userID;
		this.initialAmount = initialAmount;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.OpenCashBox " + userID + ", " + initialAmount + ", " + cashBoxID);
			ps.execute();
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
