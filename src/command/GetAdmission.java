package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import domain.Admission;

public class GetAdmission implements DatabaseCommand {
	
	private Long id;
	
	public GetAdmission(long id){
		this.id = id;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		

		Admission u = new Admission();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetAdmission " + id);
			rs = ps.executeQuery();

			if (rs.next()) {
				System.out.println("a" +rs.getLong(1) );
				u.setAdmissionID(rs.getLong(1));
				u.setEstimationID(rs.getLong(2));
				u.setPatientID(rs.getLong(3));
				u.setIdentityCard(rs.getString(4));
				u.setFirstName(rs.getString(5));
				u.setLastName(rs.getString(6));
				u.setIsAdult(rs.getInt(7));
				u.setResponsibleID(rs.getLong(8));
				u.setResponsibleName(rs.getString(9));
				u.setObservation(rs.getString(10));
				u.setStatusID(rs.getLong(11));
				u.setStatusName(rs.getString(12));
				u.setReasonID(rs.getLong(13));
				u.setReasonName(rs.getString(14));
				u.setAdmissionDate(rs.getString(15));
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return u;
	}

}
