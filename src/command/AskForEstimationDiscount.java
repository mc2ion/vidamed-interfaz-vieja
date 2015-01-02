package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class AskForEstimationDiscount implements DatabaseCommand {
	
	private String estimationid;
	private String type;
	private String amount;
	private String justification;
	
	
	public AskForEstimationDiscount(String estimationid, String type, String amount, String justification){
		this.estimationid 	= estimationid;
		this.type 			= type;
		this.amount 		= amount;
		this.justification 	= justification;
		
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.AskForEstimationDiscount '" + estimationid + "', '" 
										+ type + "', '" + amount + "', '" + justification + "'");
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
