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

import domain.Admission;

public class GetAdmissionsByPatient implements DatabaseCommand {
	
	private String identityCard 	= null;

	public GetAdmissionsByPatient(String identityCard) throws ParseException{
		this.identityCard = "'" + identityCard + "'";
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<Admission> p = new ArrayList<Admission>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		DateFormat fromFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		fromFormat.setLenient(false);
		DateFormat toFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		toFormat.setLenient(false);
		
		
		try {
			ps = conn.prepareStatement("exec dbo.GetAdmissionsByPatient " + identityCard);
			rs = ps.executeQuery();
		
			while (rs.next()) {
				Admission s = new Admission();
				s.setAdmissionID(rs.getLong(1));
				s.setEstimationID(rs.getLong(2));
				s.setPatientID(rs.getLong(3));
				s.setIsAdult(rs.getInt(4));
				s.setIdentityCard(rs.getString(5));
				s.setFirstName(rs.getString(6));
				s.setLastName(rs.getString(7));
				
				String dateStr = rs.getString(8);
				Date date;
				try {
					if (dateStr != null){
						date = fromFormat.parse(dateStr);
						s.setAdmissionDate(toFormat.format(date));
					}
				} catch (ParseException e1) {
					e1.printStackTrace();
				}
				
				s.setWasDischarge(rs.getInt(9));
				dateStr = rs.getString(10);
				try {
					if (dateStr != null){
						date = fromFormat.parse(dateStr);
						s.setDischargeDate(toFormat.format(date));
					}
				} catch (ParseException e1) {
					e1.printStackTrace();
				}
				s.setTotal(rs.getString(11), rs.getDouble(11));
				s.setTotalPaid(rs.getString(12), rs.getDouble(12));
				s.setWasPaid(rs.getInt(13));
				
				p.add(s);
			}
		}catch(Exception e){
			e.getStackTrace();
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return p;
	}

}
