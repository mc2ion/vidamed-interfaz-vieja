package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import domain.SupplyProvider;
import domain.SupplyInventory;

public class GetSupplyInventories implements DatabaseCommand {
	
	private Long supplyID;
	
	public GetSupplyInventories(Long supplyID){
		this.supplyID = supplyID;
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<SupplyInventory> supplyInventories = new ArrayList<SupplyInventory>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		DateFormat fromFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		fromFormat.setLenient(false);
		DateFormat toFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		toFormat.setLenient(false);
		
		try {
			ps = conn.prepareStatement("exec dbo.GetSupplyInventories " + supplyID);
			rs = ps.executeQuery();

			while (rs.next()) {
				SupplyInventory s = new SupplyInventory();
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
				
				SupplyProvider provider = new SupplyProvider();
				provider.setProviderID(rs.getLong(10));
				provider.setName(rs.getString(11));
				
				s.setProvider(provider);
				s.setLotNumber(rs.getString(12));
				
				s.setExpirationDate(rs.getString(13));
				

				supplyInventories.add(s);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return supplyInventories;
	}

}
