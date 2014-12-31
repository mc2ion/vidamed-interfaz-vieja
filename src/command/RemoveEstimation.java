package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RemoveEstimation implements DatabaseCommand {
	
	private Long userID;
	
	public RemoveEstimation(Long userID){
		this.userID = userID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.RemoveEstimation " + userID);
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
