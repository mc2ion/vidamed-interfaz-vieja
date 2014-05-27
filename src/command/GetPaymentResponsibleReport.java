package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;

import domain.PaymentResponsible;

public class GetPaymentResponsibleReport implements DatabaseCommand {
	
	private String name 				= null;
	private String bussinessRuleId      = null;
		
	public GetPaymentResponsibleReport(){}
	
	public GetPaymentResponsibleReport(String name, String bussinessRuleId) throws ParseException{
		if (name != null && name != "")
			this.name = "'" + name + "'";
		if (bussinessRuleId != null && bussinessRuleId != "")
			this.bussinessRuleId	    = bussinessRuleId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<PaymentResponsible> p = new ArrayList<PaymentResponsible>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetPaymentResponsibleReport " + name + ","  + bussinessRuleId );
			rs = ps.executeQuery();
		
			while (rs.next()) {
				PaymentResponsible u = new PaymentResponsible();
				u.setId(rs.getLong(1));
				u.setName(rs.getString(2));
				u.setBussinessRuleId(rs.getLong(3));
				u.setRuleName(rs.getString(4));
				u.setAddress(rs.getString(5));
				u.setPhone(rs.getString(6));
				u.setContactName(rs.getString(7));
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
