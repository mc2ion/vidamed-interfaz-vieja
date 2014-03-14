package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.Permission;

public class GetPermissions implements DatabaseCommand {
	
	private Long permissionModuleID;
	
	public GetPermissions(Long permissionModuleID){
		this.permissionModuleID = permissionModuleID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<Permission> permissions = new ArrayList<Permission>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetPermissions " + permissionModuleID);
			rs = ps.executeQuery();

			while (rs.next()) {
				Permission p = new Permission();
				p.setPermissionID(rs.getLong(1));
				p.setPermissionModuleID(rs.getLong(2));
				p.setName(rs.getString(3));
				permissions.add(p);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return permissions;
	}

}
