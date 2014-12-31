package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import domain.Estimation;

public class GetEstimation implements DatabaseCommand {
	
	private String estimationID;
	
	public GetEstimation(String estimationID){
		this.estimationID = estimationID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		Estimation u = new Estimation();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetEstimation " + estimationID);
			rs = ps.executeQuery();
			if (rs.next()) {
				u.setId(rs.getLong(1));
				u.setPatientId(rs.getLong(2));
				u.setIdentityCard(rs.getString(3));
				u.setFirstName(rs.getString(4));
				u.setLastName(rs.getString(5));
				u.setUnitId(rs.getLong(6));
				u.setSpecialistId(rs.getLong(7));
				u.setPaymentResponsibleId(rs.getLong(8));
				u.setHasGuaranteeLetter(rs.getInt(9));
				u.setIsPolicyHolder(rs.getInt(10));
				u.setPolicyHolderIdentityCard(rs.getString(11));
				u.setPolicyHolderName(rs.getString(12));
				u.setClinicTypeID(rs.getLong(13));
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return u;
	}

}
