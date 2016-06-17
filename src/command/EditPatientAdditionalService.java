package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditPatientAdditionalService implements DatabaseCommand {
	
	private Long additionalServiceId;
	private String amount;
	private Long patientAdditionalServiceId;
		
	public EditPatientAdditionalService(Long additionalServiceId, String amount, Long patientAdditionalServiceId){
		this.additionalServiceId 	= additionalServiceId;
		this.amount 	 		= amount;
		this.patientAdditionalServiceId				= patientAdditionalServiceId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.EditPatientAdditionalService " + additionalServiceId + ", '" + amount + "', " + patientAdditionalServiceId);
			ps.execute();
		}
		catch(Exception e){
			return 0;
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}