package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.Protocol;

public class GetProtocols implements DatabaseCommand {
	
	public GetProtocols(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<Protocol> p = new ArrayList<Protocol>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetProtocols");
			rs = ps.executeQuery();

			while (rs.next()) {
				Protocol u = new Protocol();
				u.setProtocolID(rs.getLong(1));
				u.setName(rs.getString(2));
				u.setDescription(rs.getString(3));
				u.setUnitID(rs.getString(4));
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
