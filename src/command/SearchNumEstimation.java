package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import domain.Patient;

public class SearchNumEstimation implements DatabaseCommand {
	
	private String estimationNumber;
	
	public SearchNumEstimation(String estimationNumber){
		this.estimationNumber = estimationNumber;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement sta = null;
		Patient patient = null;
		
		sta = conn.prepareStatement("exec dbo.SearchEstimation '" + estimationNumber + "'");
		
		ResultSet rs = sta.executeQuery();
		
		if (rs.next()) {
			patient = new Patient();
			patient.setEstimationID(rs.getLong(1));
			patient.setPatientID(rs.getLong(2));
			patient.setIdentityCard(rs.getString(3));
			patient.setFirstName(rs.getString(4));
			patient.setLastName(rs.getString(5));
		}
		rs.close();
		sta.close();
		
		return patient;
	}

}
