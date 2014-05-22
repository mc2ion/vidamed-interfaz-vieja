package command;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AddUser implements DatabaseCommand {
	
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
	private String password;
		
	public AddUser(String identityCard, String firstName, String lastName, String birthday, 
			String gender, String address, String email, Long userUnitID, String startDate,
			String position, Double salary, String username, String password) {
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
		this.password = password;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		Long userID = null;
		try {
			ps = conn.prepareStatement("exec dbo.AddUser '" + identityCard + "', '" + 
						firstName + "', '" + lastName + "', '" + birthday + "', '" + gender + "', '" + 
						address + "', '" + email + "', " + userUnitID + ", '" + startDate + "', '" +
						position + "', " + salary + ", '" + username + "', '" + password + "'");
			rs = ps.executeQuery();
			if (rs.next()) {
				userID = rs.getLong(1);
			}else{
			  CallableStatement cstmt = conn.prepareCall("{? = call dbo.AddUser(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
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
		      cstmt.setString(14, password);
		      
		      cstmt.execute();
		      return cstmt.getLong(1);
			}
			
		}
		catch (Exception e) {
			e.printStackTrace();
			return -3;
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return userID;
	}

}
