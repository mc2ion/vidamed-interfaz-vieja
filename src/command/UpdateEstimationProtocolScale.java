package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UpdateEstimationProtocolScale implements DatabaseCommand {
	
	String estimationid;

	public UpdateEstimationProtocolScale(String estimationid) {
		this.estimationid = estimationid;
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement("exec dbo.UpdateEstimationProtocolScale '" + estimationid + "'");
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
