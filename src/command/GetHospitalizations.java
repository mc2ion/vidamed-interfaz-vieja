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

import domain.Bed;
import domain.Hospitalization;
import domain.LocationType;
import domain.Patient;

public class GetHospitalizations implements DatabaseCommand {
	
	public GetHospitalizations(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<Hospitalization> hosp = new ArrayList<Hospitalization>();;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetHospitalizations");
			rs = ps.executeQuery();

			while (rs.next()) {
				Hospitalization u = new Hospitalization();
				u.setId(rs.getLong(1));
				u.setEstimationId(rs.getLong(2));
				
				Patient p = new Patient();
				p.setPatientID(rs.getLong(3));
				p.setFirstName(rs.getString(4));
				p.setLastName(rs.getString(5));
				p.setIsAdult(rs.getInt(6));
				u.setPatient(p);
				
				Bed b = new Bed();
				b.setId(rs.getLong(7));
				b.setName(rs.getString(8));
				u.setBed(b);
				
				LocationType l = new LocationType();
				l.setId(rs.getInt(9));
				l.setName(rs.getString(10));
				u.setLocation(l);
				
				DateFormat fromFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				fromFormat.setLenient(false);
				DateFormat toFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
				toFormat.setLenient(false);
				
				String dateStr = rs.getString(11);
				Date date;
				try {
					if (dateStr != null){
						date = fromFormat.parse(dateStr);
						u.setAdmissionDate(toFormat.format(date));
					}
				} catch (ParseException e1) {
					e1.printStackTrace();
				}
				
				
				hosp.add(u);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return hosp;
	}

}
