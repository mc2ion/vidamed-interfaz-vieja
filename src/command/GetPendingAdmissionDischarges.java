package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.Patient;
import domain.PendingAdmissionDischarges;
import domain.Specialist;

public class GetPendingAdmissionDischarges implements DatabaseCommand {
	
	public GetPendingAdmissionDischarges(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<PendingAdmissionDischarges> admissions = new ArrayList<PendingAdmissionDischarges>();;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetPendingAdmissionDischarges");
			rs = ps.executeQuery();

			while (rs.next()) {
				PendingAdmissionDischarges u = new PendingAdmissionDischarges();
				u.setAdmissionID(rs.getLong(1));
				u.setEstimationID(rs.getLong(2));
				
				Patient p = new Patient();
				p.setPatientID(rs.getLong(3));
				p.setFirstName(rs.getString(4));
				p.setLastName(rs.getString(5));
				u.setPatient(p);
				
				Specialist e = new Specialist();
				e.setId(rs.getLong(6));
				e.setFirstName(rs.getString(7));
				e.setLastName(rs.getString(8));
				u.setSpecialist(e);
				
				u.setAdmissionDate(rs.getString(9));
				u.setDischargeDate(rs.getString(10));
				
				admissions.add(u);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return admissions;
	}

}