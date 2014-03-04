package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditSpecialist implements DatabaseCommand {
	
	private Long specialistID;
	private String identityCard;
	private String firstName;
	private String lastName;
	private String birthday;
	private String gender;
	private String rif;
	private String address;
	private String email;
	
	public EditSpecialist(Long specialistID, String identityCard, String firstName, String lastName, 
			String birthday, String gender, String rif, String address, String email){
		this.specialistID = specialistID;
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
		try {
			ps = conn.prepareStatement("exec dbo.EditSpecialist '" + identityCard + "', '" + firstName + "', '" +
						lastName + "', '" + birthday + "', '" + gender + "', '" + rif + "', '" + address + "', '" + 
						email + "', " + specialistID);
			ps.execute();
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
