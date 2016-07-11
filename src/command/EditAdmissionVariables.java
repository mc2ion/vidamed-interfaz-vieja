package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditAdmissionVariables implements DatabaseCommand {
	
	private Integer roomDays;
	private Double orHours;
	private Long admissionId;
	
	
	public EditAdmissionVariables(Long admissionId, Double orHours, Integer roomDays){
		this.admissionId = admissionId;
		this.orHours 	 = orHours;
		this.roomDays 	 = roomDays;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.EditAdmissionVariables " + orHours + ", " + roomDays + ", " + admissionId);
			ps.execute();
		}
		catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		finally {
			ps.close();
		}		
		return 1;
	}

}
