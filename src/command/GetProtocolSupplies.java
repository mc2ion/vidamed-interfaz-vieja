package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.ProtocolSupplies;

public class GetProtocolSupplies implements DatabaseCommand {
	
	public String protocolID;
	public String scaleID;
	
	
	public GetProtocolSupplies(String protocolID, String scaleID){
		this.protocolID = protocolID;
		this.scaleID 	= scaleID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<ProtocolSupplies> p = new ArrayList<ProtocolSupplies>();
		System.out.println(protocolID + " "+ scaleID);
		try {
			ps = conn.prepareStatement("exec dbo.GetProtocolSupplies " + protocolID + ", " + scaleID);
			
			rs = ps.executeQuery();

			while (rs.next()) {
				ProtocolSupplies u = new ProtocolSupplies();
				u.setSupplyID(rs.getLong(1));
				u.setName(rs.getString(2));
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
