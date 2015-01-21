package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class GenerateEstimationProtocolRates implements DatabaseCommand {
	
	private String estimationid;
	private String protocolid;
	
	public GenerateEstimationProtocolRates(String estimationid, String protocolid){
		this.estimationid = estimationid;
		this.protocolid   = protocolid;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GenerateEstimationProtocolRates " + estimationid + "," + protocolid);
			ps.executeUpdate();
		}
		finally {
			ps.close();
		}		
		
		return (long) 1;
	}

}
