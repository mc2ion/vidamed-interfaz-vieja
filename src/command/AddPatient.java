package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AddPatient implements DatabaseCommand {
	
	private String identityCard;
	private int isAdult;
	private String firstName;
	private String lastName;
	private String birthday;
	private String gender;
	private String address;
	private String email;
		
	public AddPatient(String identityCard, int isAdult, String firstName, String lastName, String birthday, 
			String gender, String address, String email) {
		this.identityCard = identityCard;
		this.firstName = firstName;
		this.lastName = lastName;
		this.birthday = birthday;
		this.gender = gender;
		this.address = address;
		this.email = email;
		this.isAdult = isAdult;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		Long userID = null;
		try {
			ps = conn.prepareStatement("exec dbo.AddPatient '" + isAdult + "', '" + identityCard + "', '" + 
						firstName + "', '" + lastName + "', '" + birthday + "', '" + gender + "', '" + 
						address + "', '" + email + "'");
			rs = ps.executeQuery();
			if (rs.next()) {
				userID = rs.getLong(1);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return userID;
	}

}
