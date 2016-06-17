package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import domain.PatientAdditionalService;

public class GetPatientAdditionalService implements DatabaseCommand {
	
	private Long patientAdditionalServiceId;
	
	
	public GetPatientAdditionalService(Long patientAdditionalServiceId){
		this.patientAdditionalServiceId = patientAdditionalServiceId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PatientAdditionalService service = new PatientAdditionalService();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetPatientAdditionalService " + patientAdditionalServiceId);
			rs = ps.executeQuery();

			while (rs.next()) {
				service.setPatientAdditionalServiceID(rs.getLong(1));
				service.setAdmissionID(rs.getLong(2));
				service.setAdditionalServiceID(rs.getLong(3));
				service.setAdditionalServiceName(rs.getString(4));
				service.setBussinessRuleMicroID(rs.getLong(5));
				service.setBussinessRuleMicroName(rs.getString(6));
				service.setAmount(rs.getDouble(7));
				service.setAdditionalServiceDate(rs.getString(8));
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return service;
	}

}

