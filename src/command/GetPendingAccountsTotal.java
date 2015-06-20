package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class GetPendingAccountsTotal implements DatabaseCommand {

	public GetPendingAccountsTotal(){}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {

		PreparedStatement ps = null;
		ResultSet rs = null;
		Double count = 0.00;
		try {
			ps = conn.prepareStatement("exec dbo.GetPendingAccountsTotal");
			rs = ps.executeQuery();
			if (rs.next()) {
				count = rs.getDouble(1);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		finally {
			ps.close();
		}		
		
		return count;
	}
}
