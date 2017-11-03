package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.Estimation;

public class GetEstimations implements DatabaseCommand {
	
	private String estimationid 			= null;
	private String identitycard				= null;
	
	public GetEstimations(){}
	
	public GetEstimations(String estimationId, String identitycard) {
		if (estimationId != null && estimationId != "")
			this.estimationid	    = estimationId;
		if (identitycard != null && identitycard != "")
			this.identitycard  	= "'" + identitycard + "'";
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<Estimation> p = new ArrayList<Estimation>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetEstimations " + estimationid + "," + identitycard);
			rs = ps.executeQuery();

			while (rs.next()) {
				Estimation u = new Estimation();
				u.setId(rs.getLong(1));
				u.setFirstName(rs.getString(2));
				u.setLastName(rs.getString(3));
				u.setIsAdult(rs.getString(4));
				u.setDiscount(rs.getString(5));
				u.setTotal(rs.getString(6), rs.getDouble(6));
				u.setEditionDate(rs.getString(7));
				u.setTotalWithDiscount(rs.getString(8), rs.getDouble(8));
				p.add(u);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return p;
	}

}
