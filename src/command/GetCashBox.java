package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import domain.CashBox;

public class GetCashBox implements DatabaseCommand {
	
	private Long cashBoxID;
	
	public GetCashBox(Long cashBoxID){
		this.cashBoxID = cashBoxID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		CashBox cb = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetCashBox " + cashBoxID);
			rs = ps.executeQuery();

			if (rs.next()) {
				cb = new CashBox();
				cb.setCashBoxID(rs.getLong(1));
				cb.setName(rs.getString(2));
				cb.setDescription(rs.getString(3));
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return cb;
	}

}
