package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import domain.AdmissionReasons;

public class GetAdmissionReasons implements DatabaseCommand {
	
	public GetAdmissionReasons(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<AdmissionReasons> admissions = new ArrayList<AdmissionReasons>();;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetAdmissionReasons");
			rs = ps.executeQuery();

			while (rs.next()) {
				AdmissionReasons u = new AdmissionReasons();
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
