package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;

import domain.UserReport;

public class GetUserReport implements DatabaseCommand {
	
	private String from 			= null;
	private String to 				= null; 
	private String username 		= null;
	private String identityCard     = null;
	private String gender    		= null;
	private String unitId	 		= null;
	

	
	public GetUserReport(){}
	
	public GetUserReport(String from, String to, String username, String identityCard, String gender, String unitId) throws ParseException{
		if (from != null && from != ""){
			this.from 		= "'" + from + "'";
		}
			
		if (to != null && to != ""){
			this.to   		= "'" + to + "'";
		}
			
		if (username != null && username != "")
			this.username  = "'" + username + "'";
		if (identityCard != null && identityCard != "")
			this.identityCard  	= "'" + identityCard + "'";
		if (gender != null && gender != "")
			this.gender	    = "'" + gender + "'";
		if (unitId != null && unitId != "")
			this.unitId	    = unitId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<UserReport> p = new ArrayList<UserReport>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			System.out.println("b " + identityCard + ","  + gender + "," + unitId + "," + from + "," + to + "," + username);
			
			ps = conn.prepareStatement("exec dbo.GetUserReport " + identityCard + ","  + gender + "," + unitId + "," + from + "," + to + "," + username );
			rs = ps.executeQuery();
			
			System.out.println("c");
			

			while (rs.next()) {
				UserReport u = new UserReport();
				u.setUserID(rs.getLong(1));
				u.setIdentityCard(rs.getString(2));
				u.setFirstName(rs.getString(3));
				u.setLastName(rs.getString(4));
				u.setBirthday(rs.getString(5));
				u.setGender(rs.getString(6));
				u.setAddress(rs.getString(7));
				u.setEmail(rs.getString(8));
				u.setUserUnitID(rs.getLong(9));
				u.setUnitName(rs.getString(10));
				u.setStartDate(rs.getString(11));
				u.setPosition(rs.getString(12));
				u.setSalary(rs.getDouble(13));
				u.setUserName(rs.getString(14));
				p.add(u);
			}
		}catch(Exception e){
			e.getStackTrace();
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return p;
	}

}
