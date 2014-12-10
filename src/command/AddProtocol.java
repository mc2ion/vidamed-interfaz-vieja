package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AddProtocol implements DatabaseCommand {
	
	private String name;
	private String description;
	private String type;
	private String gender;
	private String orhours;
	private String roomdays;
	private String anesthesiatypeid;
			
	public AddProtocol(String name, String description, String type, String gender, String orhours, 
			String roomdays, String anesthesiatypeid) {
		this.name 		 		= name;
		this.description 		= description;
		this.type 		 		= type;
		this.gender 	 		= gender;
		this.orhours	 		= orhours;
		if (roomdays != null) 		this.roomdays	 	 	= roomdays;
		else	this.roomdays = "0";
		this.anesthesiatypeid 	= anesthesiatypeid;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		Long protocolID = null;
		try {
			ps = conn.prepareStatement("exec dbo.AddProtocol '" + name + "', '" + description + "', '" + 
						type + "', '" + gender + "', '" + orhours + "', '" + roomdays + "', '" + 
						anesthesiatypeid + "'");
			rs = ps.executeQuery();
			if (rs.next()) {
				protocolID = rs.getLong(1);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return protocolID;
	}

}
