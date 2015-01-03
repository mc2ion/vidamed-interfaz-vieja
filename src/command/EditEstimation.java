package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditEstimation implements DatabaseCommand {
	
	private String patientid;
	private String unitid;
	private String specialistid;
	private String paymentresponsibleid;
	private String hasguaranteeletter;
	private String ispolicyholder;
	private String policyholderidentitycard;
	private String policyholdername;
	private String clinictypeid;
	private String estimationid;
	private String userid;
	
	
	public EditEstimation(String patientid, String unitid, String specialistid, String paymentresponsibleid, String hasguaranteeletter, 
			String ispolicyholder, String policyholderidentitycard, String policyholdername, String clinictypeid, String estimationid, String userid) {
		this.patientid 				    = patientid;
		this.unitid 		 		    = unitid;
		this.specialistid 	 		    = specialistid;
		this.paymentresponsibleid	    = paymentresponsibleid;
		if (hasguaranteeletter == null) this.hasguaranteeletter 	= "0";
		else this.hasguaranteeletter    = hasguaranteeletter;
		if (ispolicyholder == null) this.ispolicyholder 	= "0";
		else this.ispolicyholder 		    = ispolicyholder;
		this.policyholderidentitycard 	= policyholderidentitycard;
		this.policyholdername 		    = policyholdername;
		this.clinictypeid 			    = clinictypeid;	
		this.estimationid 			    = estimationid;	
		this.userid						= userid;
		
		System.out.println(this.patientid + " " + this.unitid + " "+ this.specialistid + " "+ this.paymentresponsibleid + " "+ this.hasguaranteeletter + " "+ 
				this.ispolicyholder + " " + this.policyholderidentitycard + " " + this.policyholdername + " "+ this.clinictypeid + " " + this.estimationid);

	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		try {
			if (policyholderidentitycard == null){
				ps = conn.prepareStatement("exec dbo.EditEstimation '" + patientid + "', '" + unitid + "', '" + 
						specialistid + "', '" + paymentresponsibleid + "', '" + hasguaranteeletter + "', '" + ispolicyholder + "', '" + clinictypeid+ "', '"+
						userid + "','" +estimationid + "'" );
			}else{
				ps = conn.prepareStatement("exec dbo.EditEstimation '" + patientid + "', '" + unitid + "', '" + 
						specialistid + "', '" + paymentresponsibleid + "', '" + hasguaranteeletter + "', '" + ispolicyholder + "', '" + clinictypeid+ "','"+
						userid + "','" + estimationid + "','" +policyholderidentitycard + "', '"+ policyholdername + "'");
			}
			ps.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
