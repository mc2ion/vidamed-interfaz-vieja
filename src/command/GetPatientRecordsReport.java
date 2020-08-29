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

import domain.PatientRecord;

public class GetPatientRecordsReport implements DatabaseCommand {

	private String from = null;	
	private String to = null;
	
	public GetPatientRecordsReport(){}
	
	public GetPatientRecordsReport(String from, String to) throws ParseException{
		
		if (from != null && from != ""){
			DateFormat fromFormat = new SimpleDateFormat("dd/MM/yyyy");
			fromFormat.setLenient(false);
			
			DateFormat toFormat = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
			toFormat.setLenient(false);
			Date date = fromFormat.parse(from);
			this.from 		= "'" + toFormat.format(date) + "'";
		}
		if (to != null && to != ""){
			DateFormat fromFormat = new SimpleDateFormat("dd/MM/yyyy");
			fromFormat.setLenient(false);
			
			DateFormat toFormat = new SimpleDateFormat("yyyy-MM-dd 23:59:59");
			toFormat.setLenient(false);
			
			Date date = fromFormat.parse(to);
			this.to   		= "'" + toFormat.format(date) + "'";
		}
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		ArrayList<PatientRecord> pList = new ArrayList<PatientRecord>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			System.out.println("this.from: " + this.from + ", this.to:" + this.to);
			ps = conn.prepareStatement("exec GetPatientRecordsReport " + this.from + "," + this.to);
			rs = ps.executeQuery();

			while (rs.next()) {
				PatientRecord u = new PatientRecord();		
				
				u.setAdmissionID(rs.getLong(1));
				u.setAdmissionDate(rs.getString(2));
				u.setPatientName(rs.getString(3));
				u.setIdentityCard(rs.getString(4));
				u.setAge(rs.getString(5));
				u.setGender(rs.getString(6));
				u.setDiagnosis(rs.getString(7));
				u.setProtocolName(rs.getString(8));
				u.setType(rs.getString(9));
				u.setAttendingSpecialist(rs.getString(10));
				u.setHelper1(rs.getString(11));
				u.setHelper2(rs.getString(12));
				u.setAnesthesiologist(rs.getString(13));
				u.setRoomDays(rs.getString(14));
				u.setDischargeDate(rs.getString(15));
				
				pList.add(u);
			}
		}catch(Exception e){
			e.getStackTrace();
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return pList;
	}

}
