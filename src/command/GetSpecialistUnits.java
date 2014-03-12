package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.SpecialistUnit;

public class GetSpecialistUnits implements DatabaseCommand {
	
	private Long specialistID;
	
	public GetSpecialistUnits(Long specialistID){
		this.specialistID = specialistID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<SpecialistUnit> sus = new ArrayList<SpecialistUnit>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetSpecialistUnits " + specialistID);
			rs = ps.executeQuery();

			while (rs.next()) {
				SpecialistUnit su = new SpecialistUnit();
				su.setSpecialistID(rs.getLong(1));
				su.setUnitID(rs.getLong(2));
				sus.add(su);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return sus;
	}

}
