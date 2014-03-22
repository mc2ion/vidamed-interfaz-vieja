package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.CashBoxSalePoint;

public class GetCashBoxSalePoints implements DatabaseCommand {
	
	private Long cashBoxID;
	
	public GetCashBoxSalePoints(Long cashBoxID){
		this.cashBoxID = cashBoxID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<CashBoxSalePoint> cbsps = new ArrayList<CashBoxSalePoint>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetCashBoxSalePoints " + cashBoxID);
			rs = ps.executeQuery();

			while (rs.next()) {
				CashBoxSalePoint cbsp = new CashBoxSalePoint();
				cbsp.setSalePointID(rs.getLong(1));
				cbsp.setCashBoxID(rs.getLong(2));
				cbsp.setName(rs.getString(3));
				cbsp.setCommission(rs.getDouble(4));
				cbsp.setIslrPercentage(rs.getDouble(5));
				cbsps.add(cbsp);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return cbsps;
	}

}
