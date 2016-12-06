package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class HasMainSpecialist implements DatabaseCommand {
	
	private String protocolid;

	public HasMainSpecialist(String protocolid) {
		this.protocolid   = protocolid;
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		Integer hasMainSpecialist = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.HasMainSpecialist '" + protocolid + "'");
			rs = ps.executeQuery();
			if (rs.next()) {
				hasMainSpecialist = rs.getInt(1);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return hasMainSpecialist;
	}

}
