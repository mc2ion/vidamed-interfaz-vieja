package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditProtocol implements DatabaseCommand {
	
	private String name;
	private String description;
	private String type;
	private String gender;
	private String orhours;
	private String roomdays;
	private String anesthesiatypeid;
	private String protocolId;
	private String unitid;
	
			
	public EditProtocol(String name, String description, String type, String gender, String orhours, 
			String roomdays, String anesthesiatypeid, String protocolID, String unitid) {
		this.name 		 		= name;
		this.description 		= description;
		this.type 		 		= type;
		this.gender 	 		= gender;
		this.orhours	 		= orhours;
		if (roomdays != null) 		this.roomdays	 	 	= roomdays;
		else	this.roomdays = "0";
		this.anesthesiatypeid 	= anesthesiatypeid;
		this.protocolId 		= protocolID;
		this.unitid				= unitid;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		//ResultSet rs = null;
		//Long protocolID = null;
		try {
			ps = conn.prepareStatement("exec dbo.EditProtocol '" + name + "', '" + description + "', '" + 
						type + "', '" + gender + "', '" + orhours + "', '" + roomdays + "', '" + 
						anesthesiatypeid + "', '" + unitid + "', '" + protocolId + "'");
			ps.execute();
		}
		finally {
			//rs.close();
			ps.close();
		}		
		
		return 1;
	}

}
