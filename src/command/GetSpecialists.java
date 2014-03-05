package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.Specialist;

public class GetSpecialists implements DatabaseCommand {
	
	public GetSpecialists(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<Specialist> specialists = new ArrayList<Specialist>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetSpecialists");
			rs = ps.executeQuery();

			while(rs.next()) {
				Specialist spec = new Specialist();
				spec.setId(rs.getLong(1));
				spec.setIdentityCard(rs.getString(2));
				spec.setFirstName(rs.getString(3));
				spec.setLastName(rs.getString(4));
				spec.setBirthdate(rs.getString(5));
				spec.setSex(rs.getString(6));
				spec.setRif(rs.getString(7));
				spec.setAddress(rs.getString(8));
				spec.setEmail(rs.getString(9));
				specialists.add(spec);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return specialists;
	}

}
