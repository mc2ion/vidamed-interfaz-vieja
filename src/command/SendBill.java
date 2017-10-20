package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class SendBill implements DatabaseCommand {
	
	Long billID;
	String date;
	private Integer hasMultiple;
	private Integer mainResponsible;
	private Long admissionID;
	private Long paymentResponsibleID;

	public SendBill(Long billID, String date, Integer hasMultiple, Integer mainResponsible, Long admissionID, Long paymentResponsibleID) {
		this.billID = billID;
		this.date = date;
		this.hasMultiple = hasMultiple;
		this.mainResponsible = mainResponsible;
		this.admissionID = admissionID;
		this.paymentResponsibleID = paymentResponsibleID;
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.SendBill " + billID + ", '" + date + "', " + hasMultiple + ", " + mainResponsible + ", " + admissionID + 
					", " + paymentResponsibleID);
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
