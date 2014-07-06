package command;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class SetBedOccupation implements DatabaseCommand {
	
	private Long bedId;
	private int occuppied;
	
	
	
	public SetBedOccupation(Long bedId, int occuppied){
		this.bedId 		= bedId;
		this.occuppied  = occuppied;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		try {
			  CallableStatement cstmt = conn.prepareCall("{? = call dbo.SetBedOccupation(?,?)}");
		      cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
		      cstmt.setLong(2, occuppied);
		      cstmt.setLong(3, bedId);
		      cstmt.execute();
		      return cstmt.getLong(1);
		}
		catch (Exception e) {
			e.printStackTrace();
			return -2;
		}
	}

}