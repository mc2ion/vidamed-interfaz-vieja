package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.Unit;

public class GetUnits implements DatabaseCommand {
	
	public GetUnits(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<Unit> units = new ArrayList<Unit>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetUnits");
			rs = ps.executeQuery();

			while(rs.next()) {
				Unit u = new Unit();
				u.setUnitID(rs.getLong(1));
				u.setName(rs.getString(2));
				u.setDescription(rs.getString(3));
				units.add(u);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return units;
	}

}
