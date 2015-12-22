package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class SendBill implements DatabaseCommand {
	
	Long billID;
	String date;

	public SendBill(Long billID, String date) {
		this.billID = billID;
		this.date = date;
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.SendBill " + billID + ", '" + date + "'");
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
