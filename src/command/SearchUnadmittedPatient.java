package command;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.Patient;

public class SearchUnadmittedPatient implements DatabaseCommand {
	
	private String ced;
	private String type;
	
	public SearchUnadmittedPatient(String ced, String type){
		this.ced = ced;
		this.type = type;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement sta = null;
		ArrayList<Patient> patients = new ArrayList<Patient>();
		// 1 - adulto. 0 - pediatrico
		if (type.equals("1"))
			sta = conn.prepareStatement("exec dbo.SearchUnadmittedAdultPatient '" + ced + "'");
		else
			sta = conn.prepareStatement("exec dbo.SearchUnadmittedPediatricPatient '" + ced + "'");
		
		try{
			ResultSet rs = sta.executeQuery();
			while (rs.next()) {
					Patient patient = new Patient();
					patient.setPatientID(rs.getLong(1));
					patient.setIsAdult(rs.getInt(2));
					patient.setIdentityCard(rs.getString(3));
					patient.setFirstName(rs.getString(4));
					patient.setLastName(rs.getString(5));
					patients.add(patient);
			}
			rs.close();
			sta.close();
			
		}catch(Exception e)
		{
			  CallableStatement cstmt = conn.prepareCall("{? = call dbo.SearchUnadmittedAdultPatient(?)}");
		      cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
		      cstmt.setString(2, ced);
		      cstmt.execute();
		      Patient patient = new Patient();
			  patient.setPatientID(cstmt.getLong(1));
			  patients.add(patient);
			  sta.close();
		}
		
		return patients;
	}

}