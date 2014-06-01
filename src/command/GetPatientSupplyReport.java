package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.Patient;
import domain.PatientSupply;
import domain.Supply;

public class GetPatientSupplyReport implements DatabaseCommand {
	
	private String estimationId 		= null;
	private String admissionid 			= null;
	private String identityCard 		= null;
	private String gender		 		= null;
	private String isAdult		 		= null;	

	private String supplyFormId 		= null;
	private String supplyId 			= null; 
	private String supplyAreaId 		= null; 
	private String type			    	= null;
	private String activeComponent 	    = null;
	private String manufacturer	 		= null;
	private String from	 				= null;
	private String to		 			= null;
	private String isRegulated	 		= null;
	
	

	
	public GetPatientSupplyReport(){}
	
	public GetPatientSupplyReport(String admissionId, String estimationId, String identityCard, String gender, String isAdult, String supplyFormId, 
								String supplyId, String supplyAreaId, String type, String activeComponent, String manufacturer,
							String from, String to, String isRegulated){
		if (admissionId != null && admissionId != "")
			this.admissionid	    = admissionId;
		if (estimationId != null && estimationId != "")
			this.estimationId	    = estimationId;
		if (identityCard != null && identityCard != "")
			this.identityCard  	= "'" + identityCard + "'";
		if (gender != null && gender != "")
			this.gender	    = "'" + gender + "'";
		if (isAdult != null && isAdult != "")
			this.isAdult	    = "'" + isAdult + "'";
		if (supplyFormId != null && supplyFormId != "")
			this.supplyFormId 		= supplyFormId;
		if (supplyAreaId != null && supplyAreaId != "")
			this.supplyAreaId  		= supplyAreaId;
		if (supplyId != null && supplyId != "")
			this.supplyId  	=  supplyId;
		if (type != null && type != "")
			this.type	    = type;
		if (activeComponent != null && activeComponent != "")
			this.activeComponent	    = "'" + activeComponent + "'";
		if (manufacturer != null && manufacturer != "")
			this.manufacturer  = "'" + manufacturer + "'";
		
		if (from != null && from != ""){
			this.from 		= "'" + from + "'";
		}
			
		if (to != null && to != ""){
			this.to   		= "'" + to + "'";
		}
		if (isRegulated != null && isRegulated != "")
			this.isRegulated  = isRegulated;
		
		
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<PatientSupply> p = new ArrayList<PatientSupply>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetPatientSupplyReport " + admissionid + "," + estimationId + "," + identityCard + ","  + gender +   "," +
										isAdult + ","  + supplyAreaId + ","  + supplyId + "," + type + "," + activeComponent + "," + manufacturer
										+ "," +  supplyFormId + "," + isRegulated + "," + from + "," +  to);
			rs = ps.executeQuery();
		
			while (rs.next()) {
				PatientSupply s = new PatientSupply();
				s.setPatientSupplyID(rs.getLong(1));
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
				
				
				Supply su = new Supply();
				su.setSupplyAreaID(rs.getLong(10));
				su.setSupplyAreaName(rs.getString(11));
				su.setSupplyID(rs.getLong(12));
				su.setName(rs.getString(13));
				su.setType(rs.getInt(14));
				su.setActiveComponent(rs.getString(15));
				su.setManufacturer(rs.getString(16));
				su.setSupplyFormID(rs.getLong(17));
				su.setSupplyFormName(rs.getString(18));
				su.setIsRegulated(rs.getInt(19));
				su.setAmount(rs.getLong(20));
				su.setUnitPrice(rs.getDouble(21));
				s.setSupply(su);
				
				s.setTotal(rs.getString(22));
				s.setSupplyDate(rs.getString(23));
				
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
