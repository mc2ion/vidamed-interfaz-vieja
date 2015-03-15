package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import domain.SupplyInventory;
import domain.SupplyProvider;

public class GetSupplyInventory implements DatabaseCommand {
	
	private Long supplyInventoryID;
	
	public GetSupplyInventory(Long supplyInventoryID){
		this.supplyInventoryID = supplyInventoryID;
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {

		SupplyInventory s = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		DateFormat fromFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		fromFormat.setLenient(false);
		DateFormat toFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		toFormat.setLenient(false);
		
		try {
			ps = conn.prepareStatement("exec dbo.GetSupplyInventory " + supplyInventoryID);
			rs = ps.executeQuery();

			if (rs.next()) {
				s = new SupplyInventory();
				s.setSupplyInventoryID(rs.getLong(1));
				s.setSupplyID(rs.getLong(2));
				s.setManufacturer(rs.getString(3));
				s.setBoxes(rs.getLong(4));
				s.setAmountPerBox(rs.getLong(5));
				s.setAmount(rs.getLong(6));
				s.setPurchasePrice(rs.getDouble(7));
				s.setSalePrice(rs.getDouble(8));

				String dateStr = rs.getString(9);
				Date date;
				try {
					if (dateStr != null){
						date = fromFormat.parse(dateStr);
						s.setIncomingDate(toFormat.format(date));
					}
				} catch (ParseException e1) {
					e1.printStackTrace();
				}
				
				SupplyProvider p = new SupplyProvider();
				p.setProviderID(rs.getLong(10));
				s.setProvider(p);
				
				s.setLotNumber(rs.getString(11));
				s.setExpirationDate(rs.getString(12));
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return s;
	}

}
