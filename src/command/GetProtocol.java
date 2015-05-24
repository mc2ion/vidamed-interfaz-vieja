package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import domain.Protocol;

public class GetProtocol implements DatabaseCommand {
	
	private String protocolID;
	
	public GetProtocol(String protocolID){
		this.protocolID = protocolID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		Protocol u = new Protocol();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetProtocol " + protocolID);
			rs = ps.executeQuery();

			while (rs.next()) {
				u.setProtocolID(rs.getLong(1));
				u.setName(rs.getString(2));
				u.setDescription(rs.getString(3));
				u.setType(rs.getString(4));
				u.setGender(rs.getString(5));
				u.setOrHours(rs.getString(6));
				u.setRoomDays(rs.getString(7));
				u.setAnesthesiaID(rs.getString(8));
				u.setUnitID(rs.getString(9));
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return u;
	}

}
