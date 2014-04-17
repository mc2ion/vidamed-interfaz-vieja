package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.PatientSupply;

public class GetPatientServicesByAdmission implements DatabaseCommand {
	
	private Long id;
	private Long servId;
	
	
	public GetPatientServicesByAdmission(Long id, Long servId){
		this.id = id;
		this.servId = servId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<PatientSupply> supplies = new ArrayList<PatientSupply>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetPatientServicesByAdmission " + id + " , " + servId);
			rs = ps.executeQuery();

			while (rs.next()) {
				PatientSupply pSupply = new PatientSupply();
				pSupply.setAdmissionID(rs.getLong(1));
				pSupply.setServicePatientID(rs.getLong(2));
				pSupply.setServiceID(rs.getLong(3));
				pSupply.setServiceName(rs.getString(4));
				pSupply.setServicePrice(rs.getString(5));
				pSupply.setAssociatedFile(rs.getString(6));
				supplies.add(pSupply);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return supplies;
	}

}
