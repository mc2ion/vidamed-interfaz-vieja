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
	private Long supplyFormID;
	private Long amount;
	private Integer isRegulated;
	private Double dose;
	private Long doseUnit;
	
	public AddSupply(Long supplyAreaID, String name, Integer type, String description, String activeComponent, Long supplyFormID, Long amount, 
			Integer isRegulated, Double dose, Long doseUnit){
		this.supplyAreaID = supplyAreaID;
		this.name = name;
		this.type = type;
		this.description = description;
		this.activeComponent = activeComponent;
		this.supplyFormID = supplyFormID;
		this.amount = amount;
		this.isRegulated = isRegulated;
		this.dose = dose;
		this.doseUnit = doseUnit;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		Long supplyID = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.AddSupply " + supplyAreaID + ", '" + name + "', " + type + ", '" + 
						description + "', '" + activeComponent + "', " + supplyFormID + ", " + 
						amount + ", " + isRegulated + ", " + dose + ", " + doseUnit);
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
