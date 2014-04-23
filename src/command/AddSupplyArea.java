package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AddSupplyArea implements DatabaseCommand {
	
	private String name;
	private String description;
	
	public AddSupplyArea(String name, String description){
		this.name = name;
		this.description = description;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		Long supplyAreaID = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.AddSupplyArea '" + name + "', '" + description + "'");
			rs = ps.executeQuery();
			if (rs.next()) {
				supplyAreaID = rs.getLong(1);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return supplyAreaID;
	}

}
