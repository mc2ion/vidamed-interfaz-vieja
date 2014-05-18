package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.PaymentResponsible;

public class GetEstimationPaymentResponsibles implements DatabaseCommand {
	
	private Long id;
	
	public GetEstimationPaymentResponsibles(long id){
		this.id = id;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		

		ArrayList<PaymentResponsible> u = new ArrayList<PaymentResponsible>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetEstimationPaymentResponsibles " + id);
			rs = ps.executeQuery();

			while (rs.next()) {
				PaymentResponsible p = new PaymentResponsible();
				p.setEstimationId(rs.getLong(1));
				p.setId(rs.getLong(2));
				p.setName(rs.getString(3));
				p.setHasGuaranteeLetter(rs.getInt(4));
				p.setIsPolicyHolder(rs.getInt(5));
				p.setPolicyHolderIdentityCard(rs.getString(6));
				p.setPolicyHolderName(rs.getString(7));
				p.setTotal(rs.getDouble(8));;
				u.add(p);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return u;
	}

}
