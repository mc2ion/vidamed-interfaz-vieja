package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import domain.Supply;

public class GetSupply implements DatabaseCommand {
	
	private Long supplyID;
	
	public GetSupply(Long supplyID){
		this.supplyID = supplyID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		Supply s = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetSupply " + supplyID);
			rs = ps.executeQuery();

			if (rs.next()) {
				s = new Supply();
				s.setSupplyID(rs.getLong(1));
				s.setSupplyAreaID(rs.getLong(2));
				s.setName(rs.getString(3));
				s.setType(rs.getInt(4));
				s.setDescription(rs.getString(5));
				s.setActiveComponent(rs.getString(6));
				s.setSupplyFormID(rs.getLong(7));
				s.setAmount(rs.getLong(8));
				s.setIsRegulated(rs.getInt(9));
				s.setDose(rs.getDouble(10));
				s.setDoseUnitID(rs.getLong(11));
				s.setSupplyAreaName(rs.getString(12));
				s.setSupplyFormName(rs.getString(13));
				s.setDoseUnitAbbrev(rs.getString(14));
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return s;
	}

}
