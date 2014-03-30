package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import domain.Patient;

public class SearchPatient implements DatabaseCommand {
	
	private String ced;
	private String type;
	
	public SearchPatient(String ced, String type){
		this.ced = ced;
		this.type = type;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement sta = null;
		Patient patient = null;
		
		// 1 - adulto. 0 - pediatrico
		if (type.equals("1"))
			sta = conn.prepareStatement("exec dbo.SearchAdultPatient '" + ced + "'");
		else
			sta = conn.prepareStatement("exec dbo.SearchPediatricPatient '" + ced + "'");
		
		ResultSet rs = sta.executeQuery();
		
		if (rs.next()) {
			patient = new Patient();
			patient.setPatientID(rs.getLong(1));
			patient.setIsAdult(rs.getInt(2));
			patient.setIdentityCard(rs.getString(3));
			patient.setFirstName(rs.getString(4));
			patient.setLastName(rs.getString(5));
		}
		
		rs.close();
		sta.close();
		
		return patient;
	}

}
