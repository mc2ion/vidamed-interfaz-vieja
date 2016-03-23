package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.PatientSupply;

public class GetPatientSuppliesByAdmission implements DatabaseCommand {
	
	private Long id;
	
	
	public GetPatientSuppliesByAdmission(Long id){
		this.id = id;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<PatientSupply> supplies = new ArrayList<PatientSupply>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetPatientSuppliesByAdmission " + id );
			rs = ps.executeQuery();

			while (rs.next()) {
				PatientSupply pSupply = new PatientSupply();
				pSupply.setAdmissionID(rs.getLong(1));
				pSupply.setPatientSupplyID(rs.getLong(2));
				pSupply.setSupplyID(rs.getLong(3));
				pSupply.setSupplyName(rs.getString(4));
				pSupply.setSupplyForm(rs.getString(5));
				pSupply.setAmount(rs.getString(6));
				pSupply.setUnitPrice(rs.getString(7));
				pSupply.setTotal(rs.getString(8));
				pSupply.setProtocolScaleID(rs.getLong(9));
				pSupply.setProtocolScaleName(rs.getString(10));
				pSupply.setBussinessRuleMicroID(rs.getLong(11));
				pSupply.setBussinessRuleMicroName(rs.getString(12));
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
