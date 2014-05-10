package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class MoveToPromptPayment implements DatabaseCommand {
	
	private Long medicalFeeId;
	private Long variableId;
	
	
	public MoveToPromptPayment(Long medicalFeeId, Long variableId){
		this.medicalFeeId = medicalFeeId;
		this.variableId   = variableId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			System.out.println(medicalFeeId + " " + variableId);
			
			ps = conn.prepareStatement("exec dbo.MoveToPromptPayment " + variableId + "," + medicalFeeId) ;
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
