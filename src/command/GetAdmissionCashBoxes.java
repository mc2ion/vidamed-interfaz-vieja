package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.CashBox;

public class GetAdmissionCashBoxes implements DatabaseCommand {
	
	public GetAdmissionCashBoxes(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<CashBox> cbs = new ArrayList<CashBox>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetAdmissionCashBoxes");
			rs = ps.executeQuery();

			while(rs.next()) {
				CashBox cb = new CashBox();
				cb.setCashBoxID(rs.getLong(1));
				cb.setName(rs.getString(2));
				cb.setDescription(rs.getString(3));
				cb.setIsOpen(rs.getInt(4));
				cb.setInitialAmount(rs.getDouble(5));
				cb.setTotalAmount(rs.getDouble(6));
				cbs.add(cb);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return cbs;
	}

}
