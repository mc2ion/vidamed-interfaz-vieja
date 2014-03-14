package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditUser implements DatabaseCommand {
	
	private Long userID;
	private String identityCard;
	private String firstName;
	private String lastName;
	private String birthday;
	private String gender;
	private String address;
	private String email;
	private Long userUnitID;
	private String startDate;
	private String position;
	private Double salary;
	private String username;
		
	public EditUser(Long userID, String identityCard, String firstName, String lastName, String birthday, 
			String gender, String address, String email, Long userUnitID, String startDate,
			String position, Double salary, String username) {
		this.userID = userID;
		this.identityCard = identityCard;
		this.firstName = firstName;
		this.lastName = lastName;
		this.birthday = birthday;
		this.gender = gender;
		this.address = address;
		this.email = email;
		this.userUnitID = userUnitID;
		this.startDate = startDate;
		this.position = position;
		this.salary = salary;
		this.username = username;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement("exec dbo.EditUser '" + identityCard + "', '" + 
						firstName + "', '" + lastName + "', '" + birthday + "', '" + gender + "', '" + 
						address + "', '" + email + "', " + userUnitID + ", '" + startDate + "', '" +
						position + "', " + salary + ", '" + username + "', " + userID);
			ps.execute();
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
