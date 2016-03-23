package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.PatientSupply;

public class GetSuppliesAdmissionCosts implements DatabaseCommand {
	Long admissionId;
	
	public GetSuppliesAdmissionCosts(Long admissionId){
		this.admissionId = admissionId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		ArrayList<PatientSupply> costs = new ArrayList<PatientSupply>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetSuppliesAdmissionCosts " + admissionId);
			rs = ps.executeQuery();

			while (rs.next()) {
				PatientSupply s = new PatientSupply();
				s.setProtocolScaleID(rs.getLong(1));
				s.setProtocolScaleName(rs.getString(2));
				s.setSupplyID(rs.getLong(3));
				s.setSupplyName(rs.getString(4));
				s.setAmount(rs.getString(5));
				s.setUnitPrice(rs.getString(6));
				s.setTotal(rs.getString(7));
				
				costs.add(s);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return costs;
	}
}

