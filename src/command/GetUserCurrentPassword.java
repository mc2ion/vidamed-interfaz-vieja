package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import domain.User;

public class GetUserCurrentPassword implements DatabaseCommand {
	
	private Long userID;
	
	public GetUserCurrentPassword(Long userID){
		this.userID = userID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		User u = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetUserCurrentPassword " + userID);
			rs = ps.executeQuery();

			if (rs.next()) {
				u = new User();
				u.setUserID(rs.getLong(1));
				u.setPassword(rs.getString(2));
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return u;
	}

}
