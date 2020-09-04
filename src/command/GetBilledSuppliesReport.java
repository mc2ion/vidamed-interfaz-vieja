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

public class GetBilledSuppliesReport implements DatabaseCommand {

	private String from = null;	
	private String to = null;
	
	public GetBilledSuppliesReport(){}
	
	public GetBilledSuppliesReport(String from, String to) throws ParseException{
		
		if (from != null && from != ""){
			DateFormat fromFormat = new SimpleDateFormat("dd/MM/yyyy");
			fromFormat.setLenient(false);
			
			DateFormat toFormat = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
			toFormat.setLenient(false);
			Date date = fromFormat.parse(from);
			this.from 		= "'" + toFormat.format(date) + "'";
		}
		if (to != null && to != ""){
			DateFormat fromFormat = new SimpleDateFormat("dd/MM/yyyy");
			fromFormat.setLenient(false);
			
			DateFormat toFormat = new SimpleDateFormat("yyyy-MM-dd 23:59:59");
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
			ps = conn.prepareStatement("exec GetBilledSuppliesReport " + this.from + "," + this.to);
			rs = ps.executeQuery();

			while (rs.next()) {
				BilledSupply u = new BilledSupply();		
				
				u.setGenerationDate(rs.getString(1));
				u.setCreditNoteID(rs.getLong(2));
				u.setIdentityCard(rs.getString(3));
				u.setPatientName(rs.getString(4));
				u.setSupplyName(rs.getString(5));
				u.setSupplyInventoryID(rs.getLong(6));
				u.setAmount(rs.getString(7));
				u.setUnitPrice(rs.getString(8));
				u.setPrice(rs.getString(9));
				u.setSupplyAreaName(rs.getString(10));
				u.setSupplyDate(rs.getString(11));
				
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
