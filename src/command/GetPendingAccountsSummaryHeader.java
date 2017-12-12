package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class GetPendingAccountsSummaryHeader implements DatabaseCommand {

	private String from 			= null;
	private String to 				= null;

	public GetPendingAccountsSummaryHeader(String from, String to) {
		this.from = from;
		this.to = to;
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		ArrayList<String> pList = new ArrayList<String>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec GetPendingAccountsSummaryHeader '" + this.from + "','" + this.to + "'");
			rs = ps.executeQuery();

			pList.add("Responsable de Pago");

			while (rs.next()) {
				pList.add(rs.getString(1));
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return pList;
	}
}
