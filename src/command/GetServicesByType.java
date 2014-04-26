package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.Service;

public class GetServicesByType implements DatabaseCommand {
	
	private Long serviceID;
	
	public GetServicesByType(Long serviceID){
		this.serviceID = serviceID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<Service> supplies = new ArrayList<Service>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetServicesByType " + serviceID);
			rs = ps.executeQuery();

			while (rs.next()) {
				Service s = new Service();
				s.setServiceID(rs.getLong(1));
				s.setServiceTypeID(rs.getLong(2));
				s.setName(rs.getString(3));
				s.setPrice(rs.getString(4));
				supplies.add(s);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return supplies;
	}

}
