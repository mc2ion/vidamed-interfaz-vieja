package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.Invoice;

public class GetBillingReportFooter implements DatabaseCommand {
	
	private Integer monthid;
	private Integer yearid;

	public GetBillingReportFooter(Integer monthid, Integer yearid) {
		this.monthid = monthid;
		this.yearid = yearid;
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		ArrayList<Invoice> invoices = new ArrayList<Invoice>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec GetBillingReportFooter " + monthid + ","  + yearid);
			rs = ps.executeQuery();
		
			while (rs.next()) {
				Invoice i = new Invoice();

				i.setBillsAmount(rs.getInt(1));
				i.setTotal(rs.getString(2));
				
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
