package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class GenerateBill implements DatabaseCommand {
	
	private Long userID;
	private Long billID;
	
	
	public GenerateBill(Long userID, Long billID){
		this.userID 		= userID;
		this.billID 	= billID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GenerateBill " + userID + "," + billID);
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
