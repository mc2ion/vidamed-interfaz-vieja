package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import domain.User;

public class GetUser implements DatabaseCommand {
	
	private Long userID;
	
	public GetUser(Long userID){
		this.userID = userID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		User u = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetUser " + userID);
			rs = ps.executeQuery();

			if (rs.next()) {
				u = new User();
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
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return u;
	}

}
