package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.Estimation;

public class GetEstimations implements DatabaseCommand {
	
	public GetEstimations(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<Estimation> p = new ArrayList<Estimation>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetEstimations");
			rs = ps.executeQuery();

			while (rs.next()) {
				Estimation u = new Estimation();
				u.setId(rs.getLong(1));
				u.setFirstName(rs.getString(2));
				u.setLastName(rs.getString(3));
				u.setIsAdult(rs.getString(4));
				u.setDiscount(rs.getString(5));
				u.setTotal(rs.getString(6));
				u.setEditionDate(rs.getString(7));
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
