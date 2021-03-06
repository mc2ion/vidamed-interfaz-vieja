package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AddPatientEstimationServiceList implements DatabaseCommand {
	
	private Long admissionId;
		
	public AddPatientEstimationServiceList(Long admissionId){
		this.admissionId = admissionId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec AddPatientEstimationServiceList " + admissionId);
			ps.execute();
		}
		catch(Exception e){
			e.printStackTrace();
			return 0;
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
