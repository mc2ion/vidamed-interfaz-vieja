package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditUserPhoneNumber implements DatabaseCommand {
	
	private Long phoneNumberID;
	private String type;
	private String phoneNumber;
		
	public EditUserPhoneNumber(Long phoneNumberID, String type, String phoneNumber){
		this.phoneNumberID = phoneNumberID;
		this.type = type;
		this.phoneNumber = phoneNumber;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement("exec dbo.EditUserPhoneNumber '" + type + "', '" + phoneNumber + "', "
					+ phoneNumberID);
			ps.execute();
		}
		finally {
			ps.close();
		}		
		
		return phoneNumberID;
	}

}
