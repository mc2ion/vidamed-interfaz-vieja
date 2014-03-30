package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RemoveCashBox implements DatabaseCommand {
	
	private Long cashBoxID;
	
	public RemoveCashBox(Long cashBoxID){
		this.cashBoxID = cashBoxID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.RemoveCashBox " + cashBoxID);
			ps.execute();
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
