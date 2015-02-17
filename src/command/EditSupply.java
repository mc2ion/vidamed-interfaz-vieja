package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditSupply implements DatabaseCommand {
	
	private Long supplyID;
	private String name;
	private Integer type;
	private String description;
	private String activeComponent;
	private String manufacturer;
	private Long supplyFormID;
	private Long amount;
	private Double unitPrice;
	private Integer isRegulated;
	private Double dose;
	private Long doseUnitID;
	
	public EditSupply(Long supplyID, String name, Integer type, String description, String activeComponent, String manufacturer, Long supplyFormID, 
			Long amount, Double unitPrice, Integer isRegulated, Double dose, Long doseUnitID){
		this.supplyID = supplyID;
		this.name = name;
		this.type = type;
		this.description = description;
		this.activeComponent = activeComponent;
		this.manufacturer = manufacturer;
		this.supplyFormID = supplyFormID;
		this.amount = amount;
		this.unitPrice = unitPrice;
		this.isRegulated = isRegulated;
		this.dose = dose;
		this.doseUnitID = doseUnitID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.EditSupply '" + name + "', " + type + ", '" + 
						description + "', '" + activeComponent + "', '" + manufacturer + "', " + supplyFormID + ", " + 
						amount + ", " + unitPrice + ", " + isRegulated + ", " + supplyID + ", " + dose + ", " + doseUnitID);
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
