package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AddPatientPhoneNumber implements DatabaseCommand {
	
	private Long patientID;
	private String type;
	private String phoneNumber;
		
	public AddPatientPhoneNumber(Long patientID, String type, String phoneNumber){
		this.patientID = patientID;
		this.type = type;
		this.phoneNumber = phoneNumber;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		Long phoneNumberID = null;
		try {
			ps = conn.prepareStatement("exec dbo.AddPatientPhoneNumber " + patientID + ", '" + 
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
