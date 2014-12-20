package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DuplicateProtocol implements DatabaseCommand {
	
	private String protocolID;
	
	public DuplicateProtocol(String protocolID){
		this.protocolID = protocolID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		String protocolId = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.DuplicateProtocol " + protocolID);
			rs = ps.executeQuery();
			if (rs.next()) {
				protocolId = rs.getString(1);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return protocolId;
	}

}
