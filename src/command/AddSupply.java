package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AddSupply implements DatabaseCommand {
	
	private Long supplyAreaID;
	private String name;
	private Integer type;
	private String description;
	private String activeComponent;
	private String manufacturer;
	private Long supplyFormID;
	private Long amount;
	private Double unitPrice;
	private Integer isRegulated;
	
	public AddSupply(Long supplyAreaID, String name, Integer type, String description, String activeComponent, String manufacturer, Long supplyFormID, Long amount, Double unitPrice, Integer isRegulated){
		this.supplyAreaID = supplyAreaID;
		this.name = name;
		this.type = type;
		this.description = description;
		this.activeComponent = activeComponent;
		this.manufacturer = manufacturer;
		this.supplyFormID = supplyFormID;
		this.amount = amount;
		this.unitPrice = unitPrice;
		this.isRegulated = isRegulated;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		Long supplyID = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.AddSupply " + supplyAreaID + ", '" + name + "', " + type + ", '" + 
						description + "', '" + activeComponent + "', '" + manufacturer + "', " + supplyFormID + ", " + 
						amount + ", " + unitPrice + ", " + isRegulated);
			rs = ps.executeQuery();
			if (rs.next()) {
				supplyID = rs.getLong(1);
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
		
		return supplyID;
	}

}
