package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class MoveToPromptPayment implements DatabaseCommand {
	
	private Long medicalFeeId;
	private Double commission;
	
	
	public MoveToPromptPayment(Long medicalFeeId, Double commission){
		this.medicalFeeId = medicalFeeId;
		this.commission   = commission;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.MoveToPromptPayment " + commission + "," + medicalFeeId) ;
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
