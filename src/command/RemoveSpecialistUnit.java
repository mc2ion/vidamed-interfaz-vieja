package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RemoveSpecialistUnit implements DatabaseCommand {
	
	private Long specialistID;
	private Long unitID;
	
	public RemoveSpecialistUnit(Long specialistID, Long unitID){
		this.specialistID = specialistID;
		this.unitID = unitID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.RemoveSpecialistUnit " + specialistID + ", " + unitID);
			ps.execute();
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
