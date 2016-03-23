package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ApplyPatientEstimationSupply implements DatabaseCommand {
	
	private Long admissionID;
	private Long protocolScaleID;
	private Long supplyID;
	private Long amount;

	public ApplyPatientEstimationSupply(Long admissionID, Long protocolScaleID, Long supplyID, Long amount){
		this.admissionID = admissionID;
		this.protocolScaleID = protocolScaleID;
		this.supplyID = supplyID;
		this.amount = amount;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement("exec ApplyPatientEstimationSupply " + admissionID + "," + protocolScaleID + ", " + supplyID + ", " + 
					amount);
			ps.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}	
		
		return (Long) new Long(1);
	}
}
