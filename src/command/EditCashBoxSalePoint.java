package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditCashBoxSalePoint implements DatabaseCommand {
	
	private Long salePointID;
	private String name;
	private Double commission;
	private Double islrPercentage;
		
	public EditCashBoxSalePoint(Long salePointID, String name, Double commission, Double islrPercentage){
		this.salePointID = salePointID;
		this.name = name;
		this.commission = commission;
		this.islrPercentage = islrPercentage;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement("exec dbo.EditCashBoxSalePoint '" + name + "', " + commission + ", "
					+ islrPercentage + ", " + salePointID);
			ps.execute();
		}
		finally {
			ps.close();
		}		
		
		return salePointID;
	}

}
