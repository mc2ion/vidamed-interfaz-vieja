package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import domain.PatientService;

public class GetPatientService implements DatabaseCommand {
	
	private Long servicePatientId;
	
	
	public GetPatientService(Long servicePatientId){
		this.servicePatientId = servicePatientId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PatientService pSupply = new PatientService();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetPatientService " + servicePatientId);
			rs = ps.executeQuery();

			while (rs.next()) {
				pSupply.setServicePatientID(rs.getLong(1));
				pSupply.setAdmissionID(rs.getLong(2));
				pSupply.setServiceID(rs.getLong(3));
				pSupply.setServiceName(rs.getString(4));
				pSupply.setServicePrice(rs.getString(5));
				pSupply.setAssociatedFile(rs.getString(6));
				pSupply.setAssociatedReport(rs.getString(7));
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return pSupply;
	}

}
