package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AddPatientAdditionalService implements DatabaseCommand {
	
	private Long admissionId;
	private Long additionalServiceId;
	private String amount;
		
	public AddPatientAdditionalService(Long admissionId, Long additionalServiceId, String amount){
		this.admissionId 	= admissionId;
		this.additionalServiceId 	 	= additionalServiceId;
		this.amount 	 	= amount;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.AddPatientAdditionalService " + admissionId + ", " + additionalServiceId + ", '" + amount + "'");
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