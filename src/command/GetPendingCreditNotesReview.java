package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.Patient;
import domain.PaymentResponsible;
import domain.PendingCreditNotesReview;

public class GetPendingCreditNotesReview implements DatabaseCommand {
	
	public GetPendingCreditNotesReview(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<PendingCreditNotesReview> admissions = new ArrayList<PendingCreditNotesReview>();;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetPendingCreditNotesReviews");
			rs = ps.executeQuery();

			while (rs.next()) {
				PendingCreditNotesReview u = new PendingCreditNotesReview();
				u.setCreditNoteID(rs.getLong(1));
				u.setEstimationID(rs.getLong(2));
				
				Patient p = new Patient();
				p.setPatientID(rs.getLong(3));
				p.setFirstName(rs.getString(4));
				p.setLastName(rs.getString(5));
				u.setPatient(p);
				
				PaymentResponsible pr = new PaymentResponsible();
				pr.setId(rs.getLong(6));
				pr.setName(rs.getString(7));
				u.setPaymentResposible(pr);
				
				u.setTotal(rs.getString(8));
				u.setContactName(rs.getString(9));
				u.setContactNumber(rs.getString(10));
				
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
