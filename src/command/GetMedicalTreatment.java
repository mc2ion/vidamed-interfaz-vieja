package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import domain.Bed;
import domain.LocationType;
import domain.MedicalTreatment;
import domain.Patient;

public class GetMedicalTreatment implements DatabaseCommand {
	
	private Long id;
	
	public GetMedicalTreatment(long id){
		this.id = id;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		

		MedicalTreatment u = new MedicalTreatment();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetMedicalTreatment " + id);
			rs = ps.executeQuery();

			if (rs.next()) {
				u.setId(rs.getLong(1));
				u.setEstimationId(rs.getLong(2));
				
				Patient p = new Patient();
				p.setPatientID(rs.getLong(3));
				p.setIdentityCard(rs.getString(4));
				p.setFirstName(rs.getString(5));
				p.setLastName(rs.getString(6));
				p.setIsAdult(rs.getInt(7));
				u.setPatient(p);
				
				Bed b = new Bed();
				b.setId(rs.getLong(8));
				b.setName(rs.getString(9));
				u.setBed(b);
				
				LocationType l = new LocationType();
				l.setId(rs.getInt(10));
				l.setName(rs.getString(11));
				u.setLocation(l);
				u.setAdmissionDate(rs.getString(12));
			
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return u;
	}

}
