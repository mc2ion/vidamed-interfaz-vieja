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

public class GetPendingAccountsReport implements DatabaseCommand {
	
	private Long paymentResponsibleID;

	public GetPendingAccountsReport(Long paymentresponsibleid) {
		this.paymentResponsibleID = paymentresponsibleid;
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		ArrayList<PendingAccounts> pList = new ArrayList<PendingAccounts>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetPendingAccountsByPaymentResponsibleReport " + this.paymentResponsibleID);
			rs = ps.executeQuery();

			while (rs.next()) {
				PendingAccounts u = new PendingAccounts();
				u.setBillID(rs.getLong(1));
				u.setPatientName(rs.getString(2));
				u.setPatientIdentityCard(rs.getString(3));
				u.setPolicyHolderIdentityCard(rs.getString(4));
				u.setGuaranteeLetter(rs.getString(5));
				u.setTotalBill(rs.getString(6));
				
				PaymentResponsible p = new PaymentResponsible();
				p.setId(rs.getLong(7));
				p.setName(rs.getString(8));
				u.setPaymentResposible(p);
				
				u.setTotal(rs.getString(9), rs.getDouble(9));
				
				DateFormat fromFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				fromFormat.setLenient(false);
				
				DateFormat toFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
				toFormat.setLenient(false);
				
				String dateStr = rs.getString(10);
				Date date;
				try {
					date = fromFormat.parse(dateStr);
					u.setGenerationDate(toFormat.format(date));
				} catch (ParseException e1) {
					e1.printStackTrace();
				}
				
				dateStr = rs.getString(13);
				fromFormat = new SimpleDateFormat("yyyy-MM-dd");
				toFormat = new SimpleDateFormat("dd/MM/yyyy");
				
				if(dateStr !=  null){
					try {
						date = fromFormat.parse(dateStr);
						u.setDeliveryDate(toFormat.format(date));
					} catch (ParseException e2) {
						e2.printStackTrace();
					}
				}
				
				u.setHasMultiplePaymentResponsibles(rs.getInt(14));
				u.setMainPaymentResponsible(rs.getInt(15));
				u.setAdmissionID(rs.getLong(16));
				
				dateStr = rs.getString(17);
				fromFormat = new SimpleDateFormat("yyyy-MM-dd");
				toFormat = new SimpleDateFormat("dd/MM/yyyy");
				
				if(dateStr !=  null){
					try {
						date = fromFormat.parse(dateStr);
						u.setDischargeDate(toFormat.format(date));
					} catch (ParseException e2) {
						e2.printStackTrace();
					}
				}
				
				u.setTotalPaid(rs.getString(18), rs.getDouble(18));
				u.setTotalPending(rs.getString(19), rs.getDouble(19));
				
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
