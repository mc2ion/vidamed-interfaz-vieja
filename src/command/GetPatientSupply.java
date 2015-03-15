package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import domain.PatientSupply;
import domain.Supply;
import domain.SupplyInventory;

public class GetPatientSupply implements DatabaseCommand {
	
	private Long supplyPatientId;
	
	
	public GetPatientSupply(Long supplyPatientId){
		this.supplyPatientId = supplyPatientId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PatientSupply pSupply = new PatientSupply();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetPatientSupply " + supplyPatientId);
			rs = ps.executeQuery();

			if (rs.next()) {
				pSupply.setPatientSupplyID(rs.getLong(1));
				pSupply.setAdmissionID(rs.getLong(2));
				pSupply.setSupplyID(rs.getLong(3));
				pSupply.setSupplyName(rs.getString(4));
				pSupply.setSupplyForm(rs.getString(5));
				pSupply.setAmount(rs.getString(6));
				
				SupplyInventory inventory = new SupplyInventory();
				inventory.setSupplyInventoryID(rs.getLong(7));
				inventory.setManufacturer(rs.getString(8));
				inventory.setLotNumber(rs.getString(9));
				inventory.setExpirationDate(rs.getString(10));
				pSupply.setSupplyInventory(inventory);
				
				Supply supply = new Supply();
				supply.setDose(rs.getDouble(11));
				supply.setDoseUnitID(rs.getLong(12));
				supply.setDoseUnitAbbrev(rs.getString(13));
				pSupply.setSupply(supply);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return pSupply;
	}

}
