package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditSupplyInventory implements DatabaseCommand {
	
	private String manufacturer;
	private Long boxes;
	private Long amountPerBox;
	private Double purchasePrice;
	private Double salePrice;
	private Long providerID;
	private String lotNumber;
	private String expirationDate;
	private Long supplyInventoryID;

	public EditSupplyInventory(String manufacturer, Long boxes,
			Long amountPerBox, Double purchasePrice, Double salePrice,
			Long providerID, String lotNumber, String expirationDate,
			Long supplyInventoryID) {
		
		this.manufacturer = manufacturer;
		this.boxes = boxes;
		this.amountPerBox = amountPerBox;
		this.purchasePrice = purchasePrice;
		this.salePrice = salePrice;
		this.providerID = providerID;
		this.lotNumber = lotNumber;
		this.expirationDate = expirationDate;
		this.supplyInventoryID = supplyInventoryID;
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {

		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.EditSupplyInventory '" + manufacturer + "', " + boxes + ", " + 
					amountPerBox + ", " + purchasePrice + ", " + salePrice + ", " + 
					providerID + ", '" + lotNumber + "', '" + expirationDate + "', " + supplyInventoryID);
			ps.execute();
		}
		catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
