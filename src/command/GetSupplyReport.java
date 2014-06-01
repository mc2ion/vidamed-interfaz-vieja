package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import domain.Supply;

public class GetSupplyReport implements DatabaseCommand {
	
	private String supplyFormId 		= null;
	private String supplyAreaId 		= null; 
	private String name 				= null;
	private String type			    	= null;
	private String activeComponent 	    = null;
	private String manufacturer	 		= null;
	private String minior	 			= null;
	private String senior	 			= null;
	private String isRegulated	 		= null;
	
	
	
	

	
	public GetSupplyReport(){}
	
	public GetSupplyReport(String supplyFormId, String supplyAreaId, String name, String type, String activeComponent, String manufacturer,
							String minior, String senior, String isRegulated){
		if (supplyFormId != null && supplyFormId != "")
			this.supplyFormId 		= supplyFormId;
		if (supplyAreaId != null && supplyAreaId != "")
			this.supplyAreaId  		= supplyAreaId;
		if (name != null && name != "")
			this.name  	= "'" + name + "'";
		if (type != null && type != "")
			this.type	    = type;
		if (activeComponent != null && activeComponent != "")
			this.activeComponent	    = "'" + activeComponent + "'";
		if (manufacturer != null && manufacturer != "")
			this.manufacturer  = "'" + manufacturer + "'";
		if (minior != null && minior != "")
			this.minior  = minior;
		if (senior != null && senior != "")
			this.senior  = senior;
		if (isRegulated != null && isRegulated != "")
			this.isRegulated  = isRegulated;
		
		
		
		
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<Supply> p = new ArrayList<Supply>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetSupplyReport " + supplyFormId + "," + supplyAreaId + ","  + name + "," + type + "," + activeComponent + "," + manufacturer
										+ "," + minior + "," + senior + "," + isRegulated);
			rs = ps.executeQuery();
		
			while (rs.next()) {
				Supply s = new Supply();
				s.setSupplyID(rs.getLong(1));
				s.setSupplyAreaID(rs.getLong(2));
				s.setSupplyAreaName(rs.getString(3));
				s.setName(rs.getString(4));
				s.setType(rs.getInt(5));
				s.setDescription(rs.getString(6));
				s.setActiveComponent(rs.getString(7));
				s.setManufacturer(rs.getString(8));
				s.setSupplyFormID(rs.getLong(9));
				s.setAmount(rs.getLong(10));
				s.setUnitPrice(rs.getDouble(11));
				s.setIsRegulated(rs.getInt(12));
				p.add(s);
			}
		}catch(Exception e){
			e.getStackTrace();
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return p;
	}

}
