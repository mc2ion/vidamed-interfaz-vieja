package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdmitPatient implements DatabaseCommand {
	
	private String estimationId;
	private String bedid;
	private String observations;
	private String reasonid;
		
	public AdmitPatient(String estimationId, String bedid, String observations, String reasonid) {
		this.estimationId 	= estimationId;
		this.bedid 			= bedid;
		this.observations 	= observations;
		this.reasonid 		= reasonid;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		Long userID = null;
		try {
			ps = conn.prepareStatement("exec dbo.AdmitPatient '" + estimationId + "', '" + 
						bedid + "', '" + observations + "', '" + reasonid + "'");
			rs = ps.executeQuery();
			if (rs.next()) {
				userID = rs.getLong(1);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return userID;
	}

}
