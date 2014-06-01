package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.Patient;
import domain.PatientMedicalAdvice;
import domain.Specialist;

public class GetPatientMedicalAdviceReport implements DatabaseCommand {
	
	private String estimationId 		= null;
	private String admissionid 			= null;
	private String identityCard 		= null;
	private String gender		 		= null;
	private String isAdult		 		= null;	

	private String unitId		 		= null;
	private String sIdentityCard 		= null; 
	private String sRif			 		= null; 
	private String sGender			  	= null;
	private String from	 				= null;
	private String to		 			= null;
	
	

	
	public GetPatientMedicalAdviceReport(){}
	
	public GetPatientMedicalAdviceReport(String admissionId, String estimationId, String identityCard, String gender, String isAdult, String unitId, 
								String sIdentityCard, String sRif, String sGender, String from, String to){
		if (admissionId != null && admissionId != "")
			this.admissionid	    = admissionId;
		if (estimationId != null && estimationId != "")
			this.estimationId	    = estimationId;
		if (identityCard != null && identityCard != "")
			this.identityCard  	= "'" + identityCard + "'";
		if (gender != null && gender != "")
			this.gender	    = "'" + gender + "'";
		if (isAdult != null && isAdult != "")
			this.isAdult	    =  isAdult;
		if (unitId != null && unitId != "")
			this.unitId 		= unitId;
		if (sIdentityCard != null && sIdentityCard != "")
			this.sIdentityCard  = "'" + sIdentityCard + "'";
		if (sRif != null && sRif != "")
			this.sRif  	=  sRif;
		if (sGender != null && sGender != "")
			this.sGender	    = "'" + sGender + "'";
		if (from != null && from != ""){
			this.from 		= "'" + from + "'";
		}
			
		if (to != null && to != ""){
			this.to   		= "'" + to + "'";
		}
		
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<PatientMedicalAdvice> p = new ArrayList<PatientMedicalAdvice>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetPatientMedicalAdviceReport " + admissionid + "," + estimationId + "," + identityCard + ","  + gender +   "," +
										isAdult + ","  + unitId + ","  + sIdentityCard + "," + sRif + "," + sGender + "," + from + "," +  to);
			rs = ps.executeQuery();
		
			while (rs.next()) {
				PatientMedicalAdvice s = new PatientMedicalAdvice();
				s.setPatientMedicalAdviceID(rs.getLong(1));
				s.setAdmissionID(rs.getLong(2));
				s.setEstimationID(rs.getLong(3));
				
				Patient pa = new Patient();
				pa.setPatientID(rs.getLong(4));
				pa.setIdentityCard(rs.getString(5));
				pa.setFirstName(rs.getString(6));
				pa.setLastName(rs.getString(7));
				pa.setGender(rs.getString(8));
				pa.setIsAdult(rs.getInt(9));
				s.setPatient(pa);
				
			
			    s.setUnitID(rs.getLong(10));
			    s.setUnitName(rs.getString(11));
			    
			    Specialist e = new Specialist();
			    e.setId(rs.getLong(12));
			    e.setIdentityCard(rs.getString(13));
			    e.setFirstName(rs.getString(14));
				e.setLastName(rs.getString(15));
				e.setRif(rs.getString(16));
				e.setSex(rs.getString(17));
			    s.setSpecialist(e);
			    
			    s.setMedicalFeed(rs.getDouble(18));
			    s.setMedicalAdviceDate(rs.getString(19));
				
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
