package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditPatientMedicalAdvice implements DatabaseCommand {
	
	private Long patientMedicalId;
	private Long unitId;
	private Long specialistId;
	private String amount;
	private Integer typeId;
		
	public EditPatientMedicalAdvice(Long unitId, Long specialistId, String amount, Long patientMedicalId, Integer typeId){
		this.patientMedicalId 	= patientMedicalId;
		this.unitId 	 		= unitId;
		this.specialistId 		= specialistId;
		this.amount 	 		= amount;
		this.typeId				= typeId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.EditPatientMedicalAdvice " + unitId + ", " + specialistId + ", '" + amount + "', " + patientMedicalId + ", " + typeId);
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
