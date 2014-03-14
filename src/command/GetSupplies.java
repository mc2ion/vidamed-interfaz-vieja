package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.Supply;

public class GetSupplies implements DatabaseCommand {
	
	private Long supplyAreaID;
	
	public GetSupplies(Long supplyAreaID){
		this.supplyAreaID = supplyAreaID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<Supply> supplies = new ArrayList<Supply>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetSupplies " + supplyAreaID);
			rs = ps.executeQuery();

			while (rs.next()) {
				Supply s = new Supply();
				s.setSupplyID(rs.getLong(1));
				s.setSupplyAreaID(rs.getLong(2));
				s.setName(rs.getString(3));
				s.setType(rs.getInt(4));
				s.setDescription(rs.getString(5));
				s.setActiveComponent(rs.getString(6));
				s.setManufacturer(rs.getString(7));
				s.setSupplyFormID(rs.getLong(8));
				s.setAmount(rs.getLong(9));
				s.setUnitPrice(rs.getDouble(10));
				s.setIsRegulated(rs.getInt(11));
				supplies.add(s);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return supplies;
	}

}