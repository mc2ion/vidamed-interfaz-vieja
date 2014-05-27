package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;

import domain.Specialist;

public class GetSpecialistReport implements DatabaseCommand {
	
	private String firstname 		= null;
	private String lastname 		= null; 
	private String gender 			= null;
	private String identityCard     = null;
	private String rif	    		= null;
	private String unitId	 		= null;
	

	
	public GetSpecialistReport(){}
	
	public GetSpecialistReport(String firstname, String lastname, String gender, String identityCard, String rif, String unitId) throws ParseException{
		if (firstname != null && firstname != "")
			this.firstname 		= "'" + firstname + "'";
		if (lastname != null && lastname != "")
			this.lastname  		= "'" + lastname + "'";
		if (identityCard != null && identityCard != "")
			this.identityCard  	= "'" + identityCard + "'";
		if (gender != null && gender != "")
			this.gender	    = "'" + gender + "'";
		if (unitId != null && unitId != "")
			this.unitId	    = unitId;
		if (rif != null && rif != "")
			this.rif  = "'" + rif + "'";
		
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<Specialist> p = new ArrayList<Specialist>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetSpecialistReport " + unitId + "," + identityCard + ","  + firstname + "," + lastname + "," + gender + "," + rif );
			rs = ps.executeQuery();
		
			while (rs.next()) {
				Specialist spec = new Specialist();
				spec.setId(rs.getLong(1));
				spec.setIdentityCard(rs.getString(2));
				spec.setFirstName(rs.getString(3));
				spec.setLastName(rs.getString(4));
				spec.setBirthdate(rs.getString(5));
				spec.setSex(rs.getString(6));
				spec.setRif(rs.getString(7));
				spec.setAddress(rs.getString(8));
				spec.setEmail(rs.getString(9));
				p.add(spec);
			}
		}catch(Exception e){
			e.getStackTrace();
		}
		finally {
			/*rs.close();
			ps.close();*/
		}		
		
		return p;
	}

}
