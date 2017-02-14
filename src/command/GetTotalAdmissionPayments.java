package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import domain.Admission;

public class GetTotalAdmissionPayments implements DatabaseCommand {
	
	private Long id;
	
	public GetTotalAdmissionPayments(long id){
		this.id = id;
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {

		Admission u = new Admission();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetTotalAdmissionPayments " + id);
			rs = ps.executeQuery();

			if (rs.next()) {
				u.setAdmissionID(rs.getLong(1));
				u.setIdentityCard(rs.getString(2));
				u.setFirstName(rs.getString(3));
				u.setLastName(rs.getString(4));
				u.setTotal(rs.getString(5), rs.getDouble(5));
				u.setBillID(rs.getLong(6));
				u.setResponsiblePayment(rs.getString(7), rs.getDouble(7));
				u.setPatientPayment(rs.getString(8), rs.getDouble(8));
				u.setDischargeDate(rs.getString(9));
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return u;
	}

}
