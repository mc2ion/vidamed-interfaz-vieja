package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.SupplyProvider;

public class GetSupplyProviders implements DatabaseCommand {

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<SupplyProvider> supplyProviders = new ArrayList<SupplyProvider>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetSupplyProviders ");
			rs = ps.executeQuery();

			while (rs.next()) {
				SupplyProvider s = new SupplyProvider();
				s.setProviderID(rs.getLong(1));
				s.setName(rs.getString(2));

				supplyProviders.add(s);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return supplyProviders;
	}

}
