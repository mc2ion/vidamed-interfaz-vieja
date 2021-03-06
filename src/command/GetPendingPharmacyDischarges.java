package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import domain.Patient;
import domain.PendingPharmacyDischarges;
import domain.Specialist;

public class GetPendingPharmacyDischarges implements DatabaseCommand {
	
	public GetPendingPharmacyDischarges(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<PendingPharmacyDischarges> admissions = new ArrayList<PendingPharmacyDischarges>();;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		DateFormat fromFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		fromFormat.setLenient(false);
		
		DateFormat toFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		toFormat.setLenient(false);
		
		try {
			ps = conn.prepareStatement("exec dbo.GetPendingPharmacyDischarges");
			rs = ps.executeQuery();

			while (rs.next()) {
				PendingPharmacyDischarges u = new PendingPharmacyDischarges();
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
				
				String dateStr = rs.getString(9);
				Date date;
				try {
					date = fromFormat.parse(dateStr);
					u.setAdmissionDate(toFormat.format(date));
				} catch (ParseException e1) {
					e1.printStackTrace();
				}
					
				dateStr = rs.getString(10);
				try {
					date = fromFormat.parse(dateStr);
					u.setDischargeDate(toFormat.format(date));
				} catch (ParseException e1) {
					e1.printStackTrace();
				}

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
