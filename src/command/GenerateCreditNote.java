package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class GenerateCreditNote implements DatabaseCommand {
	
	private Long userID;
	private Long creditNoteID;
	
	
	public GenerateCreditNote(Long userID, Long creditNoteID){
		this.userID 		= userID;
		this.creditNoteID 	= creditNoteID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GenerateCreditNote " + userID + "," + creditNoteID);
			ps.execute();
		}
		catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
