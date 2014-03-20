package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import domain.ResponsibleRule;

public class CreatePaymentResponsible implements DatabaseCommand {
	
	private String name;
	private Long selBusinessRule;
	private Long selBusinessModel;
	private double txtPrice;
	private String type = "General";
	private ArrayList<ResponsibleRule> rrList = new ArrayList<ResponsibleRule>();
	
	public CreatePaymentResponsible(String name, Long selBusinessRule, Long selBusinessModel, double txtPrice){
		this.name = name;
		this.selBusinessRule = selBusinessRule;
		this.selBusinessModel = selBusinessModel;
		this.txtPrice = txtPrice;
		this.type = "General";
	}
	
	public CreatePaymentResponsible(String name, Long selBusinessRule, ArrayList<ResponsibleRule> rrList){
		this.name = name;
		this.selBusinessRule = selBusinessRule;
		this.rrList = rrList;
		this.type = "name";
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		Long id = (long) 0;
		Long paymentId = null;
		try {
			if (type.equals("General")){
				ps = conn.prepareStatement("exec dbo.AddPaymentResponsibleWithGeneralRules '" + name + "', '" + selBusinessRule + "', '" +
							+ selBusinessModel + "', '" + txtPrice + "', '" + id + "'");
				rs = ps.executeQuery();
				if (rs.next()) {
					paymentId = rs.getLong(1);
				}
			}else{
				ps = conn.prepareStatement("exec dbo.AddPaymentResponsible  '" + name + "', '" + selBusinessRule + "'");
				rs = ps.executeQuery();
				if (rs.next()) {
					paymentId = rs.getLong(1);
				}
				/* Crear todos los micros asociados*/ 
				
				for (int i = 0; i < rrList.size(); i++){
					ResponsibleRule rule = rrList.get(i);
					ps = conn.prepareStatement("exec dbo.AddPaymentResponsibleRule '" + paymentId + "', '"+ rule.getBussinesRuleMicroId() +  "', '" + rule.getBussinessModelId() + "', '" + rule.getPercentage() + "'");
					ps.execute();
				}
				
			}
		}
		catch(Exception E){
			System.out.println("error " + E.getMessage());
			return 0;
		}
		finally {
			ps.close();
			
		}		
		return paymentId;
		
	}

}
