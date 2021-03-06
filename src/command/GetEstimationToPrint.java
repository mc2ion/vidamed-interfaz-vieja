package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import domain.Estimation;

public class GetEstimationToPrint implements DatabaseCommand {
	
	private String estimationID;
	
	public GetEstimationToPrint(String estimationID){
		this.estimationID = estimationID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		Estimation u = new Estimation();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetEstimationToPrint " + estimationID);
			rs = ps.executeQuery();
			if (rs.next()) {
				u.setId(rs.getLong(1));
				u.setIdentityCard(rs.getString(2));
				u.setFirstName(rs.getString(3));
				u.setLastName(rs.getString(4));
				u.setSpecialistName(rs.getString(6) + " " + rs.getString(7));
				u.setResponsibleName(rs.getString(8));
				u.setPolicyHolderID(rs.getString(9));
				u.setPolicyHolderName(rs.getString(10));
				u.setTotal(rs.getString(11), rs.getDouble(11));
				u.setEditionDate(rs.getString(12));
				u.setCreationUser(rs.getString(14) + " " +  rs.getString(15));
				if((Long)rs.getLong(16)!=0){
					u.setEditionUser(rs.getString(17) + " " +  rs.getString(18));
				} else {
					u.setEditionUser(null);
				}
				
				u.setTotalWithDiscount(rs.getString(19), rs.getDouble(19));
				u.setTotalDollar(rs.getString(20), rs.getDouble(20));
				u.setTotalWithDiscountDollar(rs.getString(21), rs.getDouble(21));
				u.setExchangeRate(rs.getString(22), rs.getDouble(22));
				u.setExchangeRateDate(rs.getString(23));
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return u;
	}

}
