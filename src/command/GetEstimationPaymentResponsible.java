package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import domain.PaymentResponsible;

public class GetEstimationPaymentResponsible implements DatabaseCommand {
	
	private Long estimationId;
	private Long paymentResponsibleId;
	
	
	public GetEstimationPaymentResponsible(Long estimationId, Long paymentId){
		this.estimationId 		  = estimationId;
		this.paymentResponsibleId = paymentId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		

		PaymentResponsible p = new PaymentResponsible();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetEstimationPaymentResponsible " + estimationId + "," + paymentResponsibleId);
			rs = ps.executeQuery();

			while (rs.next()) {
				p.setEstimationId(rs.getLong(1));
				p.setId(rs.getLong(2));
				p.setName(rs.getString(3));
				p.setHasGuaranteeLetter(rs.getInt(4));
				p.setIsPolicyHolder(rs.getInt(5));
				p.setPolicyHolderIdentityCard(rs.getString(6));
				p.setPolicyHolderName(rs.getString(7));
				p.setTotal(rs.getDouble(8));;
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return p;
	}

}
