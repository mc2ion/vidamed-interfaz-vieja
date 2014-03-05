package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import domain.Unit;

public class GetUnit implements DatabaseCommand {
	
	private Long unitID;
	
	public GetUnit(Long unitID){
		this.unitID = unitID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		Unit u = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetUnit " + unitID);
			rs = ps.executeQuery();

			if (rs.next()) {
				u = new Unit();
				u.setUnitID(rs.getLong(1));
				u.setName(rs.getString(2));
				u.setDescription(rs.getString(3));
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return u;
	}

}
