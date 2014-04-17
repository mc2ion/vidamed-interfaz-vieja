package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.Admission;

public class GetAcceptedAdmissions implements DatabaseCommand {
	
	public GetAcceptedAdmissions(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<Admission> admissions = new ArrayList<Admission>();;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetAcceptedAdmissions");
			rs = ps.executeQuery();

			while (rs.next()) {
				Admission u = new Admission();
				u.setAdmissionID(rs.getLong(1));
				u.setEstimationID(rs.getLong(2));
				u.setPatientID(rs.getLong(3));
				u.setIdentityCard(rs.getString(4));;
				u.setFirstName(rs.getString(5));
				u.setLastName(rs.getString(6));
				u.setReasonID(rs.getLong(7));
				u.setReasonName(rs.getString(8));
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
