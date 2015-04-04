package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import domain.PaymentResponsible;
import domain.PendingAccounts;

public class GetPendingAccount implements DatabaseCommand {
	
	
	private Long id;
	
	public GetPendingAccount(Long id){
		this.id = id;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		//PendingAccounts pAccount = new PendingAccounts();
		PendingAccounts u = new PendingAccounts();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetPendingAccount " + id);
			rs = ps.executeQuery();

			while (rs.next()) {
				u.setBillID(rs.getLong(1));
				u.setEstimationID(rs.getLong(2));
				
				PaymentResponsible p = new PaymentResponsible();
				p.setId(rs.getLong(3));
				p.setName(rs.getString(4));
				u.setPaymentResposible(p);
				
				u.setTotal(rs.getString(5), rs.getDouble(5));
				
				DateFormat fromFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				fromFormat.setLenient(false);
				
				DateFormat toFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
				toFormat.setLenient(false);
				
				String dateStr = rs.getString(6);
				Date date;
				try {
					date = fromFormat.parse(dateStr);
					u.setGenerationDate(toFormat.format(date));
				} catch (ParseException e1) {
					e1.printStackTrace();
				}
				u.setTotalWithDiscount(rs.getString(7), rs.getDouble(7));
				u.setTotalPaid(rs.getString(8), rs.getDouble(8));
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return u;
	}

}
