package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RemoveSupplyInventory implements DatabaseCommand {

	private Long supplyInventoryID;
	
	public RemoveSupplyInventory(Long supplyInventoryID){
		this.supplyInventoryID = supplyInventoryID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.RemoveSupplyInventory " + supplyInventoryID);
			ps.execute();
		}
		catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
