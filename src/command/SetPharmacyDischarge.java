package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class SetPharmacyDischarge implements DatabaseCommand {
	
	private Long admissionID;
	
	public SetPharmacyDischarge(Long admissionID){
		this.admissionID = admissionID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.SetPharmacyDischarge " + admissionID);
			ps.execute();
		}
		catch(Exception e){
			return 0;
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
