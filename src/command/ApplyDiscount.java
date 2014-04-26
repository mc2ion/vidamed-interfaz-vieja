package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class ApplyDiscount implements DatabaseCommand {
	
	private long estimationId;
	private String type;
	private String amount;
	private String justification;
	
	public ApplyDiscount(long estimationId, String type, String amount, String justification){
		this.estimationId  = estimationId;
		this.type		   = type;
		this.amount 	   = amount;
		this.justification = justification;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.ApplyDiscount " + estimationId + ", '" + type + "', '" + amount + "', '" + justification + "'");
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
