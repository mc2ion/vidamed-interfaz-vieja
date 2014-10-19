package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import domain.Bed;

public class GetBed implements DatabaseCommand {
	
	private String bedId;
	
	public GetBed(String bedId){
		this.bedId = bedId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		Bed bed = new Bed();
		try {
			ps = conn.prepareStatement("exec dbo.GetBed " + bedId);
			rs = ps.executeQuery();

			if (rs.next()) {
				bed.setId(rs.getLong(1));
				bed.setName(rs.getString(2));
				bed.setLocationId(rs.getLong(3));
				bed.setLocationName(rs.getString(4));
				bed.setOccuped(rs.getInt(5));
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		return bed;
	}

}
