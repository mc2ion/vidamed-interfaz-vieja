package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditUnit implements DatabaseCommand {
	
	private Long unitID;
	private String name;
	private String description;
	
	public EditUnit(Long unitID, String name, String description){
		this.unitID = unitID;
		this.name = name;
		this.description = description;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.EditUnit '" + name + "', '" + description + "', " + unitID);
			ps.execute();
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
