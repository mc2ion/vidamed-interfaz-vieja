package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.UserPhoneNumber;

public class GetUserPhoneNumbers implements DatabaseCommand {
	
	private Long userID;
	
	public GetUserPhoneNumbers(Long userID){
		this.userID = userID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<UserPhoneNumber> upns = new ArrayList<UserPhoneNumber>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetUserPhoneNumbers " + userID);
			rs = ps.executeQuery();

			while (rs.next()) {
				UserPhoneNumber upn = new UserPhoneNumber();
				upn.setPhoneNumberID(rs.getLong(1));
				upn.setUserID(rs.getLong(2));
				upn.setType(rs.getString(3));
				upn.setPhoneNumber(rs.getString(4));
				upns.add(upn);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return upns;
	}

}
