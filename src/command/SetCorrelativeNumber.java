package command;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class SetCorrelativeNumber implements DatabaseCommand {
	
	private Long billID;
	private Long correlativeNumber;

	public SetCorrelativeNumber(long billID, Long correlativeNumber) {
		this.billID = billID;
		this.correlativeNumber = correlativeNumber;
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		try {
			  CallableStatement cstmt = conn.prepareCall("{? = call dbo.SetCorrelativeNumber(?,?)}");
		      cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
		      cstmt.setLong(2, billID);
		      cstmt.setLong(3, correlativeNumber);
		      cstmt.execute();
		      return cstmt.getLong(1);
		}
		catch (Exception e) {
			e.printStackTrace();
			return -2;
		}
	}

}
