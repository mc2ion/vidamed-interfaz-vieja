package command;

import java.sql.CallableStatement;
import java.sql.Connection;
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
		
		CallableStatement cstmt = null;
		try {
			  cstmt = conn.prepareCall("{? = call dbo.EditSpecialist(?,?,?,?,?,?,?,?,?)}");
		      cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
		      cstmt.setString(2, identityCard);
		      cstmt.setString(3, firstName);
		      cstmt.setString(4, lastName);
		      cstmt.setString(5, birthday);
		      cstmt.setString(6, gender);
		      cstmt.setString(7, rif);
		      cstmt.setString(8, address);
		      cstmt.setString(9, email);
		      cstmt.setLong(10, specialistID);
		      
		      cstmt.execute();
		      System.out.println("id " +  cstmt.getInt(1) );
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
