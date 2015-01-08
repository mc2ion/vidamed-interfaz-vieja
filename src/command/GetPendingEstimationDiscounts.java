package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.PendingEstimationDiscount;

public class GetPendingEstimationDiscounts implements DatabaseCommand {
	
	public GetPendingEstimationDiscounts(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<PendingEstimationDiscount> pending = new ArrayList<PendingEstimationDiscount>();;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetPendingEstimationDiscounts");
			rs = ps.executeQuery();

			while (rs.next()) {
				PendingEstimationDiscount u = new PendingEstimationDiscount();
				u = new PendingEstimationDiscount();
				u.setDiscountID(rs.getLong(1));
				u.setFirstName(rs.getString(2));
				u.setLastName(rs.getString(3));
				u.setType(rs.getString(4));
				u.setAmount(rs.getString(5), rs.getDouble(5));
				u.setEstimationID(rs.getLong(6));
				u.setRequestDate(rs.getString(7));
				pending.add(u);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return pending;
	}

}
