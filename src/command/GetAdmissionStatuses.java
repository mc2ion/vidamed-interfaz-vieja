package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.AdmissionStatus;

public class GetAdmissionStatuses implements DatabaseCommand {
	
	public GetAdmissionStatuses(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<AdmissionStatus> admissions = new ArrayList<AdmissionStatus>();;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetAdmissionStatuses");
			rs = ps.executeQuery();

			while (rs.next()) {
				AdmissionStatus u = new AdmissionStatus();
				u.setId(rs.getLong(1));
				u.setName(rs.getString(2));
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
