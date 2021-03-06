package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.PaymentResponsible;

public class GetPaymentResponsibles implements DatabaseCommand {
	
	public GetPaymentResponsibles(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<PaymentResponsible> resposibles = new ArrayList<PaymentResponsible>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetPaymentResponsibles");
			rs = ps.executeQuery();

			while(rs.next()) {
				PaymentResponsible resp = new PaymentResponsible();
				Long id = rs.getLong(1);
				resp.setId(id);
				resp.setName(rs.getString(2));
				resp.setBussinessRuleId(rs.getLong(3));
				resp.setRuleName(rs.getString(4));
				resp.setAddress(rs.getString(5));
				resp.setPhone(rs.getString(6));
				resp.setBussinessModelId(rs.getLong(7));
				resp.setBussinessModelName(rs.getString(8));
				
				resposibles.add(resp);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return resposibles;
	}

}
