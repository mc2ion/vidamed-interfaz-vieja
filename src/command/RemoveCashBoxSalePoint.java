package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RemoveCashBoxSalePoint implements DatabaseCommand {
	
	private Long salePointID;
	
	public RemoveCashBoxSalePoint(Long salePointID){
		this.salePointID = salePointID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.RemoveCashBoxSalePoint " + salePointID);
			ps.execute();
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
