package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.Admission;

public class GetAdmissions implements DatabaseCommand {
	
	public GetAdmissions(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<Admission> admissions = new ArrayList<Admission>();;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetAdmissions");
			rs = ps.executeQuery();

			while (rs.next()) {
				Admission u = new Admission();
				u.setAdmissionID(rs.getLong(1));
				u.setPatientID(rs.getLong(2));
				u.setFirstName(rs.getString(3));
				u.setLastName(rs.getString(4));
				u.setIsAdult(rs.getInt(5));
				u.setResponsibleID(rs.getLong(6));
				u.setResponsibleName(rs.getString(7));
				u.setStatusID(rs.getLong(8));
				u.setStatusName(rs.getString(9));
				u.setReasonID(rs.getLong(10));
				u.setReasonName(rs.getString(11));
				u.setIdentityCard(rs.getString(12));
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
