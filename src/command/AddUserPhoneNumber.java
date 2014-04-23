package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AddUserPhoneNumber implements DatabaseCommand {
	
	private Long userID;
	private String type;
	private String phoneNumber;
		
	public AddUserPhoneNumber(Long userID, String type, String phoneNumber){
		this.userID = userID;
		this.type = type;
		this.phoneNumber = phoneNumber;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		Long phoneNumberID = null;
		try {
			ps = conn.prepareStatement("exec dbo.AddUserPhoneNumber " + userID + ", '" + 
						type + "', '" + phoneNumber + "'");
			rs = ps.executeQuery();
			if (rs.next()) {
				phoneNumberID = rs.getLong(1);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return phoneNumberID;
	}

}
