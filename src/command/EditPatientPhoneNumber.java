package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditPatientPhoneNumber implements DatabaseCommand {

	private Long phoneNumberID;
	private String type;
	private String phoneNumber;
		
	public EditPatientPhoneNumber(Long phoneNumberID, String type, String phoneNumber){
		this.phoneNumberID = phoneNumberID;
		this.type = type;
		this.phoneNumber = phoneNumber;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement("exec dbo.EditPatientPhoneNumber '" + type + "', '" + phoneNumber + "', "
					+ phoneNumberID);
			ps.execute();
		}
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		finally {
			ps.close();
		}		
		
		return phoneNumberID;
	}


}
