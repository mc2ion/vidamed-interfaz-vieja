package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RemovePaymentResposible implements DatabaseCommand {
	
	private Long responsibleID;
	
	public RemovePaymentResposible(Long responsibleID){
		this.responsibleID = responsibleID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.RemovePaymentResponsible " + responsibleID);
			ps.execute();
		}
		catch(Exception E){
			return 0;
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
