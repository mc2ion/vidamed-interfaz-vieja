package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RemoveUnit implements DatabaseCommand {
	
	private Long unitID;
	
	public RemoveUnit(Long unitID){
		this.unitID = unitID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.RemoveUnit " + unitID);
			ps.execute();
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
