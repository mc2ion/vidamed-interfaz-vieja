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

import domain.Invoice;

public class GetDetailedInvoicingReport implements DatabaseCommand {

	private String generationfrom = null;	
	private String generationto = null;
	
	public GetDetailedInvoicingReport(){}
	
	public GetDetailedInvoicingReport(String generationfrom, String generationto) throws ParseException{
		
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
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		ArrayList<Invoice> invoices = new ArrayList<Invoice>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetDetailedInvoicingReport " + generationfrom + ","  + generationto);
			rs = ps.executeQuery();
		
			while (rs.next()) {
				Invoice i = new Invoice();
				
				i.setBillID(rs.getLong(1));
				i.setClinicTotal(rs.getString(2));
				i.setDrugs(rs.getString(3));
				i.setMaterials(rs.getString(4));
				i.setLabs(rs.getString(5));
				i.setxRays(rs.getString(6));
				i.setEcos(rs.getString(7));
				i.setProfessionalFees(rs.getString(8));
				i.setTotal(rs.getString(9));
				i.setDiscount(rs.getString(10));
				i.setPaymentResponsibleName(rs.getString(11));
				i.setNutrition(rs.getString(12));
				i.setTomographies(rs.getString(13));
				i.setBloodBank(rs.getString(14));
				i.setPatientIdentityCard(rs.getString(15));
				i.setPatientName(rs.getString(16), rs.getString(17));
				
				invoices.add(i);
			}
		}catch(Exception e){
			e.getStackTrace();
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return invoices;
	}
}
