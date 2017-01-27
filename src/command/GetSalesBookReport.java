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

import domain.Sale;

public class GetSalesBookReport implements DatabaseCommand {
	
	private String dischargefrom = null;	
	private String dischargeto = null;
	
	public GetSalesBookReport(){}
	
	public GetSalesBookReport(String dischargefrom, String dischargeto) throws ParseException{
		if (dischargefrom != null && dischargefrom != ""){
			DateFormat fromFormat = new SimpleDateFormat("dd/MM/yyyy");
			fromFormat.setLenient(false);
			
			DateFormat toFormat = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
			toFormat.setLenient(false);
			Date date = fromFormat.parse(dischargefrom);
			this.dischargefrom 		= "'" + toFormat.format(date) + "'";
		}
		if (dischargeto != null && dischargeto != ""){
			DateFormat fromFormat = new SimpleDateFormat("dd/MM/yyyy");
			fromFormat.setLenient(false);
			
			DateFormat toFormat = new SimpleDateFormat("yyyy-MM-dd 23:59:59");
			toFormat.setLenient(false);
			
			Date date = fromFormat.parse(dischargeto);
			this.dischargeto   		= "'" + toFormat.format(date) + "'";
		}
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		ArrayList<Sale> sales = new ArrayList<Sale>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetSalesBookReport " + dischargefrom + ","  + dischargeto);
			rs = ps.executeQuery();
		
			while (rs.next()) {
				Sale s = new Sale();
				
				s.setBillID(rs.getLong(1));
				s.setCorrelativeNumber(rs.getLong(2));
				s.setFirstName(rs.getString(3));
				s.setLastName(rs.getString(4));
				s.setIdentityCard(rs.getString(5));
				s.setTotal(rs.getString(6));
				
				DateFormat fromFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				fromFormat.setLenient(false);
				DateFormat toFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
				toFormat.setLenient(false);
				
				String dateStr = rs.getString(7);
				Date date;
				try {
					if (dateStr != null){
						date = fromFormat.parse(dateStr);
						s.setDischargeDate(toFormat.format(date));
					}
				} catch (ParseException e1) {
					e1.printStackTrace();
				}
				
				sales.add(s);
			}
		}catch(Exception e){
			e.getStackTrace();
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return sales;
	}

}
