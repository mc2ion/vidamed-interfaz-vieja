package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.AdditionalService;

public class GetAdditionalServices implements DatabaseCommand {
	
	public GetAdditionalServices(){}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {

		ArrayList<AdditionalService> services = new ArrayList<AdditionalService>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetAdditionalServices");
			rs = ps.executeQuery();

			while(rs.next()) {
				AdditionalService s = new AdditionalService();
				s.setAdditionalServiceID(rs.getLong(1));
				s.setAdditionalServiceName(rs.getString(2));
				s.setBussinessRuleMicroID(rs.getLong(3));
				s.setBussinessRuleMicroName(rs.getString(4));
				services.add(s);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return services;
	}

}