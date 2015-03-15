package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.DoseUnit;

public class GetDoseUnits implements DatabaseCommand {

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		ArrayList<DoseUnit> doseUnits = new ArrayList<DoseUnit>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetDoseUnits");
			rs = ps.executeQuery();

			while (rs.next()) {
				DoseUnit u = new DoseUnit();
				u.setId(rs.getLong(1));
				u.setAbbreviation(rs.getString(2));
				u.setName(rs.getString(3));
				
				doseUnits.add(u);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return doseUnits;
	}

}
