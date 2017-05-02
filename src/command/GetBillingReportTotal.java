package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.Invoice;

public class GetBillingReportTotal implements DatabaseCommand {
	
	private Integer monthid;
	private Integer yearid;

	public GetBillingReportTotal(Integer monthid, Integer yearid) {
		this.monthid = monthid;
		this.yearid = yearid;
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		ArrayList<Invoice> invoices = new ArrayList<Invoice>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec GetBillingReportTotal " + monthid + ","  + yearid);
			rs = ps.executeQuery();
		
			while (rs.next()) {
				Invoice i = new Invoice();
				
				i.setTotal(rs.getString(1));
				i.setCoverageAmount(rs.getString(2));
				i.setClinicTotal(rs.getString(3));
				i.setProfessionalFees(rs.getString(4));
				i.setCoverageTotalPaid(rs.getString(5));
				i.setDiscount(rs.getString(6));
				i.setBillsAmount(rs.getInt(7));
				
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
