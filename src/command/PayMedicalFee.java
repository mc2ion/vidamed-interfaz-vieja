package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class PayMedicalFee implements DatabaseCommand {
	
	private Long medicalFeeId;
	private String documentNumber;
	private String bank;
	
	public PayMedicalFee(Long medicalFeeId, String documentNumber, String bank){
		this.medicalFeeId = medicalFeeId;
		this.documentNumber = documentNumber;
		this.bank = bank;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.PayMedicalFee " + medicalFeeId + ", '" + documentNumber + "', '" + bank + "'");
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
