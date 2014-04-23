package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditCashBox implements DatabaseCommand {
	
	private Long cashBoxID;
	private String name;
	private String description;
	
	public EditCashBox(Long unitID, String name, String description){
		this.cashBoxID = unitID;
		this.name = name;
		this.description = description;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.EditCashBox '" + name + "', '" + description + "', " + cashBoxID);
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
