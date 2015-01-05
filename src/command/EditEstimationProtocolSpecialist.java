package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditEstimationProtocolSpecialist implements DatabaseCommand {
	
	private String specialistid;
	private String unitid;
	private String estimationid;
	private String protocolscaleid;
	private String protocolid;
	
	
	public EditEstimationProtocolSpecialist(String specialistid, String unitid, String estimationid, String protocolid, String protocolscaleid ){
		this.specialistid 	 = specialistid;
		this.unitid 	 	 = unitid;
		this.estimationid 	 = estimationid;
		this.protocolid 	 = protocolid;
		this.protocolscaleid = protocolscaleid;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.EditEstimationProtocolSpecialist " + specialistid + ", " + unitid + ", " + estimationid + "," +protocolid + "," + protocolscaleid);
			ps.execute();
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
