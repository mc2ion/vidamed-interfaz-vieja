package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.SpecialistPhoneNumber;

public class GetSpecialistPhoneNumbers implements DatabaseCommand {
	
	private Long specialistID;
	
	public GetSpecialistPhoneNumbers(Long specialistID){
		this.specialistID = specialistID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<SpecialistPhoneNumber> spns = new ArrayList<SpecialistPhoneNumber>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetSpecialistPhoneNumbers " + specialistID);
			rs = ps.executeQuery();

			while (rs.next()) {
				SpecialistPhoneNumber spn = new SpecialistPhoneNumber();
				spn.setPhoneNumberID(rs.getLong(1));
				spn.setSpecialistID(rs.getLong(2));
				spn.setType(rs.getString(3));
				spn.setPhoneNumber(rs.getString(4));
				spns.add(spn);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return spns;
	}

}
