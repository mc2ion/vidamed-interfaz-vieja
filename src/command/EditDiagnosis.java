package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditDiagnosis implements DatabaseCommand {
	
	private String diagnosis;
	private Long estimationId;
	private Long protocolId;

	public EditDiagnosis(Long estimationId, Long protocolId, String diagnosis) {
		this.diagnosis = diagnosis;
		this.estimationId = estimationId;
		this.protocolId = protocolId;
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.EditDiagnosis '" + diagnosis + "'," + estimationId + "," + protocolId);
			ps.execute();
		}
		catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		finally {
			ps.close();
		}		
		return 1;
	}

}
