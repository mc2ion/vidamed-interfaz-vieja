package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import domain.Patient;

public class GetPatient implements DatabaseCommand {

	private Long patientID;
	
	public GetPatient(Long patientID){
		this.patientID = patientID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		Patient p = null;
		PreparedStatement ps = null; 
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetPatient " + patientID);
			rs = ps.executeQuery();

			if (rs.next()) {
				p = new Patient();
				p.setPatientID(rs.getLong(1));
				p.setIsAdult(rs.getInt(2));
				p.setIdentityCard(rs.getString(3));
				p.setFirstName(rs.getString(4));
				p.setLastName(rs.getString(5));
				p.setBirthday(rs.getString(6));
				p.setGender(rs.getString(7));
				p.setAddress(rs.getString(8));
				p.setEmail(rs.getString(9));
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return p;
	}


}
