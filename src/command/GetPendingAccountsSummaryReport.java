package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.PaymentResponsible;
import domain.PendingAccounts;

public class GetPendingAccountsSummaryReport implements DatabaseCommand {

	private String from 			= null;
	private String to 				= null;

	public GetPendingAccountsSummaryReport(String from, String to) {
		this.from = from;
		this.to = to;
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		ArrayList<PendingAccounts> pList = new ArrayList<PendingAccounts>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec GetPendingAccountsSummaryReport '" + this.from + "','" + this.to + "'");
			rs = ps.executeQuery();

			while (rs.next()) {
				PendingAccounts u = new PendingAccounts();				
				PaymentResponsible p = new PaymentResponsible();
				p.setId(rs.getLong(1));
				p.setName(rs.getString(2));
				u.setPaymentResposible(p);				
				u.setTotal(rs.getString(3), rs.getDouble(3));
				u.setDeliveryDate(rs.getString(4));
				
				pList.add(u);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return pList;
	}

}
