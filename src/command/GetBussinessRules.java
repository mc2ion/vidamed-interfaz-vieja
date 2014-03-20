package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.BussinessRules;

public class GetBussinessRules implements DatabaseCommand {
	
	public GetBussinessRules(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<BussinessRules> bussinessList = new ArrayList<BussinessRules>();;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetBussinessRules");
			rs = ps.executeQuery();

			while (rs.next()) {
				BussinessRules b = new BussinessRules();
				b.setId(rs.getLong(1));
				b.setName(rs.getString(2));
				bussinessList.add(b);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return bussinessList;
	}

}
