package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UpdateEstimationProtocol implements DatabaseCommand {
	
	String estimationid;
	String protocolid;

	public UpdateEstimationProtocol(String estimationid, String protocolid) {
		this.estimationid = estimationid;
		this.protocolid = protocolid;
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement("exec dbo.UpdateEstimationProtocol '" + estimationid + "', '" + protocolid + "'");
			ps.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
