package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditSupplyArea implements DatabaseCommand {
	
	private Long supplyAreaID;
	private String name;
	private String description;
	
	public EditSupplyArea(Long supplyAreaID, String name, String description){
		this.supplyAreaID = supplyAreaID;
		this.name = name;
		this.description = description;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.EditSupplyArea '" + name + "', '" + description + "', " + supplyAreaID);
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
