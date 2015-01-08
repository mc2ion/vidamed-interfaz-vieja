package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.PendingEstimationDiscount;

public class GetEstimationDiscountReport implements DatabaseCommand {
	
	private String estimationId 		= null;
	private String identityCard 		= null;
	private String gender		 		= null;
	private String isAdult		 		= null;	
	private String type			 		= null;	
	private String requestFrom		 	= null;
	private String requestTo	 		= null; 
	private String isApproved	 		= null; 
	private String reviewfrom			= null;
	private String reviewto	 			= null;
	
	
	public GetEstimationDiscountReport(){}
	
	public GetEstimationDiscountReport(String estimationId, String identityCard, String gender, String isAdult, String type, 
								String requestFrom, String requestTo, String isApproved, String reviewfrom, String reviewto){
		if (estimationId != null && estimationId != "")
			this.estimationId	    = estimationId;
		if (identityCard != null && identityCard != "")
			this.identityCard  	= "'" + identityCard + "'";
		if (gender != null && gender != "")
			this.gender	    = "'" + gender + "'";
		if (isAdult != null && isAdult != "")
			this.isAdult	    =  isAdult;
		if (type != null && type != "")
			this.type 			= type;
		if (requestFrom != null && requestFrom != "")
			this.requestFrom  = "'" + requestFrom + "'";
		if (requestTo != null && requestTo != "")
			this.requestTo  	=  "'" + requestTo + "'";
		if (isApproved != null && isApproved != "")
			this.isApproved	    = isApproved ;
		if (reviewfrom != null && reviewfrom != ""){
			this.reviewfrom 	= "'" + reviewfrom + "'";
		}
		if (reviewto != null && reviewto != ""){
			this.reviewto   		= "'" + reviewto + "'";
		}
		
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<PendingEstimationDiscount> p = new ArrayList<PendingEstimationDiscount>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetEstimationDiscountReport " + estimationId + "," + identityCard + ","  + gender +   "," +
										isAdult + ","  + type + ","  + requestFrom + "," + requestTo + "," + isApproved + "," + reviewfrom + "," +  reviewto);
			rs = ps.executeQuery();
		
			while (rs.next()) {
				PendingEstimationDiscount e  = new PendingEstimationDiscount();
				e.setDiscountID(rs.getLong(1));
				e.setEstimationID(rs.getLong(2));
				e.setPatientID(rs.getLong(3));
				e.setIdentityCard(rs.getString(4));
				e.setFirstName(rs.getString(5));
				e.setLastName(rs.getString(6));
				e.setGender(rs.getString(7));
				e.setIsAdult(rs.getInt(8));
				e.setAmount(rs.getString(9), rs.getDouble(9));
				e.setType(rs.getString(10));
				e.setJustification(rs.getString(11));
				e.setRequestDate(rs.getString(12));
				e.setIsApproved(rs.getInt(13));
				e.setReviewDate(rs.getString(14));
				
				p.add(e);
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
