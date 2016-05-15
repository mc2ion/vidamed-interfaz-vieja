package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AddPatientMedicalAdvice implements DatabaseCommand {
	
	private Long admissionId;
	private Integer typeId;
	private Long unitId;
	private Long specialistId;
	private String amount;
		
	public AddPatientMedicalAdvice(Long admissionId, Long unitId, Long specialistId, String amount, Integer typeId){
		this.admissionId 	= admissionId;
		this.unitId 	 	= unitId;
		this.specialistId 	= specialistId;
		this.amount 	 	= amount;
		this.typeId			= typeId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.AddPatientMedicalAdvice " + admissionId + ", " + unitId + ", " + specialistId + ", '" + amount + "', " + typeId);
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
