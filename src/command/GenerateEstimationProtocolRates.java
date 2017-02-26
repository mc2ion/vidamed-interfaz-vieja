package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class GenerateEstimationProtocolRates implements DatabaseCommand {
	
	private String estimationid;
	private String protocolid;
	private String admissionid;
	
	public GenerateEstimationProtocolRates(String estimationid, String protocolid, String admissionid){
		this.estimationid = estimationid;
		this.protocolid   = protocolid;
		this.admissionid = admissionid;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GenerateEstimationProtocolRates " + estimationid + "," + protocolid + "," + admissionid);
			ps.executeUpdate();
		}
		finally {
			ps.close();
		}		
		
		return (long) 1;
	}

}
