package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RemoveEstimationPaymentResposible implements DatabaseCommand {
	
	private Long responsibleID;
	private Long estimationID;
	
	
	public RemoveEstimationPaymentResposible(Long responsibleID, Long estimationID){
		this.responsibleID = responsibleID;
		this.estimationID  = estimationID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.RemoveEstimationPaymentResponsible " + estimationID + ", " + responsibleID);
			ps.execute();
		}
		catch(Exception E){
			E.getStackTrace();
			return 0;
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
