package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import domain.PatientMedicalAdvice;
import domain.Specialist;

public class GetPatientMedicalAdvice implements DatabaseCommand {
	
	private Long medicalAdviceId;
	
	
	public GetPatientMedicalAdvice(Long medicalAdviceId){
		this.medicalAdviceId = medicalAdviceId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PatientMedicalAdvice pm = new PatientMedicalAdvice();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetPatientMedicalAdvice " + medicalAdviceId);
			rs = ps.executeQuery();

			if (rs.next()) {
				pm.setPatientMedicalAdviceID(rs.getLong(1));
				pm.setAdmissionID(rs.getLong(2));
				pm.setUnitID(rs.getLong(3));
				Specialist e = new Specialist();
				e.setId(rs.getLong(4));
				pm.setSpecialist(e);
				pm.setMedicalFeed(rs.getDouble(5));
				pm.setMedicalAdviceTypeID(rs.getInt(6));
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return pm;
	}

}
