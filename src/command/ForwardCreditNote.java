package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class ForwardCreditNote implements DatabaseCommand {
	
	private long creditnoteID;
	
	public ForwardCreditNote(long creditnoteID){
		this.creditnoteID  = creditnoteID;
	}	
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.ForwardCreditNote " + creditnoteID);
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
