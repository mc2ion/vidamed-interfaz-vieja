package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import domain.PendingEstimationDiscount;

public class GetEstimationDiscount implements DatabaseCommand {
	
	private long id;
	
	public GetEstimationDiscount(long id){
		this.id = id;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PendingEstimationDiscount u = new PendingEstimationDiscount();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetEstimationDiscount '" + id + "'");
			rs = ps.executeQuery();

			if (rs.next()) {
				u = new PendingEstimationDiscount();
				u.setDiscountID(rs.getLong(1));
				u.setFirstName(rs.getString(2));
				u.setLastName(rs.getString(3));
				u.setType(rs.getString(4));
				u.setTotal(rs.getString(5));
				u.setAmount(rs.getString(6));
				u.setJustification(rs.getString(7));
				u.setRequestDate(rs.getString(8));
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return u;
	}

}
