package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import domain.PendingMedicalFee;
import domain.Specialist;

public class GetPendingMedicalFee implements DatabaseCommand {
	
	private Long id;
	
	public GetPendingMedicalFee(Long id){
		this.id = id;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		PendingMedicalFee u = new PendingMedicalFee();
			
		try {
			ps = conn.prepareStatement("exec dbo.GetMedicalFee " + id);
			rs = ps.executeQuery();

			if (rs.next()) {
				u.setMedicalFeeID(rs.getLong(1));
				u.setBillID(rs.getLong(2));
				u.setBillWasPaid(rs.getInt(3));
				
				DateFormat fromFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				fromFormat.setLenient(false);
				DateFormat toFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
				toFormat.setLenient(false);
			
				String dateStr = rs.getString(4);
				Date date;
				try {
					if (dateStr != null){
						date = fromFormat.parse(dateStr);
						u.setBillDate(toFormat.format(date));
					}
				} catch (ParseException e1) {
					e1.printStackTrace();
				}
				
				
				
				Specialist e = new Specialist();
				e.setId(rs.getLong(5));
				e.setFirstName(rs.getString(6));
				e.setLastName(rs.getString(7));
				u.setSpecialist(e);
				
				u.setAmount(rs.getString(8));
				u.setFeeWasPaid(rs.getInt(9));
				
				dateStr = rs.getString(10);
				try {
					if (dateStr != null){
						date = fromFormat.parse(dateStr);
						u.setPaymentDate(toFormat.format(date));
					}
				} catch (ParseException e1) {
					e1.printStackTrace();
				}
				
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return u;
	}

}
