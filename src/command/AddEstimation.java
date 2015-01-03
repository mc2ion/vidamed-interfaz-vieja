package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AddEstimation implements DatabaseCommand {
	
	private String patientid;
	private String unitid;
	private String specialistid;
	private String paymentresponsibleid;
	private String hasguaranteeletter;
	private String ispolicyholder;
	private String policyholderidentitycard;
	private String policyholdername;
	private String clinictypeid;
	private String userid;
	
	public AddEstimation(String patientid, String unitid, String specialistid, String paymentresponsibleid, String hasguaranteeletter, 
			String ispolicyholder, String policyholderidentitycard, String policyholdername, String clinictypeid, String userId) {
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
		this.userid						= userId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		Long estimationID = null;
		try {
			if (policyholderidentitycard == null){
				ps = conn.prepareStatement("exec dbo.AddEstimation '" + patientid + "', '" + unitid + "', '" + 
						specialistid + "', '" + paymentresponsibleid + "', '" + hasguaranteeletter + "', '" + ispolicyholder + "', '" + clinictypeid+ "', '"+ userid + "'");
			}else{
				ps = conn.prepareStatement("exec dbo.AddEstimation '" + patientid + "', '" + unitid + "', '" + 
						specialistid + "', '" + paymentresponsibleid + "', '" + hasguaranteeletter + "', '" + ispolicyholder + "', '" + 
						"','"+clinictypeid+ "', '" + userid + "', '" + policyholderidentitycard + "', '"+ policyholdername + "'");
			}
			rs = ps.executeQuery();
			if (rs.next()) {
				estimationID = rs.getLong(1);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return estimationID;
	}

}
