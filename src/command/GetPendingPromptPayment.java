package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import domain.PendingPromptPayment;
import domain.Specialist;

public class GetPendingPromptPayment implements DatabaseCommand {
	
	private Long id;
	
	public GetPendingPromptPayment(Long id){
		this.id = id;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		PendingPromptPayment u = new PendingPromptPayment();
		try {
			ps = conn.prepareStatement("exec dbo.GetPromptPayment " + id);
			rs = ps.executeQuery();
			
			if (rs.next()) {
				System.out.println('a');
				u.setMedicalFeeID(rs.getLong(1));
				u.setBillID(rs.getLong(2));
				u.setBillWasPaid(rs.getInt(3));
				u.setBillDate(rs.getString(4));
				
				Specialist e = new Specialist();
				e.setId(rs.getLong(5));
				e.setFirstName(rs.getString(6));
				e.setLastName(rs.getString(7));
				u.setSpecialist(e);
				
				u.setTotalAmount(rs.getString(8));
				u.setDiscountedAmount(rs.getString(9));
				u.setAmount(rs.getString(10));
				
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return u;
	}

}
