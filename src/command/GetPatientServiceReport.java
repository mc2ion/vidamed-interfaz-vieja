package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;

import domain.Patient;
import domain.PatientServiceReport;

public class GetPatientServiceReport implements DatabaseCommand {
	
	private String serviceTypeId 	= null;
	private String admissionId 		= null; 
	private String estimationId 	= null;
	private String identityCard     = null;
	private String gender    		= null;
	private String isAdult	 		= null;
	private String serviceId	 	= null;
	private String from	 			= null;
	private String to	 			= null;
	

	
	public GetPatientServiceReport(String serviceTypeId){
		this.serviceTypeId = serviceTypeId;
	}
	
	public GetPatientServiceReport(String serviceTypeId, String admissionId, String estimationId, String identityCard, String gender, String isAdult,
								  String serviceId, String from, String to) throws ParseException{
		if (from != null && from != "")
			this.from 		= "'" + from + "'";
		if (to != null && to != "")
			this.to   		= "'" + to + "'";
		if (serviceTypeId != null && serviceTypeId != "")
			this.serviceTypeId  = serviceTypeId;
		if (admissionId != null && admissionId != "")
			this.admissionId  = admissionId;
		if (estimationId != null && estimationId != "")
			this.estimationId  = estimationId;
		if (identityCard != null && identityCard != "")
			this.identityCard  	= "'" + identityCard + "'";
		if (gender != null && gender != "")
			this.gender	    = "'" + gender + "'";
		if (isAdult != null && isAdult != "")
			this.isAdult	    = isAdult;
		if (serviceId != null && serviceId != "")
			this.serviceId	    = serviceId;
		
		
		
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<PatientServiceReport> p = new ArrayList<PatientServiceReport>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetPatientServiceReport " + serviceTypeId + ","  + admissionId + "," + estimationId + "," + identityCard + "," 
									  + gender + "," + isAdult + "," + serviceId + "," + from + "," + to);
			
			
			rs = ps.executeQuery();
			
			while (rs.next()) {
				PatientServiceReport u = new PatientServiceReport();
				u.setServicePatientID(rs.getLong(1));
				u.setAdmissionID(rs.getLong(2));
				u.setEstimationID(rs.getLong(3));
				
				Patient pa = new Patient();
				pa.setPatientID(rs.getLong(4));
				pa.setIdentityCard(rs.getString(5));
				pa.setFirstName(rs.getString(6));
				pa.setLastName(rs.getString(7));
				pa.setGender(rs.getString(8));
				pa.setIsAdult(rs.getInt(9));
				u.setPatient(pa);
			
					
				u.setServiceTypeID(rs.getLong(10));
				u.setServiceTypeName(rs.getString(11));
				u.setServiceID(rs.getLong(12));
				u.setServiceName(rs.getString(13));
				u.setAssociatedFile(rs.getString(14));
				u.setPrice(rs.getString(15));
				
				/*DateFormat fromFormat = new SimpleDateFormat("yyyy-MM-dd");
				fromFormat.setLenient(false);
				
				DateFormat toFormat = new SimpleDateFormat("dd/MM/yyyy");
				toFormat.setLenient(false);
				
				String dateStr = rs.getString(16);
				Date date;
				try {
					date = fromFormat.parse(dateStr);
					u.setServiceDate(toFormat.format(date));
				} catch (ParseException e1) {
					e1.printStackTrace();
				}*/
				
				u.setServiceDate(rs.getString(16));
				
				
				p.add(u);
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
