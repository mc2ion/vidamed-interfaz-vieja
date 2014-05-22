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

import domain.PaymentResponsible;
import domain.PendingAccounts;

public class GetPendingAccounts implements DatabaseCommand {
	
	public GetPendingAccounts(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<PendingAccounts> pList = new ArrayList<PendingAccounts>();;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetPendingAccounts");
			rs = ps.executeQuery();

			while (rs.next()) {
				PendingAccounts u = new PendingAccounts();
				u.setBillID(rs.getLong(1));
				u.setEstimationID(rs.getLong(2));
				
				PaymentResponsible p = new PaymentResponsible();
				p.setId(rs.getLong(3));
				p.setName(rs.getString(4));
				u.setPaymentResposible(p);
				
				u.setTotal(rs.getString(5));
				
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
				
				pList.add(u);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return pList;
	}

}
