package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class SetDischarge implements DatabaseCommand {
	
	private Long userID;
	private Long dischargeID;
	
	
	public SetDischarge(Long userID, Long dischargeID){
		this.userID 		= userID;
		this.dischargeID 	= dischargeID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.SetDischarge " + userID + "," + dischargeID);
			ps.execute();
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}