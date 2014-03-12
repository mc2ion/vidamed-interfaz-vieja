package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import domain.SupplyArea;

public class GetSupplyArea implements DatabaseCommand {
	
	private Long supplyAreaID;
	
	public GetSupplyArea(Long supplyAreaID){
		this.supplyAreaID = supplyAreaID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		SupplyArea sa = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetSupplyArea " + supplyAreaID);
			rs = ps.executeQuery();

			if (rs.next()) {
				sa = new SupplyArea();
				sa.setSupplyAreaID(rs.getLong(1));
				sa.setName(rs.getString(2));
				sa.setDescription(rs.getString(3));
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return sa;
	}

}
