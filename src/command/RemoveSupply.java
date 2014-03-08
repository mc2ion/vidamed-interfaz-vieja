package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RemoveSupply implements DatabaseCommand {
	
	private Long supplyID;
	
	public RemoveSupply(Long supplyID){
		this.supplyID = supplyID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.RemoveSupply " + supplyID);
			ps.execute();
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
