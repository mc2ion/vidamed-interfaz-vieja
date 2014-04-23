package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AddCashBoxSalePoint implements DatabaseCommand {
	
	private Long cashBoxID;
	private String name;
	private Double commission;
	private Double islrPercentage;
		
	public AddCashBoxSalePoint(Long cashBoxID, String name, Double commission, Double islrPercentage){
		this.cashBoxID = cashBoxID;
		this.name = name;
		this.commission = commission; 
		this.islrPercentage = islrPercentage;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		Long salePointID = null;
		try {
			ps = conn.prepareStatement("exec dbo.AddCashBoxSalePoint " + cashBoxID + ", '" + 
						name + "', " + commission + ", " + islrPercentage);
			rs = ps.executeQuery();
			if (rs.next()) {
				salePointID = rs.getLong(1);
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
		
		return salePointID;
	}

}
