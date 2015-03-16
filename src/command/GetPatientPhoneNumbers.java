package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.PatientPhoneNumber;

public class GetPatientPhoneNumbers implements DatabaseCommand {
	
	private Long patientID;
	
	public GetPatientPhoneNumbers(Long patientID){
		this.patientID = patientID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<PatientPhoneNumber> ppns = new ArrayList<PatientPhoneNumber>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetPatientPhoneNumbers " + patientID);
			rs = ps.executeQuery();

			while (rs.next()) {
				PatientPhoneNumber ppn = new PatientPhoneNumber();
				ppn.setPhoneNumberID(rs.getLong(1));
				ppn.setPatientID(rs.getLong(2));
				ppn.setType(rs.getString(3));
				ppn.setPhoneNumber(rs.getString(4));
				ppns.add(ppn);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return ppns;
	}

}
