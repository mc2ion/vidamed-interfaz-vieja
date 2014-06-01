package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import domain.Bed;
import domain.Hospitalization;
import domain.LocationType;
import domain.Patient;
import domain.PaymentResponsible;
import domain.Specialist;
import domain.Unit;

public class GetHospitalization implements DatabaseCommand {
	
	private Long id;
	
	public GetHospitalization(long id){
		this.id = id;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		

		Hospitalization u = new Hospitalization();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetHospitalization " + id);
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
				
				DateFormat fromFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				fromFormat.setLenient(false);
				DateFormat toFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
				toFormat.setLenient(false);
				
				String dateStr = rs.getString(12);
				Date date;
				try {
					if (dateStr != null){
						date = fromFormat.parse(dateStr);
						u.setAdmissionDate(toFormat.format(date));
					}
				} catch (ParseException e1) {
					e1.printStackTrace();
				}
				
				//u.setAdmissionDate(rs.getString(12));
				
				Specialist e = new Specialist();
				e.setId(rs.getLong(13));
				e.setFirstName(rs.getString(14));
				e.setLastName(rs.getString(15));
				u.setSpecialist(e);
				
				Unit un = new Unit();
				un.setUnitID(rs.getLong(16));
				un.setName(rs.getString(17));
				u.setUnit(un);
				
				PaymentResponsible r = new PaymentResponsible();
				r.setId(rs.getLong(18));
				r.setName(rs.getString(19));
				u.setResponsible(r);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return u;
	}

}
