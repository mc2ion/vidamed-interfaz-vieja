package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class PayPendingAccount implements DatabaseCommand {
	
	private Long billId;
	private String documentNumber;
	private String bank;
	private Integer hasMultiple;
	private Integer mainResponsible;
	private Long admissionId;
	private Long paymentResponsibleId;
	private Double islr;
	private Double otherRetentions;
	private Double promptPayment;
	
	public PayPendingAccount(Long billId, String documentNumber, String bank, Integer hasMultiple, Integer mainResponsible, Long admissionId, 
			Long paymentResponsibleId, Double islr, Double otherRetentions, Double promptPayment){
		this.billId = billId;
		this.documentNumber = documentNumber;
		this.bank = bank;
		this.hasMultiple = hasMultiple;
		this.mainResponsible = mainResponsible;
		this.admissionId = admissionId;
		this.paymentResponsibleId = paymentResponsibleId;
		this.islr = islr;
		this.otherRetentions = otherRetentions;
		this.promptPayment = promptPayment;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.PayAccount " + billId + ", '" + documentNumber + "', '" + bank + "', " + hasMultiple + ", " + 
					mainResponsible + ", " + admissionId + ", " + paymentResponsibleId + ", " + islr + ", " + otherRetentions + ", " + promptPayment);
			ps.execute();
		}
		catch(Exception e){
			return 0;
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
