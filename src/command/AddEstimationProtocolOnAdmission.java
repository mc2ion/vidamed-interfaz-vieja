package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AddEstimationProtocolOnAdmission implements DatabaseCommand {
	
	private String estimationid;
	private String protocolid;
	private String diagnosis;
	
	public AddEstimationProtocolOnAdmission(String estimationid, String protocolid, String diagnosis) {
		this.estimationid 				= estimationid;
		this.protocolid 		 		= protocolid;
		this.diagnosis					= diagnosis;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement("exec dbo.AddEstimationProtocolOnAdmission '" + estimationid + "', '" + protocolid + "', '"+ diagnosis + "'");
			ps.executeUpdate();
		}
		catch (Exception e){
			e.getStackTrace();
			return 0L;
		}
		finally {
			ps.close();
		}		
		return 1L;
	}

}
