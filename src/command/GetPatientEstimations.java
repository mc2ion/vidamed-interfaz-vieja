package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import domain.Estimation;

public class GetPatientEstimations implements DatabaseCommand {
	
	private Long patientID;
	
	
	public GetPatientEstimations(Long patientID){
		this.patientID = patientID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<Estimation> pmList =  new ArrayList<Estimation>();;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetPatientEstimations " + patientID);
			rs = ps.executeQuery();

			while (rs.next()) {
				Estimation pm = new Estimation();
				pm.setId(rs.getLong(1));
				pmList.add(pm);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return pmList;
	}

}
