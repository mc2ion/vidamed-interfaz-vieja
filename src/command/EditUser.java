package command;

import java.sql.CallableStatement;
import java.sql.Connection;
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
		CallableStatement cstmt = null;
		try {
			  cstmt = conn.prepareCall("{? = call dbo.EditUser(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
		      cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
		      cstmt.setString(2, identityCard);
		      cstmt.setString(3, firstName);
		      cstmt.setString(4, lastName);
		      cstmt.setString(5, birthday);
		      cstmt.setString(6, gender);
		      cstmt.setString(7, address);
		      cstmt.setString(8, email);
		      cstmt.setLong(9, userUnitID);
		      cstmt.setString(10, startDate);
		      cstmt.setString(11, position);
		      cstmt.setDouble(12, salary);
		      cstmt.setString(13, username);
		      cstmt.setLong(14, userID);
		      
		      cstmt.execute();
		      return cstmt.getInt(1);
		}
		catch (Exception e) {
			e.printStackTrace();
			return -3;
		}
		finally {
			cstmt.close();
		}		
	}

}
