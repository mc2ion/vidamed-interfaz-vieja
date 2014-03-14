package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RemoveUser implements DatabaseCommand {
	
	private Long userID;
	
	public RemoveUser(Long userID){
		this.userID = userID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.RemoveUser " + userID);
			ps.execute();
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
