package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.SupplyArea;

public class GetSupplyAreas implements DatabaseCommand {
	
	public GetSupplyAreas(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<SupplyArea> supplyAreas = new ArrayList<SupplyArea>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetSupplyAreas");
			rs = ps.executeQuery();

			while(rs.next()) {
				SupplyArea sa = new SupplyArea();
				sa.setSupplyAreaID(rs.getLong(1));
				sa.setName(rs.getString(2));
				sa.setDescription(rs.getString(3));
				supplyAreas.add(sa);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return supplyAreas;
	}

}
