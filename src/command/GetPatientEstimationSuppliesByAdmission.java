package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.PatientEstimationSupply;

public class GetPatientEstimationSuppliesByAdmission implements DatabaseCommand {
	
	private Long id;
	
	
	public GetPatientEstimationSuppliesByAdmission(Long id){
		this.id = id;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<PatientEstimationSupply> supplies = new ArrayList<PatientEstimationSupply>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetPatientEstimationSuppliesByAdmission " + id );
			rs = ps.executeQuery();

			while (rs.next()) {
				PatientEstimationSupply pSupply = new PatientEstimationSupply();
				pSupply.setAdmissionID(rs.getLong(1));
				pSupply.setBussinessRuleMicroID(rs.getLong(2));
				pSupply.setBussinessRuleMicroName(rs.getString(3));
				pSupply.setProtocolScaleID(rs.getLong(4));
				pSupply.setProtocolScaleName(rs.getString(5));
				pSupply.setSupplyID(rs.getLong(6));
				pSupply.setSupplyName(rs.getString(7));
				pSupply.setAmount(rs.getLong(8));
				pSupply.setInventory(rs.getLong(9));
				pSupply.setStatus(rs.getString(10));
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