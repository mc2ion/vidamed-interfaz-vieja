package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.User;

public class GetUsers implements DatabaseCommand {
	
	public GetUsers(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<User> users = new ArrayList<User>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetUsers");
			rs = ps.executeQuery();

			while(rs.next()) {
				User u = new User();
				u.setUserID(rs.getLong(1));
				u.setIdentityCard(rs.getString(2));
				u.setFirstName(rs.getString(3));
				u.setLastName(rs.getString(4));
				u.setBirthday(rs.getString(5));
				u.setGender(rs.getString(6));
				u.setAddress(rs.getString(7));
				u.setEmail(rs.getString(8));
				u.setUserUnitID(rs.getLong(9));
				u.setStartDate(rs.getString(10));
				u.setPosition(rs.getString(11));
				u.setSalary(rs.getDouble(12));
				u.setUserName(rs.getString(13));
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
