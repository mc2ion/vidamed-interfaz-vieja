package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.User;

public class GetCashiers implements DatabaseCommand {
	
	public GetCashiers(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<User> users = new ArrayList<User>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetCashiers");
			rs = ps.executeQuery();

			while(rs.next()) {
				User u = new User();
				u.setUserID(rs.getLong(1));
				u.setIdentityCard(rs.getString(2));
				u.setFirstName(rs.getString(3));
				u.setLastName(rs.getString(4));
				u.setUserName(rs.getString(5));
				users.add(u);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return users;
	}

}
