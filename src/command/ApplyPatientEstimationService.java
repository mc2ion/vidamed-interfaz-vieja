package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ApplyPatientEstimationService implements DatabaseCommand {
	
	private Long admissionID;
	private Long protocolScaleID;
	private Long serviceID;

	public ApplyPatientEstimationService(Long admissionID, Long protocolScaleID,
			Long serviceID) {
		this.admissionID = admissionID;
		this.protocolScaleID = protocolScaleID;
		this.serviceID = serviceID;
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement("exec ApplyPatientEstimationService " + admissionID + "," + protocolScaleID + ", " + serviceID);
			ps.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}	
		
		return (Long) new Long(1);
	}

}
