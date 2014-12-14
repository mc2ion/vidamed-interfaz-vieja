package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EditPaymentResponsible implements DatabaseCommand {
	
	private Long id;
	private String name;
	private Long selBusinessRule;
	private Long selBusinessModel;
	private double txtPrice;
	private String type = "General";
	private String contactName;
	private String rif;
	private String phoneNumber;
	private String address;
	
	public EditPaymentResponsible(Long id, String name, Long selBusinessRule, Long selBusinessModel, double txtPrice, String contactName, String rif, String address, String phoneNumber){
		this.id = id;
		this.name = name;
		this.selBusinessRule = selBusinessRule;
		this.selBusinessModel = selBusinessModel;
		this.txtPrice = txtPrice;
		this.type = "General";
		this.contactName = contactName;
		this.rif = rif;
		this.phoneNumber = phoneNumber;
		this.address = address;
	}
	
	public EditPaymentResponsible(Long id, String name, Long selBusinessRule, String contactName, String rif, String address, String phoneNumber){
		this.id = id;
		this.name = name;
		this.selBusinessRule = selBusinessRule;
		this.type = "name";
		this.contactName = contactName;
		this.rif = rif;
		this.phoneNumber = phoneNumber;
		this.address = address;
	}
	
	public EditPaymentResponsible(Long id, Long selBusinessRule, Long selBusinessModel, double txtPrice){
		this.id = id;
		this.selBusinessModel = selBusinessModel;
		this.selBusinessRule = selBusinessRule;
		this.txtPrice = txtPrice;
		this.type = "micros";
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		try {
			if (type.equals("General")){
				ps = conn.prepareStatement("exec dbo.EditPaymentResponsibleWithGeneralRules '" + name + "', '" + selBusinessRule + "', '" +
							address + "', '" + phoneNumber + "', '" + contactName + "', '" + rif + "', '" + id + "', '" + selBusinessModel +
							"', '" + txtPrice + "'");
				ps.execute();
			}else{
				if (type.equals("name")){
					ps = conn.prepareStatement("exec dbo.EditPaymentResponsible '" + name + "', '" + selBusinessRule + "', '" + address + "', '" +
							phoneNumber + "', '" + contactName + "', '" + rif + "', '" + id + "'");
					ps.execute();
					
				}else{
					ps = conn.prepareStatement("exec dbo.EditPaymentResponsibleRule '" + selBusinessModel + "', '" + txtPrice + "', '"+ id + "', '" + selBusinessRule + "'");
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
		return 1;
		
	}

}
