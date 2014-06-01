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

public class GetAdmissionReport implements DatabaseCommand {
	
	private String admissionid 		= null;
	private String estimationid		= null;
	private String reasonid			= null; 
	private String admissionfrom	= null;
	private String admissionto		= null;
	private String dischargetypeid	= null;	
	private String dischargefrom	= null;
	private String dischargeto 		= null; 

	public GetAdmissionReport(){}
	
	public GetAdmissionReport(String admissionid,  String estimationid, String reasonid, String admissionfrom, String admissionto,
								String dischargetypeid, String dischargefrom, String dischargeto) throws ParseException{
		
		DateFormat fromFormat = new SimpleDateFormat("dd/MM/yyyy");
		fromFormat.setLenient(false);
		
		DateFormat toFormatF = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
		toFormatF.setLenient(false);
		
		DateFormat toFormatT = new SimpleDateFormat("yyyy-MM-dd 23:59:59");
		toFormatT.setLenient(false);
		
		
		if (admissionid != null && admissionid != "")
			this.admissionid	    =   admissionid;
		if (estimationid != null && estimationid != "")
			this.estimationid	    =  estimationid;
		if (reasonid != null && reasonid != "")
			this.reasonid  	= reasonid;
		if (admissionfrom != null && admissionfrom != ""){
			Date date = fromFormat.parse(admissionfrom);
			this.admissionfrom 		= "'" + toFormatF.format(date) + "'";
		}
		if (admissionto != null && admissionto != ""){
			Date date = fromFormat.parse(admissionto);
			this.admissionto 		= "'" + toFormatT.format(date) + "'";
		}
		if (dischargetypeid != null && dischargetypeid != "")
			this.dischargetypeid  	=  dischargetypeid;
		if (dischargefrom != null && dischargefrom != ""){
			Date date = fromFormat.parse(dischargefrom);
			this.dischargefrom 		= "'" + toFormatF.format(date) + "'";
		}
		if (dischargeto != null && dischargeto != ""){
			Date date = fromFormat.parse(dischargeto);
			this.dischargeto 		= "'" + toFormatT.format(date) + "'";
		}
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
			ps = conn.prepareStatement("exec dbo.GetAdmissionReport " + admissionid + ","  + estimationid + "," + reasonid + "," + admissionfrom + "," +
										admissionto + "," + dischargetypeid + ","  + dischargefrom + "," + dischargeto);
			rs = ps.executeQuery();
		
			while (rs.next()) {
				Admission s = new Admission();
				s.setAdmissionID(rs.getLong(1));
				s.setEstimationID(rs.getLong(2));
				s.setReasonID(rs.getLong(3));
				
				
				String dateStr = rs.getString(4);
				Date date;
				try {
					if (dateStr != null){
						date = fromFormat.parse(dateStr);
						s.setAdmissionDate(toFormat.format(date));
					}
				} catch (ParseException e1) {
					e1.printStackTrace();
				}
				
				s.setDischargeTypeID(rs.getLong(5));
				s.setDischargeName(rs.getString(6));
				
				dateStr = rs.getString(7);
				try {
					if (dateStr != null){
						date = fromFormat.parse(dateStr);
						s.setDischargeDate(toFormat.format(date));
					}
				} catch (ParseException e1) {
					e1.printStackTrace();
				}
			
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
