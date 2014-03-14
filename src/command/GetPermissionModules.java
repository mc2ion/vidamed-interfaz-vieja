package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.PermissionModule;

public class GetPermissionModules implements DatabaseCommand {
	
	public GetPermissionModules(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<PermissionModule> modules = new ArrayList<PermissionModule>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetPermissionModules");
			rs = ps.executeQuery();

			while(rs.next()) {
				PermissionModule m = new PermissionModule();
				m.setPermissionModuleID(rs.getLong(1));
				m.setName(rs.getString(2));
				modules.add(m);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return modules;
	}

}
