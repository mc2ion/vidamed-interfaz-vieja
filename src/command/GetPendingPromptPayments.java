package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import domain.PendingPromptPayment;
import domain.Specialist;

public class GetPendingPromptPayments implements DatabaseCommand {
	
	public GetPendingPromptPayments(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<PendingPromptPayment> admissions = new ArrayList<PendingPromptPayment>();;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetPendingPromptPayments");
			rs = ps.executeQuery();

			while (rs.next()) {
				PendingPromptPayment u = new PendingPromptPayment();
				u.setMedicalFeeID(rs.getLong(1));
				u.setBillID(rs.getLong(2));
				
				Specialist e = new Specialist();
				e.setId(rs.getLong(3));
				e.setFirstName(rs.getString(4));
				e.setLastName(rs.getString(5));
				u.setSpecialist(e);
				
				u.setAmount(rs.getString(6));
				u.setBillWasPaid(rs.getInt(7));
				
				admissions.add(u);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return admissions;
	}

}
