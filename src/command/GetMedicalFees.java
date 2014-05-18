package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import domain.MedicalFee;
import domain.Specialist;

public class GetMedicalFees implements DatabaseCommand {
	
	
	private String from = null;
	private String to 	= null; 
	private String firstname = null;
	private String lastname	 = null;
	private String amount    = null;

	public GetMedicalFees(){}

	public GetMedicalFees(String from, String to, String firstname, String lastname, String a) throws ParseException{
		if (from != null && from != ""){
			
			DateFormat fromFormat = new SimpleDateFormat("dd/MM/yyyy");
			fromFormat.setLenient(false);
			
			DateFormat toFormat = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
			toFormat.setLenient(false);
			
			Date date = fromFormat.parse(from);
			this.from 		= "'" + toFormat.format(date) + "'";
			
		}
			
		if (to != null && to != ""){
			DateFormat fromFormat = new SimpleDateFormat("dd/MM/yyyy");
			fromFormat.setLenient(false);
			
			DateFormat toFormat = new SimpleDateFormat("yyyy-MM-dd 23:59:59");
			toFormat.setLenient(false);
			
			Date date = fromFormat.parse(to);
			this.to   		= "'" + toFormat.format(date) + "'";
			System.out.println("tp " + to);
		}
			
		if (firstname != null && firstname != "")
			this.firstname  = "'" + firstname + "'";
		if (lastname != null && lastname != "")
			this.lastname  	= "'" + lastname + "'";
		if (a != null && a != "")
			this.amount	    = "'" + a + "'";
		
		
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<MedicalFee> mList = new ArrayList<MedicalFee>();
		try {
			ps = conn.prepareStatement("exec dbo.GetMedicalFees " + from + ", " + to + ", " +  firstname + ", " + lastname + "," + amount);
			rs = ps.executeQuery();

			while (rs.next()) {
				MedicalFee u = new MedicalFee();
				u.setMedicalFeeID(rs.getLong(1));
				
				
				DateFormat fromFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				fromFormat.setLenient(false);
				
				DateFormat toFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
				toFormat.setLenient(false);
				
				String dateStr = rs.getString(2);
				Date date;
				try {
					date = fromFormat.parse(dateStr);
					System.out.println(toFormat.format(date));
					u.setPaymentDate(toFormat.format(date));
				} catch (ParseException e1) {
					e1.printStackTrace();
				}
				
				Specialist e = new Specialist();
				e.setId(rs.getLong(3));
				e.setFirstName(rs.getString(4));
				e.setLastName(rs.getString(5));
				u.setSpecialist(e);
				
				u.setAmount(rs.getString(6));
				u.setIsPromptPayment(rs.getInt(7));
				u.setPromptAmount(rs.getString(8));
				mList.add(u);
			}
		}
		finally {
			/*rs.close();
			ps.close();*/
		}		
		
		return mList;
	}

}
