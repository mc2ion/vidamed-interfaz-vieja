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

import domain.CashBoxReport;
import domain.Payment;
import domain.PaymentResponsible;
import domain.User;

public class GetCashBoxPaymentReport implements DatabaseCommand {
	
	private String cashboxid 		= null;
	private String cashierid		= null;
	private String from			 	= null; 
	private String to		 		= null;
		
	public GetCashBoxPaymentReport(){}
	
	public GetCashBoxPaymentReport(String cashboxid, String cashierid, String from, String to) throws ParseException{
		
		DateFormat fromFormat = new SimpleDateFormat("dd/MM/yyyy");
		fromFormat.setLenient(false);
		
		DateFormat toFormatF = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
		toFormatF.setLenient(false);
		
		DateFormat toFormatT = new SimpleDateFormat("yyyy-MM-dd 23:59:59");
		toFormatT.setLenient(false);
		
		
		if (cashboxid != null && cashboxid != "")
			this.cashboxid	    =  cashboxid;
		if (cashierid != null && cashierid != "")
			this.cashierid	    =  cashierid;
		if (from != null && from != ""){
			Date date = fromFormat.parse(from);
			this.from 		= "'" + toFormatF.format(date) + "'";
		}
		if (to != null && to != ""){
			Date date = fromFormat.parse(to);
			this.to 		= "'" + toFormatT.format(date) + "'";
		}
		
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<CashBoxReport> p = new ArrayList<CashBoxReport>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		DateFormat fromFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		fromFormat.setLenient(false);
		DateFormat toFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		toFormat.setLenient(false);
	
		
		try {
			ps = conn.prepareStatement("exec dbo.GetCashBoxPaymentReport " + cashboxid + ","  + cashierid + "," + from + "," + to);
			rs = ps.executeQuery();
		
			while (rs.next()) {
				CashBoxReport s = new CashBoxReport();
				s.setPaymentID(rs.getLong(1));
				s.setCashBoxID(rs.getLong(2));
				s.setName(rs.getString(3));
				
				User c = new User();
				c.setUserID(rs.getLong(4));
				c.setFirstName(rs.getString(5));
				c.setLastName(rs.getString(6));
				s.setCashier(c);
				
				Payment pm = new Payment();
				pm.setPaymentTypeID(rs.getLong(7));
				pm.setPaymentTypeName(rs.getString(8));
				pm.setPaymentMethodID(rs.getLong(9));
				pm.setPaymentMethodName(rs.getString(10));
				pm.setAmount(rs.getString(11));
				s.setPayment(pm);
				
				PaymentResponsible pr = new PaymentResponsible();
				pr.setId(rs.getLong(12));
				pr.setName(rs.getString(13));
				s.setPaymentResponsible(pr);
				
				String dateStr = rs.getString(14);
				Date date;
				try {
					if (dateStr != null){
						date = fromFormat.parse(dateStr);
						s.setDate(toFormat.format(date));
					}
				} catch (ParseException e1) {
					e1.printStackTrace();
				}
				
				s.setTotal(rs.getString(15));
				p.add(s);
			}
		}catch(Exception e){
			e.getStackTrace();
		}
			
		
		return p;
	}

}
