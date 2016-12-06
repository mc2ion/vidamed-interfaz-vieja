package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AddAdmissionPaymentResponsible implements DatabaseCommand {
	
	private Long admissionID;
	private Long paymentResponsibleID;
	private String keyNumber;
	private Double coverageAmount;
	private String guaranteeLetter;

	public AddAdmissionPaymentResponsible(Long admissionID, Long paymentResponsibleID,
			String keyNumber, Double coverageAmount, String guaranteeLetter) {
		this.admissionID = admissionID;
		this.paymentResponsibleID = paymentResponsibleID;
		this.keyNumber = keyNumber;
		this.coverageAmount = coverageAmount;
		this.guaranteeLetter = guaranteeLetter;
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.AddAdmissionPaymentResponsible " + admissionID + ", " + paymentResponsibleID +
									  ", " + keyNumber + ", "+ coverageAmount + ", " + guaranteeLetter);
			ps.execute();
		}
		catch(Exception e){
			e.printStackTrace();
			//return 0;
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
