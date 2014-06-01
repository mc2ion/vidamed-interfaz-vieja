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

import domain.MedicalFee;
import domain.PendingBills;
import domain.Specialist;

public class GetMedicalFeeReport implements DatabaseCommand {
	
	private String identityCard 		= null;
	private String gender		 		= null;
	private String rif			 		= null; 
	private String billId		 		= null;
	private String billWasGenerated		= null;
	private String billgenerationfrom	= null;	
	private String billgenerationto		= null;
	private String billwaspaid 			= null; 
	private String billpaymentfrom		= null;
	private String billpaymentto		= null;
	private String ispromptpayment		= null;
	private String waspaid				= null;
	private String paymentfrom			= null;
	private String paymentto			= null;
	
	
	

	
	public GetMedicalFeeReport(){}
	
	public GetMedicalFeeReport(String identityCard, String gender, String rif, String billId, String billWasGenerated, String billgenerationfrom,
								String billgenerationto, String billwaspaid, String billpaymentfrom, String billpaymentto, String ispromptpayment,
								String waspaid, String paymentfrom, String paymentto) throws ParseException{
		
		DateFormat fromFormat = new SimpleDateFormat("dd/MM/yyyy");
		fromFormat.setLenient(false);
		
		DateFormat toFormatF = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
		toFormatF.setLenient(false);
		
		DateFormat toFormatT = new SimpleDateFormat("yyyy-MM-dd 23:59:59");
		toFormatT.setLenient(false);
		
		
		if (identityCard != null && identityCard != "")
			this.identityCard	    =  "'" + identityCard+ "'";
		if (gender != null && gender != "")
			this.gender	    =  "'" + gender+ "'";
		if (rif != null && rif != "")
			this.rif  	= "'" + rif + "'";
		if (billId != null && billId != "")
			this.billId	    = billId;
		if (billWasGenerated != null && billWasGenerated != "")
			this.billWasGenerated	    =  billWasGenerated;
		if (billgenerationfrom != null && billgenerationfrom != ""){
			Date date = fromFormat.parse(billgenerationfrom);
			this.billgenerationfrom 		= "'" + toFormatF.format(date) + "'";
		}
		if (billgenerationto != null && billgenerationto != ""){
			Date date = fromFormat.parse(billgenerationto);
			this.billgenerationto 		= "'" + toFormatT.format(date) + "'";
		}
		if (billwaspaid != null && billwaspaid != "")
			this.billwaspaid  	=  billwaspaid;
		if (billpaymentfrom != null && billpaymentfrom != ""){
			Date date = fromFormat.parse(billpaymentfrom);
			this.billpaymentfrom 		= "'" + toFormatF.format(date) + "'";
		}
		if (billpaymentto != null && billpaymentto != ""){
			Date date = fromFormat.parse(billpaymentto);
			this.billpaymentto 		= "'" + toFormatT.format(date) + "'";
		}
		if (ispromptpayment != null && ispromptpayment != ""){
			this.ispromptpayment   		= ispromptpayment ;
		}
		if (waspaid != null && waspaid != ""){
			this.waspaid   		= waspaid ;
		}
		if (paymentfrom != null && paymentfrom != ""){
			Date date = fromFormat.parse(paymentfrom);
			this.paymentfrom 		= "'" + toFormatF.format(date) + "'";
		}
		if (paymentto != null && paymentto != ""){
			Date date = fromFormat.parse(paymentto);
			this.paymentto 		= "'" + toFormatT.format(date) + "'";
		}
		
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<MedicalFee> p = new ArrayList<MedicalFee>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		DateFormat fromFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		fromFormat.setLenient(false);
		DateFormat toFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		toFormat.setLenient(false);
	
		
		try {
			ps = conn.prepareStatement("exec dbo.GetMedicalFeeReport " + identityCard + ","  + gender + "," + rif + "," + billId + "," +
										billWasGenerated + "," + billgenerationfrom + ","  + billgenerationto + "," + billwaspaid + "," + billpaymentfrom 
										+ "," + billpaymentto + "," +  ispromptpayment + "," + waspaid + "," + paymentfrom + "," + paymentto);
			rs = ps.executeQuery();
		
			while (rs.next()) {
				MedicalFee s = new MedicalFee();
				s.setMedicalFeeID(rs.getLong(1));
				Specialist e = new Specialist();
				e.setId(rs.getLong(2));
				e.setIdentityCard(rs.getString(3));
				e.setFirstName(rs.getString(4));
				e.setLastName(rs.getString(5));
				e.setSex(rs.getString(6));
				e.setRif(rs.getString(7));
				s.setSpecialist(e);
				
				s.setAmount(rs.getString(8));
				PendingBills b = new PendingBills();
				
				b.setBillID(rs.getLong(9));
				b.setWasGenerated(rs.getInt(10));
				String dateStr = rs.getString(11);
				Date date;
				try {
					if (dateStr != null){
						date = fromFormat.parse(dateStr);
						b.setGenerationDate(toFormat.format(date));
					}
				} catch (ParseException e1) {
					e1.printStackTrace();
				}
				b.setWasPaid(rs.getInt(12));
			
				dateStr = rs.getString(13);
				try {
					if (dateStr != null){
						date = fromFormat.parse(dateStr);
						b.setPaymentDate(toFormat.format(date));
					}
				} catch (ParseException e1) {
					e1.printStackTrace();
				}
				
				s.setBill(b);
				
				s.setIsPromptPayment(rs.getInt(14));
				s.setPromptAmount(rs.getString(15));
				s.setWasPaid(rs.getInt(16));
				
				
				dateStr = rs.getString(17);
				try {
					if (dateStr != null){
						date = fromFormat.parse(dateStr);
						s.setPaymentDate(toFormat.format(date));
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
