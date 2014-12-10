package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.Supply;

public class GetAllSuplies implements DatabaseCommand {
	
	public GetAllSuplies(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		

		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<Supply> supplies = new ArrayList<Supply>();;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetAllSupplies");
			rs = ps.executeQuery();

			while (rs.next()) {
				Supply u = new Supply();
				u.setSupplyID(rs.getLong(1));
				u.setName(rs.getString(3));
				supplies.add(u);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return supplies;
	}

}
