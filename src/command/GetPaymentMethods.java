package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.PaymentMethod;

public class GetPaymentMethods implements DatabaseCommand {
	
	public GetPaymentMethods(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<PaymentMethod> p = new ArrayList<PaymentMethod>();
		PreparedStatement ps = null; 
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetPaymentMethods");
			rs = ps.executeQuery();

			while (rs.next()) {
				PaymentMethod a = new PaymentMethod();
				a.setId(rs.getLong(1));
				a.setName(rs.getString(2));
				p.add(a);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return p;
	}

}
