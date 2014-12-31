package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class GenerateEstimationRates implements DatabaseCommand {
	
	private String estimationid;
	
	public GenerateEstimationRates(String estimationid){
		this.estimationid = estimationid;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GenerateEstimationRates " + estimationid );
			System.out.println(estimationid);
			ps.executeUpdate();
		}
		finally {
			ps.close();
		}		
		
		return (long) 1;
	}

}
