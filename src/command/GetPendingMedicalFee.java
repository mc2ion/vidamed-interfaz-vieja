package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import domain.PendingMedicalFee;
import domain.Specialist;

public class GetPendingMedicalFee implements DatabaseCommand {
	
	private Long id;
	
	public GetPendingMedicalFee(Long id){
		this.id = id;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		PendingMedicalFee u = new PendingMedicalFee();
			
		try {
			ps = conn.prepareStatement("exec dbo.GetMedicalFee " + id);
			rs = ps.executeQuery();

			if (rs.next()) {
				u.setMedicalFeeID(rs.getLong(1));
				u.setBillID(rs.getLong(2));
				u.setBillWasPaid(rs.getInt(3));
				u.setBillDate(rs.getString(4));
				
				
				Specialist e = new Specialist();
				e.setId(rs.getLong(5));
				e.setFirstName(rs.getString(6));
				e.setLastName(rs.getString(7));
				u.setSpecialist(e);
				
				u.setAmount(rs.getString(8));
				u.setFeeWasPaid(rs.getInt(9));
				u.setPaymentDate(rs.getString(10));
				
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return u;
	}

}
