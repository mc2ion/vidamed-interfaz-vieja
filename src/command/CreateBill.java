package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class CreateBill implements DatabaseCommand {
	
	private long creditnoteId;
	private long userId;
	
	public CreateBill(long creditnoteId, long userId){
		this.creditnoteId  = creditnoteId;
		this.userId		   = userId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.CreateBill " + creditnoteId + ", " + userId);
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
