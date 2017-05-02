package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.Invoice;

public class GetBillingReportTotals implements DatabaseCommand {
	
	private Integer monthid;
	private Integer yearid;

	public GetBillingReportTotals(Integer monthid, Integer yearid) {
		this.monthid = monthid;
		this.yearid = yearid;
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		ArrayList<Invoice> invoices = new ArrayList<Invoice>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec GetBillingReportTotals " + monthid + ","  + yearid);
			rs = ps.executeQuery();
		
			while (rs.next()) {
				Invoice i = new Invoice();
				
				i.setPaymentResponsibleID(rs.getLong(1));
				i.setPaymentResponsibleName(rs.getString(2));
				i.setTotal(rs.getString(3));
				i.setCoverageAmount(rs.getString(4));
				i.setClinicTotal(rs.getString(5));
				i.setProfessionalFees(rs.getString(6));
				i.setCoverageTotalPaid(rs.getString(7));
				i.setDiscount(rs.getString(8));
				
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
