package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AddSupplyInventory implements DatabaseCommand {
	
	private Long supplyID;
	private String manufacturer;
	private Long boxes;
	private Long amountPerBox;
	private Double purchasePrice;
	private Double salePrice;
	private Long providerID;
	private String lotNumber;
	private String expirationDate;

	public AddSupplyInventory(Long supplyID, String manufacturer, Long boxes,
			Long amountPerBox, Double purchasePrice, Double salePrice,
			Long providerID, String lotNumber, String expirationDate) {
		this.supplyID = supplyID;
		this.manufacturer = manufacturer;
		this.boxes = boxes;
		this.amountPerBox = amountPerBox;
		this.purchasePrice = purchasePrice;
		this.salePrice = salePrice;
		this.providerID = providerID;
		this.lotNumber = lotNumber;
		this.expirationDate = expirationDate;
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {

		PreparedStatement ps = null;
		ResultSet rs = null;
		Long supplyInventoryID = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.AddSupplyInventory " + supplyID + ", '" + manufacturer + "', " + boxes + ", " + 
						amountPerBox + ", " + purchasePrice + ", " + salePrice + ", " + 
						providerID + ", '" + lotNumber + "', '" + expirationDate + "'");
			rs = ps.executeQuery();
			if (rs.next()) {
				supplyInventoryID = rs.getLong(1);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return supplyInventoryID;
	}

}
