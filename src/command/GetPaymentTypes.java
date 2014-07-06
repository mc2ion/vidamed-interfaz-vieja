package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import domain.PaymentTypes;

public class GetPaymentTypes implements DatabaseCommand {
	
	public GetPaymentTypes(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<PaymentTypes> p = new ArrayList<PaymentTypes>();
		PreparedStatement ps = null; 
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetPaymentTypes");
			rs = ps.executeQuery();

			while (rs.next()) {
				PaymentTypes a = new PaymentTypes();
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
