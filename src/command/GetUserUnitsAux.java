package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import domain.UserUnit;

public class GetUserUnitsAux implements DatabaseCommand {
	
	public GetUserUnitsAux(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<UserUnit> units = new ArrayList<UserUnit>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetUserUnits");
			rs = ps.executeQuery();

			while(rs.next()) {
				UserUnit u = new UserUnit();
				u.setUserUnitID(rs.getLong(1));
				u.setName(rs.getString(2));
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
