package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.UserPermission;

public class GetUserPermissions implements DatabaseCommand {
	
	private Long userID;
	
	public GetUserPermissions(Long userID){
		this.userID = userID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<UserPermission> ups = new ArrayList<UserPermission>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetUserPermissions " + userID);
			rs = ps.executeQuery();

			while (rs.next()) {
				UserPermission up = new UserPermission();
				up.setUserID(rs.getLong(1));
				up.setPermissionID(rs.getLong(2));
				ups.add(up);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return ups;
	}

}
