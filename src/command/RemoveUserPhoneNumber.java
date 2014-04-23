package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RemoveUserPhoneNumber implements DatabaseCommand {
	
	private Long phoneNumberID;
	
	public RemoveUserPhoneNumber(Long phoneNumberID){
		this.phoneNumberID = phoneNumberID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.RemoveUserPhoneNumber " + phoneNumberID);
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
