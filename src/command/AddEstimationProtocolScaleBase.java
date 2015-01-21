package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AddEstimationProtocolScaleBase implements DatabaseCommand {
	
	private String estimationid;
	private String protocolid;
	
	public AddEstimationProtocolScaleBase(String estimationid, String protocolid) {
		this.estimationid 		= estimationid;
		this.protocolid 		= protocolid;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement("exec dbo.AddEstimationProtocolScaleBase '" + estimationid + "', '" + protocolid +  "'");
			System.out.println(estimationid + "', '" + protocolid + "' ");
			ps.executeUpdate();
		}
		catch (Exception e){
			return 0L;
		}
		finally {
			ps.close();
		}		
		return 1L;
	}

}
