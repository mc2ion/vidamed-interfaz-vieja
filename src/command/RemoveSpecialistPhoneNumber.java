package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RemoveSpecialistPhoneNumber implements DatabaseCommand {
	
	private Long phoneNumberID;
	
	public RemoveSpecialistPhoneNumber(Long phoneNumberID){
		this.phoneNumberID = phoneNumberID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.RemoveSpecialistPhoneNumber " + phoneNumberID);
			ps.execute();
		}
		catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
