package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import domain.PendingMedicalFee;
import domain.Specialist;

public class GetPendingMedicalFees implements DatabaseCommand {
	
	public GetPendingMedicalFees(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<PendingMedicalFee> admissions = new ArrayList<PendingMedicalFee>();;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetPendingMedicalFees");
			rs = ps.executeQuery();

			while (rs.next()) {
				PendingMedicalFee u = new PendingMedicalFee();
				u.setMedicalFeeID(rs.getLong(1));
				u.setBillID(rs.getLong(2));
				u.setBillWasPaid(rs.getInt(3));
				
				Specialist e = new Specialist();
				e.setId(rs.getLong(4));
				e.setFirstName(rs.getString(5));
				e.setLastName(rs.getString(6));
				u.setSpecialist(e);
				
				u.setAmount(rs.getString(7));
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
