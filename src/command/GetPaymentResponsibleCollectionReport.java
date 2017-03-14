package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.PaymentResponsibleCollection;

public class GetPaymentResponsibleCollectionReport implements DatabaseCommand {
	
	private String bank;
	private String documentNumber;
	
	public GetPaymentResponsibleCollectionReport(String bank, String documentNumber){
		this.bank = bank;
		this.documentNumber = documentNumber;
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		ArrayList<PaymentResponsibleCollection> prc = new ArrayList<PaymentResponsibleCollection>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetPaymentResponsibleCollectionReport '" + bank + "', '" + documentNumber + "'");
			rs = ps.executeQuery();

			while(rs.next()) {
				PaymentResponsibleCollection p = new PaymentResponsibleCollection();
				p.setBillID(rs.getString(1));
				p.setCoverageAmount(rs.getString(2));
				p.setRetention(rs.getString(3));
				p.setReasonID(rs.getInt(4));
				p.setReasonName(rs.getString(5));
				p.setPromptPaymentAmount(rs.getString(6));
				p.setRefund(rs.getString(7));
				prc.add(p);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return prc;
	}
}
