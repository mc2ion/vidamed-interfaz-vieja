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

import domain.PaymentResponsible;
import domain.PendingBills;

public class GetBillReport implements DatabaseCommand {
	
	private String billid 					= null;
	private String estimationid 			= null;
	private String paymentresponsiblename 	= null;
	private String wasgenerated		 		= null;
	private String generationfrom		 	= null;	
	private String generationto		 		= null;
	private String waspaid 					= null; 
	private String paymentfrom			 	= null; 
	private String paymentto			  	= null;
	private String patientname				= null;
	private String identitycard				= null;
	private String specialistname			= null;
	private String admissiondate			= null;
	private String wasdelivered				= null;
	
	
	public GetBillReport(){}
	
	public GetBillReport(String billid, String estimationId, String paymentresponsiblename, String wasgenerated, String generationfrom, String generationto, 
								String waspaid, String paymentfrom, String paymentto, String patientname, String identitycard, String specialistname, 
								String admissiondate, String wasdelivered) throws ParseException{
		if (billid != null && billid != "")
			this.billid	    = billid;
		if (estimationId != null && estimationId != "")
			this.estimationid	    = estimationId;
		if (paymentresponsiblename != null && paymentresponsiblename != "")
			this.paymentresponsiblename  	= "'" + paymentresponsiblename + "'";
		if (wasgenerated != null && wasgenerated != "")
			this.wasgenerated	    = wasgenerated;
		if (generationfrom != null && generationfrom != ""){
			DateFormat fromFormat = new SimpleDateFormat("dd/MM/yyyy");
			fromFormat.setLenient(false);
			
			DateFormat toFormat = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
			toFormat.setLenient(false);
			Date date = fromFormat.parse(generationfrom);
			this.generationfrom 		= "'" + toFormat.format(date) + "'";
		}
		if (generationto != null && generationto != ""){
			DateFormat fromFormat = new SimpleDateFormat("dd/MM/yyyy");
			fromFormat.setLenient(false);
			
			DateFormat toFormat = new SimpleDateFormat("yyyy-MM-dd 23:59:59");
			toFormat.setLenient(false);
			
			Date date = fromFormat.parse(generationto);
			this.generationto   		= "'" + toFormat.format(date) + "'";
		}
		if (waspaid != null && waspaid != "")
			this.waspaid	    = waspaid;
		if (paymentfrom != null && paymentfrom != ""){
			DateFormat fromFormat = new SimpleDateFormat("dd/MM/yyyy");
			fromFormat.setLenient(false);
			
			DateFormat toFormat = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
			toFormat.setLenient(false);
			Date date = fromFormat.parse(paymentfrom);
			this.paymentfrom 		= "'" + toFormat.format(date) + "'";
		}
		if (paymentto != null && paymentto != ""){
			DateFormat fromFormat = new SimpleDateFormat("dd/MM/yyyy");
			fromFormat.setLenient(false);
			
			DateFormat toFormat = new SimpleDateFormat("yyyy-MM-dd 23:59:59");
			toFormat.setLenient(false);
			
			Date date = fromFormat.parse(paymentto);
			this.paymentto   		= "'" + toFormat.format(date) + "'";
		}
		if (patientname != null && patientname != "")
			this.patientname  	= "'" + patientname + "'";
		if (identitycard != null && identitycard != "")
			this.identitycard  	= "'" + identitycard + "'";
		if (specialistname != null && specialistname != "")
			this.specialistname  	= "'" + specialistname + "'";
		if (admissiondate != null && admissiondate != ""){
			this.admissiondate   	= "'" + admissiondate + "'";
		}
		if (wasdelivered != null && wasdelivered != "")
			this.wasdelivered	    = wasdelivered;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<PendingBills> p = new ArrayList<PendingBills>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetBillReport " + billid + "," + estimationid + "," + paymentresponsiblename + ","  + wasgenerated +   "," +
					generationfrom + ","  + generationto + ","  + waspaid + "," + paymentfrom + "," + paymentto + "," + patientname + "," + identitycard + "," +
					specialistname + "," + admissiondate + "," + wasdelivered);
			rs = ps.executeQuery();
		
			while (rs.next()) {
				PendingBills s = new PendingBills();
				
				s.setBillID(rs.getLong(1));
				s.setEstimationID(rs.getLong(2));

				PaymentResponsible r = new PaymentResponsible();
				r.setId(rs.getLong(3));
				r.setName(rs.getString(4));
				s.setPaymentResposible(r);
				
				s.setTotal(rs.getString(5));
				s.setWasGenerated(rs.getInt(6));
				
				DateFormat fromFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				fromFormat.setLenient(false);
				DateFormat toFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
				toFormat.setLenient(false);
				DateFormat fromFormatShort = new SimpleDateFormat("yyyy-MM-dd");
				fromFormatShort.setLenient(false);
				DateFormat toFormatShort = new SimpleDateFormat("dd/MM/yyyy");
				toFormatShort.setLenient(false);
				
				String dateStr = rs.getString(7);
				Date date;
				try {
					if (dateStr != null){
						date = fromFormat.parse(dateStr);
						s.setGenerationDate(toFormat.format(date));
					}
				} catch (ParseException e1) {
					e1.printStackTrace();
				}
			
				
				s.setWasPaid(rs.getInt(8));
				
				dateStr = rs.getString(9);
				try {
					if (dateStr != null){
						date = fromFormat.parse(dateStr);
						s.setPaymentDate(toFormat.format(date));
					}
				} catch (ParseException e1) {
					e1.printStackTrace();
				}
				s.setAdmissionID(rs.getLong(10));
				s.setWasDelivered(rs.getInt(11));
				
				dateStr = rs.getString(12);
				try {
					if (dateStr != null){
						date = fromFormatShort.parse(dateStr);
						s.setDeliveryDate(toFormatShort.format(date));
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
