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

import domain.BilledSupply;

public class GetPatientSuppliesReport implements DatabaseCommand {

	private String from = null;	
	private String to = null;
	
	public GetPatientSuppliesReport(){}
	
	public GetPatientSuppliesReport(String from, String to) throws ParseException{
		
		if (from != null && from != ""){
			DateFormat fromFormat = new SimpleDateFormat("dd/MM/yyyy");
			fromFormat.setLenient(false);
			
			DateFormat toFormat = new SimpleDateFormat("yyyy-MM-dd");
			toFormat.setLenient(false);
			Date date = fromFormat.parse(from);
			this.from 		= "'" + toFormat.format(date) + "'";
		}
		if (to != null && to != ""){
			DateFormat fromFormat = new SimpleDateFormat("dd/MM/yyyy");
			fromFormat.setLenient(false);
			
			DateFormat toFormat = new SimpleDateFormat("yyyy-MM-dd");
			toFormat.setLenient(false);
			
			Date date = fromFormat.parse(to);
			this.to   		= "'" + toFormat.format(date) + "'";
		}
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		ArrayList<BilledSupply> pList = new ArrayList<BilledSupply>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec GetPatientSuppliesReport " + this.from + "," + this.to);
			rs = ps.executeQuery();

			while (rs.next()) {
				BilledSupply u = new BilledSupply();		
				
				u.setAdmissionID(rs.getLong(1));
				
				DateFormat fromFormat = new SimpleDateFormat("yyyy-MM-dd");
				fromFormat.setLenient(false);
				
				DateFormat toFormat = new SimpleDateFormat("dd/MM/yyyy");
				toFormat.setLenient(false);
				
				Date date = fromFormat.parse(rs.getString(2));
				
				u.setSupplyDate(toFormat.format(date));
				u.setIdentityCard(rs.getString(3));
				u.setPatientName(rs.getString(4));
				u.setSupplyAreaName(rs.getString(5));
				u.setSupplyInventoryID(rs.getLong(6));
				u.setSupplyName(rs.getString(7));
				u.setAmount(rs.getString(8));
				u.setUnitPrice(rs.getString(9));
				u.setPrice(rs.getString(10));
				
				pList.add(u);
			}
		}catch(Exception e){
			e.getStackTrace();
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return pList;
	}

}
