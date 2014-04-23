package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AddUserPermission implements DatabaseCommand {
	
	private Long userID;
	private Long permissionID;
		
	public AddUserPermission(Long userID, Long permissionID){
		this.userID = userID;
		this.permissionID = permissionID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.AddUserPermission " + userID + ", " + permissionID);
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
