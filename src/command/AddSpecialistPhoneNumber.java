package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AddSpecialistPhoneNumber implements DatabaseCommand {
	
	private Long specialistID;
	private String type;
	private String phoneNumber;
		
	public AddSpecialistPhoneNumber(Long specialistID, String type, String phoneNumber){
		this.specialistID = specialistID;
		this.type = type;
		this.phoneNumber = phoneNumber;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		Long phoneNumberID = null;
		try {
			ps = conn.prepareStatement("exec dbo.AddSpecialistPhoneNumber " + specialistID + ", '" + 
						type + "', '" + phoneNumber + "'");
			rs = ps.executeQuery();
			if (rs.next()) {
				phoneNumberID = rs.getLong(1);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return phoneNumberID;
	}

}
