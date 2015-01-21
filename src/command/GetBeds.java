package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.Bed;

public class GetBeds implements DatabaseCommand {
	
	private Long locationID;
	private Long estimationID;
	
	public GetBeds(Long locationID, String estimationID){
		this.locationID   = locationID;
		if (estimationID != null) this.estimationID = Long.valueOf(estimationID);
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<Bed> bedList = new ArrayList<Bed>();
		try {
			if (estimationID != null) 
				ps = conn.prepareStatement("exec dbo.GetAvailableBedsByLocation " + locationID + "," + estimationID);
			else
				ps = conn.prepareStatement("exec dbo.GetAvailableBedsByLocation " + locationID);
					
			rs = ps.executeQuery();

			while (rs.next()) {
				Bed bed = new Bed();
				bed.setId(rs.getLong(1));
				bed.setLocationId(rs.getLong(2));
				bed.setName(rs.getString(3));
				bed.setOccuped(rs.getInt(4));
				bedList.add(bed);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		return bedList;
	}

}
