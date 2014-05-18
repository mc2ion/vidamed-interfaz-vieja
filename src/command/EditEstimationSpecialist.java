package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditEstimationSpecialist implements DatabaseCommand {
	
	private Long admissionId;
	private Long specId;
	private Long unitId;
	
	
	public EditEstimationSpecialist(Long admissionId, Long specId, Long unitId){
		this.admissionId = admissionId;
		this.specId 	 = specId;
		this.unitId 	 = unitId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.EditEstimationSpecialist " + unitId + ", " + specId + ", " + admissionId);
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
