package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import domain.BedLocation;

public class SearchLocations implements DatabaseCommand {
	
	public SearchLocations(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement sta = null;
		ArrayList<BedLocation> locationList = new ArrayList<BedLocation>();
		
		sta = conn.prepareStatement("exec dbo.GetBedLocations");
		
		ResultSet rs = sta.executeQuery();
		
		while (rs.next()) {
			BedLocation location = new BedLocation();
			location.setId(rs.getLong(1));
			location.setName(rs.getString(2));
			locationList.add(location);
		}
		
		rs.close();
		sta.close();
		
		return locationList;
	}

}
