package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DuplicateProtocolSupplies implements DatabaseCommand {
	
	private String protocolID;
	private Long newProtocolID;
	
	public DuplicateProtocolSupplies(String protocolID, Long newProtocol){
		this.protocolID 	= protocolID;
		this.newProtocolID 	= newProtocol;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement("exec dbo.DuplicateProtocolSupplies " + protocolID + ", " + newProtocolID);
			ps.executeUpdate();
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
