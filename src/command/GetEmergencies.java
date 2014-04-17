package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.Bed;
import domain.Emergency;
import domain.LocationType;
import domain.Patient;

public class GetEmergencies implements DatabaseCommand {
	
	public GetEmergencies(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<Emergency> emergencies = new ArrayList<Emergency>();;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetEmergencies");
			rs = ps.executeQuery();

			while (rs.next()) {
				Emergency u = new Emergency();
				u.setId(rs.getLong(1));
				u.setEstimationId(rs.getLong(2));
				
				Patient p = new Patient();
				p.setPatientID(rs.getLong(3));
				p.setFirstName(rs.getString(4));
				p.setLastName(rs.getString(5));
				p.setIsAdult(rs.getInt(6));
				u.setPatient(p);
				
				Bed b = new Bed();
				b.setId(rs.getLong(7));
				b.setName(rs.getString(8));
				u.setBed(b);
				
				LocationType l = new LocationType();
				l.setId(rs.getInt(9));
				l.setName(rs.getString(10));
				u.setLocation(l);
				u.setAdmissionDate(rs.getString(11));
				
				emergencies.add(u);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return emergencies;
	}

}
