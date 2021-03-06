package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AddEstimationSpecilist implements DatabaseCommand {
	
	private String estimationid;
	private String protocolid;
	private String protocolscaleid;
	private String specialistid;
	private String unitid;
	
	
	public AddEstimationSpecilist(String estimationid, String protocolid, String protocolscaleid, String specialistid, String unitid) {
		this.estimationid 		= estimationid;
		this.protocolid 		= protocolid;
		this.protocolscaleid 	= protocolscaleid;
		this.specialistid 	 	= specialistid;
		this.unitid 	 		= unitid;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement("exec dbo.AddEstimationSpecilist '" + estimationid + "', '" + protocolid + "', '" + 
						protocolscaleid + "', '" + specialistid + "','"+ unitid + "'");
			ps.executeUpdate();
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
