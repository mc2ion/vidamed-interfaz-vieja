package command;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class EditPatient implements DatabaseCommand {

	private Long patientID;
	private String identityCard;
	private int isAdult;
	private String firstName;
	private String lastName;
	private String birthday;
	private String gender;
	private String address;
	private String email;
	
	public EditPatient(String identityCard, int isAdult, String firstName, String lastName, String birthday, 
			String gender, String address, String email, Long patientID){
		this.patientID = patientID;
		this.identityCard = identityCard;
		this.isAdult = isAdult;
		this.firstName = firstName;
		this.lastName = lastName;
		this.birthday = birthday;
		this.gender = gender;
		this.address = address;
		this.email = email;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		CallableStatement cstmt = null;
		try {
			  cstmt = conn.prepareCall("{? = call dbo.EditPatient(?,?,?,?,?,?,?,?,?)}");
		      cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
		      cstmt.setInt(2, isAdult);
		      cstmt.setString(3, identityCard);
		      cstmt.setString(4, firstName);
		      cstmt.setString(5, lastName);
		      cstmt.setString(6, birthday);
		      cstmt.setString(7, gender);
		      cstmt.setString(8, address);
		      cstmt.setString(9, email);
		      cstmt.setLong(10, patientID);
		      
		      cstmt.execute();
		      return cstmt.getInt(1);
		      
		}
		catch (Exception e) {
			e.printStackTrace();
			return -2;
		}
		finally {
			cstmt.close();
		}		
	}

}
