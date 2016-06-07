package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.PatientEstimationService;

public class GetPatientEstimationServicesByAdmission implements DatabaseCommand {
	
	private Long id;
	private Long serviceId;
	
	public GetPatientEstimationServicesByAdmission(Long id, Long serviceId){
		this.id = id;
		this.serviceId = serviceId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<PatientEstimationService> services = new ArrayList<PatientEstimationService>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetPatientEstimationServicesByAdmission " + id + ", " + serviceId);
			rs = ps.executeQuery();

			while (rs.next()) {
				PatientEstimationService pService = new PatientEstimationService();
				pService.setAdmissionID(rs.getLong(1));
				pService.setBussinessRuleMicroID(rs.getLong(2));
				pService.setBussinessRuleMicroName(rs.getString(3));
				pService.setProtocolScaleID(rs.getLong(4));
				pService.setProtocolScaleName(rs.getString(5));
				pService.setServiceID(rs.getLong(6));
				pService.setServiceName(rs.getString(7));
				pService.setAmount(rs.getLong(8));
				services.add(pService);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return services;
	}

}
