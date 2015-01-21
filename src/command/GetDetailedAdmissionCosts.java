package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.Protocol;

public class GetDetailedAdmissionCosts implements DatabaseCommand {
	Long admissionId;
	
	public GetDetailedAdmissionCosts(Long admissionId){
		this.admissionId = admissionId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		ArrayList<Protocol> costs = new ArrayList<Protocol>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetDetailedAdmissionCosts " + admissionId);
			rs = ps.executeQuery();

			while (rs.next()) {
				Protocol u = new Protocol();
				u.setProtocolScaleID(rs.getLong(1));
				u.setProtocolScaleName(rs.getString(2));
				u.setBussinessRuleMicroID(rs.getLong(3));
				u.setBussinessRuleMicroName(rs.getString(4));
				u.setGeneratedCostTypeID(rs.getLong(5));
				u.setCost(rs.getString(6), rs.getDouble(6));
				u.setEstimationCost(rs.getString(7), rs.getDouble(7));
				costs.add(u);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return costs;
	}
}
