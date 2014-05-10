package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class PayMedicalFee implements DatabaseCommand {
	
	private Long medicalFeeId;
	
	public PayMedicalFee(Long medicalFeeId){
		this.medicalFeeId = medicalFeeId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.PayMedicalFee " + medicalFeeId);
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
