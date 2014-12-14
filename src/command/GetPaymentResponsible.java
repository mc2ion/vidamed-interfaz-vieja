package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.PaymentResponsible;
import domain.ResponsibleRule;

public class GetPaymentResponsible implements DatabaseCommand {
	
	private Long rId;
	
	public GetPaymentResponsible(Long rId){
		this.rId = rId;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PaymentResponsible resp = null;
		PreparedStatement ps = null; 
		ResultSet rs = null, rsAux = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetPaymentResponsible " + rId);
			rs = ps.executeQuery();

			if (rs.next()) {
				resp = new PaymentResponsible();
				resp.setId(rs.getLong(1));
				resp.setName(rs.getString(2));
				resp.setBussinessRuleId(rs.getLong(3));
				resp.setAddress(rs.getString(4));
				resp.setPhone(rs.getString(5));
				resp.setContactName(rs.getString(6));
				resp.setRif(rs.getString(7));
				
				//Get  responsible-rule
				PreparedStatement psAux = conn.prepareStatement("exec dbo.GetPaymentResponsibleRule " + rId);
				rsAux = psAux.executeQuery();

				ArrayList<ResponsibleRule> rrList = new ArrayList<ResponsibleRule>();
				while (rsAux.next()) {
					ResponsibleRule rr = new ResponsibleRule();
					rr.setPaymentResponsableId(rsAux.getLong(1));
					rr.setBussinesRuleMicroId(rsAux.getLong(2));
					rr.setBussinessModelId(rsAux.getLong(3));
					rr.setPercentage(rsAux.getDouble(4));
					rrList.add(rr);
				}
				resp.setResponsableRulesList(rrList);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return resp;
	}

}
