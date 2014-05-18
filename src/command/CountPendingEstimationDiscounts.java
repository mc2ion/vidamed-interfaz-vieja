package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CountPendingEstimationDiscounts implements DatabaseCommand {
	
	public CountPendingEstimationDiscounts(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		Integer count = 0;
		try {
			ps = conn.prepareStatement("exec dbo.CountPendingEstimationDiscounts");
			rs = ps.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
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
