package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import domain.CashBox;
import domain.User;

public class GetCashBox implements DatabaseCommand {
	
	private Long cashBoxID;
	
	public GetCashBox(Long cashBoxID){
		this.cashBoxID = cashBoxID;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		CashBox cb = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		DateFormat fromFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		fromFormat.setLenient(false);
		DateFormat toFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		toFormat.setLenient(false);
		
		try {
			ps = conn.prepareStatement("exec dbo.GetCashBox " + cashBoxID);
			rs = ps.executeQuery();

			if (rs.next()) {
				cb = new CashBox();
				cb.setCashBoxID(rs.getLong(1));
				cb.setName(rs.getString(2));
				cb.setDescription(rs.getString(3));
				cb.setIsOpen(rs.getInt(4));
				
				String dateStr = rs.getString(5);
				Date date;
				try {
					if (dateStr != null){
						date = fromFormat.parse(dateStr);
						cb.setOpeningDate(toFormat.format(date));
					}
				} catch (ParseException e1) {
					e1.printStackTrace();
				}
				User u = new User();
				u.setUserID(rs.getLong(6));
				u.setFirstName(rs.getString(7));
				u.setLastName(rs.getString(8));
				cb.setUser(u);
				
				cb.setInitialAmount(rs.getDouble(9));
				cb.setChargedAmount(rs.getDouble(10));
				cb.setPaidAmount(rs.getDouble(11));
				cb.setTotalAmount(rs.getDouble(12));
				
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return cb;
	}

}
