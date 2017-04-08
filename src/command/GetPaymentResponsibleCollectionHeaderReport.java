package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import domain.PaymentResponsibleCollectionHeader;

public class GetPaymentResponsibleCollectionHeaderReport implements
		DatabaseCommand {
	
	private String bank;
	private String documentNumber;
	private Double islr;
	
	public GetPaymentResponsibleCollectionHeaderReport(String bank, String documentNumber, Double islr){
		this.bank = bank;
		this.documentNumber = documentNumber;
		this.islr = islr;
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PaymentResponsibleCollectionHeader p = new PaymentResponsibleCollectionHeader();
		p.setBank(bank);
		p.setDocumentNumber(documentNumber);
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetPaymentResponsibleCollectionHeaderReport '" + bank + "', '" + documentNumber + "', " + islr);
			rs = ps.executeQuery();

			if (rs.next()) {
				p.setCoverageAmount(rs.getString(1));
				p.setRetention(rs.getString(2));
				p.setDif(rs.getString(3));
				p.setPaymentResponsibleName(rs.getString(4));
				p.setPaymentDate(rs.getString(5));
			}
		} finally {
			rs.close();
			ps.close();
		}		
		
		return p;
	}

}
