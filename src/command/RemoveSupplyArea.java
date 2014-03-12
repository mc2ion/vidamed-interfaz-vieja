package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RemoveSupplyArea implements DatabaseCommand {
	
	private Long supplyAreaID;
	
	public RemoveSupplyArea(Long supplyAreaID){
		this.supplyAreaID = supplyAreaID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.RemoveSupplyArea " + supplyAreaID);
			ps.execute();
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
