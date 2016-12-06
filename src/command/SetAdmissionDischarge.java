package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class SetAdmissionDischarge implements DatabaseCommand {
	
	private Long admissionID;
	private String keyNumber;
	private Double coverageAmount;
	private String guaranteeLetter;
	private Integer hasMultiple;
	
	public SetAdmissionDischarge(Long admissionID, String keyNumber, Double coverageAmount, String guaranteeLetter, Integer hasMultiple){
		this.admissionID = admissionID;
		this.keyNumber = keyNumber;
		this.coverageAmount = coverageAmount;
		this.guaranteeLetter = guaranteeLetter;
		this.hasMultiple = hasMultiple;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.SetAdmissionDischarge " + admissionID + ", " + hasMultiple + ", " + keyNumber + ", " + coverageAmount + ", " + guaranteeLetter);
			ps.execute();
		}
		catch(Exception e){
			return 0;
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
