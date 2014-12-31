package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import domain.ClinicType;

public class GetClinicTypes implements DatabaseCommand {
	
	public GetClinicTypes(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<ClinicType> ct = new ArrayList<ClinicType>();;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetClinicTypes");
			rs = ps.executeQuery();

			while (rs.next()) {
				ClinicType u = new ClinicType();
				u.setClinicTypeID(rs.getLong(1));
				u.setName(rs.getString(2));
				ct.add(u);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return ct;
	}

}
