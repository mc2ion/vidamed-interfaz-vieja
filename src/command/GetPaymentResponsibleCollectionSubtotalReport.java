package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.PaymentResponsibleCollection;

public class GetPaymentResponsibleCollectionSubtotalReport implements
		DatabaseCommand {

	private String bank;
	private String documentNumber;
	private Double islr;
	private Double amount;
	
	public GetPaymentResponsibleCollectionSubtotalReport(String bank, String documentNumber, Double islr){
		this.bank = bank;
		this.documentNumber = documentNumber;
		this.islr = islr;
		this.amount = null;
	}
	
	public GetPaymentResponsibleCollectionSubtotalReport(String bank, String documentNumber, Double islr, Double amount){
		this.bank = bank;
		this.documentNumber = documentNumber;
		this.islr = islr;
		this.amount = amount;
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		ArrayList<PaymentResponsibleCollection> prc = new ArrayList<PaymentResponsibleCollection>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetPaymentResponsibleCollectionSubtotalReport '" + bank + "', '" + documentNumber + "', " + islr + ", " + amount);
			rs = ps.executeQuery();

			while(rs.next()) {
				PaymentResponsibleCollection p = new PaymentResponsibleCollection();
				p.setCoverageAmount(rs.getString(1));
				p.setRetention(rs.getString(2));
				p.setPromptPaymentAmount(rs.getString(3));
				p.setRefund(rs.getString(4));
				p.setReasonID(rs.getInt(5));
				p.setOtherRetention(rs.getString(6));
				p.setTotalPaid(rs.getString(7));
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
