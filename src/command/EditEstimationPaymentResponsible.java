package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditEstimationPaymentResponsible implements DatabaseCommand {
	
	private Long estimationId;
	private Long paymentRId;
	private int hasGuaranteeL  = 0;
	private int isPolicyHolder = 0;
	private String policyCed;
	private String policyName;
	
	public EditEstimationPaymentResponsible(Long estimationId, Long paymentRId, String hasGuaranteeL, String isPolicyHolder,
						String policyCed,String policyName){
		this.estimationId = estimationId;
		this.paymentRId = paymentRId;
		if (hasGuaranteeL != null)
			this.hasGuaranteeL = Integer.valueOf(hasGuaranteeL);
		if (isPolicyHolder != null)
			this.isPolicyHolder = Integer.valueOf(isPolicyHolder);
		this.policyCed = policyCed;
		this.policyName = policyName;
		
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.EditEstimationPaymentResponsible " + hasGuaranteeL + ", "+ isPolicyHolder + ",'" + policyCed + "', '" 
									+ policyName + "'," + estimationId + ", " + paymentRId);
			ps.execute();
		}
		catch(Exception e){
			return 0;
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
