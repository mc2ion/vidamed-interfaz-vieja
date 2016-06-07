package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.ProtocolService;

public class GetProtocolServices implements DatabaseCommand {
	
	public String protocolID;
	public String scaleID;
	public Long serviceTypeID;
	
	public GetProtocolServices(String protocolID, String scaleID,
			Long serviceTypeID) {
		this.protocolID = protocolID;
		this.scaleID 	= scaleID;
		this.serviceTypeID = serviceTypeID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<ProtocolService> p = new ArrayList<ProtocolService>();
		System.out.println(protocolID + " "+ scaleID);
		try {
			ps = conn.prepareStatement("exec dbo.GetProtocolServices " + protocolID + ", " + scaleID + ", " + serviceTypeID);
			
			rs = ps.executeQuery();

			while (rs.next()) {
				ProtocolService u = new ProtocolService();
				u.setServiceID(rs.getLong(1));
				u.setServiceName(rs.getString(2));
				u.setTotal(rs.getString(3));
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