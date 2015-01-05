package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditEstimationProtocolScale implements DatabaseCommand {
	
	private String estimationid;
	private String protocolid;
	private String protocolscaleid;
	private String cost;
	
	public EditEstimationProtocolScale(String estimationid, String protocolid, String protocolscaleid, String cost) {
		this.estimationid 		= estimationid;
		this.protocolid 		= protocolid;
		this.protocolscaleid 	= protocolscaleid;
		this.cost 	 			= cost;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement("exec dbo.EditEstimationProtocolScale '" + estimationid + "', '" + protocolid + "', '" + 
						protocolscaleid + "', '" + cost + "'");
			
			System.out.println(estimationid + "', '" + protocolid + "', '" + 
						protocolscaleid + "', '" + cost);
			ps.executeUpdate();
		}
		finally {
			ps.close();
		}		
		return 1;
	}

}
