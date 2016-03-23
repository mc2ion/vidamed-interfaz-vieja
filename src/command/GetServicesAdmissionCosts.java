package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.Service;

public class GetServicesAdmissionCosts implements DatabaseCommand {
	Long admissionId;
	
	public GetServicesAdmissionCosts(Long admissionId){
		this.admissionId = admissionId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		ArrayList<Service> costs = new ArrayList<Service>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetServicesAdmissionCosts " + admissionId);
			rs = ps.executeQuery();

			while (rs.next()) {
				Service s = new Service();
				s.setServiceTypeID(rs.getLong(1));
				s.setServiceTypeName(rs.getString(2));
				s.setServiceID(rs.getLong(3));
				s.setName(rs.getString(4));
				s.setAmout(rs.getLong(5));
				s.setUnitPrice(rs.getString(6));
				s.setPrice(rs.getString(7));
				
				costs.add(s);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return costs;
	}
}
