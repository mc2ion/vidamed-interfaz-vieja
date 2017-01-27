package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.Patient;
import domain.PaymentResponsible;
import domain.PendingBills;
import domain.Specialist;

public class GetPendingBills implements DatabaseCommand {
	
	public GetPendingBills(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<PendingBills> admissions = new ArrayList<PendingBills>();;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetPendingBills");
			rs = ps.executeQuery();

			while (rs.next()) {
				PendingBills u = new PendingBills();
				u.setBillID(rs.getLong(1));
				u.setEstimationID(rs.getLong(2));
				
				Patient p = new Patient();
				p.setPatientID(rs.getLong(3));
				p.setFirstName(rs.getString(4));
				p.setLastName(rs.getString(5));
				u.setPatient(p);
				
				Specialist e = new Specialist();
				e.setId(rs.getLong(6));
				e.setFirstName(rs.getString(7));
				e.setLastName(rs.getString(8));
				u.setSpecialist(e);
				
				PaymentResponsible pr = new PaymentResponsible();
				pr.setId(rs.getLong(9));
				pr.setName(rs.getString(10));
				u.setPaymentResposible(pr);
				
				u.setTotal(rs.getString(11));
				u.setAdmissionID(rs.getLong(12));
				u.setTotalWithDiscount(rs.getString(13));
				u.setTotalPaid(rs.getString(14));
				u.setHasMultiplePaymentResponsibles(rs.getInt(15));
				u.setCreditNoteID(rs.getLong(16));
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
