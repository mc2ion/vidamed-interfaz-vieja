package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AddPatientMedicalAdvice implements DatabaseCommand {
	
	private Long admissionId;
	private Long unitId;
	private Long specialistId;
	private String amount;
		
	public AddPatientMedicalAdvice(Long admissionId, Long unitId, Long specialistId, String amount){
		this.admissionId 	= admissionId;
		this.unitId 	 	= unitId;
		this.specialistId 	= specialistId;
		this.amount 	 	= amount;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.AddPatientMedicalAdvice " + admissionId + ", " + unitId + ", " + specialistId + ", '" + amount + "'");
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
