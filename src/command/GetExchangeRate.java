package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import domain.ExchangeRate;

public class GetExchangeRate implements DatabaseCommand {
	
	public GetExchangeRate(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		ExchangeRate e = new ExchangeRate();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		DateFormat fromFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		fromFormat.setLenient(false);
		DateFormat toFormat = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss a");
		toFormat.setLenient(false);
	
		
		try {
			ps = conn.prepareStatement("exec dbo.GetExchangeRate");
			rs = ps.executeQuery();

			if (rs.next()) {
				e.setExchangeRateID(rs.getLong(1));
				e.setValue(rs.getString(2), rs.getDouble(2));
				
				String dateStr = rs.getString(3);
				Date date;
				try {
					if (dateStr != null){
						date = fromFormat.parse(dateStr);
						e.setCreatedDate(toFormat.format(date));
					}
				} catch (ParseException e1) {
					e1.printStackTrace();
				}
				
				e.setCreateUserID(rs.getLong(4));
				e.setCreatedUserName(rs.getString(5));
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return e;
	}

}
