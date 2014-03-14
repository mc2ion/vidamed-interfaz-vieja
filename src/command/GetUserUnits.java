package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

public class GetUserUnits implements DatabaseCommand {
	
	public GetUserUnits(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		HashMap<Long, String> units = new HashMap<Long, String>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetUserUnits");
			rs = ps.executeQuery();

			while(rs.next()) {
				units.put(rs.getLong(1), rs.getString(2));
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return units;
	}

}
