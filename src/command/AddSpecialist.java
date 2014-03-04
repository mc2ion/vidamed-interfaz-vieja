package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AddSpecialist implements DatabaseCommand {
	
	private String identityCard;
	private String firstName;
	private String lastName;
	private String birthday;
	private String gender;
	private String rif;
	private String address;
	private String email;
		
	public AddSpecialist(String identityCard, String firstName, String lastName, String birthday, 
			String gender, String rif, String address, String email){
		this.identityCard = identityCard;
		this.firstName = firstName;
		this.lastName = lastName;
		this.birthday = birthday;
		this.gender = gender;
		this.rif = rif;
		this.address = address;
		this.email = email;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		Long specialistID = null;
		try {
			ps = conn.prepareStatement("exec dbo.AddSpecialist '" + identityCard + "', '" + 
						firstName + "', '" + lastName + "', '" + birthday + "', '" + gender + "', '" + 
						rif + "', '" + address + "', '" + email + "'");
			rs = ps.executeQuery();
			if (rs.next()) {
				specialistID = rs.getLong(1);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return specialistID;
	}

}
