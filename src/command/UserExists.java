package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import domain.User;

public class UserExists implements DatabaseCommand {
	
	private String name;
	private String encryptPassword;
	
	public UserExists(String name, String encryptPassword){
		this.name = name;
		this.encryptPassword = encryptPassword;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		User u = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetUserAuthentication '" + name + "' , '" + encryptPassword + "'");
			rs = ps.executeQuery();

			if (rs.next()) {
				u = new User();
				u.setUserID(rs.getLong(1));
				u.setUserName(rs.getString(2));
				u.setPassword(rs.getString(3));
				u.setFirstName(rs.getString(4));
				u.setLastName(rs.getString(5));
			}
		}
		finally {
			if (rs != null) rs.close();
			if (rs != null) ps.close();
		}		
		
		return u;
	}
}
