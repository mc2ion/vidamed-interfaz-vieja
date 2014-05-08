package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.PatientMedicalAdvice;
import domain.Specialist;

public class GetPatientMedicalAdvicesByAdmission implements DatabaseCommand {
	
	private Long id;
	
	public GetPatientMedicalAdvicesByAdmission(long id){
		this.id = id;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		

		ArrayList<PatientMedicalAdvice> list = new ArrayList<PatientMedicalAdvice>();
				
				
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetPatientMedicalAdvicesByAdmission " + id);
			rs = ps.executeQuery();

			while (rs.next()) {
				PatientMedicalAdvice u = new PatientMedicalAdvice();
				u.setAdmissionID(rs.getLong(1));
				u.setPatientMedicalAdviceID(rs.getLong(2));
				u.setUnitID(rs.getLong(3));
				u.setUnitName(rs.getString(4));
				
				Specialist p = new Specialist();
				p.setId(rs.getLong(5));
				p.setFirstName(rs.getString(6));
				p.setLastName(rs.getString(7));
				u.setSpecialist(p);
				
				u.setMedicalFeed(rs.getDouble(8));;
				u.setMedicalAdviceDate(rs.getString(9));
				list.add(u);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return list;
	}

}
