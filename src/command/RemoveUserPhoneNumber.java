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
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
