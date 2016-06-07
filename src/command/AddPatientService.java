package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AddPatientService implements DatabaseCommand {
	
	private Long admissionId;
	private Long serviceId;
	private Long protocolScaleId;
		
	public AddPatientService(Long admissionId, Long serviceId, Long protocolScaleId){
		this.admissionId = admissionId;
		this.serviceId 	 = serviceId;
		this.protocolScaleId = protocolScaleId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		Long serviceID = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.AddPatientService " + admissionId + ", " + serviceId + ", " + protocolScaleId);
			rs = ps.executeQuery();
			if (rs.next()) {
				serviceID = rs.getLong(1);
			}
		}
		finally {
			ps.close();
		}		
		
		return serviceID;
	}
}
