package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.Patient;

public class GetPatients implements DatabaseCommand {

	public GetPatients(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<Patient> patients = new ArrayList<Patient>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetPatients");
			rs = ps.executeQuery();

			while(rs.next()) {
				Patient p = new Patient();
				p.setPatientID(rs.getLong(1));
				p.setIsAdult(rs.getInt(2));
				p.setIdentityCard(rs.getString(3));
				p.setFirstName(rs.getString(4));
				p.setLastName(rs.getString(5));
				p.setBirthday(rs.getString(6));
				p.setGender(rs.getString(7));
				p.setAddress(rs.getString(8));
				p.setEmail(rs.getString(9));
				
				patients.add(p);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return patients;
	}

}
