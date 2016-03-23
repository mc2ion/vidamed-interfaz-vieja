package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AddCashBoxPayment implements DatabaseCommand {
	
	private Long typeid;
	private Long methodid;
	private String amount;
	private Long cashboxid;
	private Long userid;
	private Long admissionid;
	private Long bankid;
	private String number;
	private Long paymentresponsibleid;
	private Long salepointid;
	private Long banktoid;
	
	
	
	public AddCashBoxPayment(Long typeid, Long methodid, String amount, Long cashboxid, Long userid, Long admissionid,
							Long bankid, String number, Long paymentresponsibleid, Long  salepointid, Long banktoid){
		this.typeid 			= typeid;
		this.methodid 			= methodid;
		this.amount 			= "'" + amount + "'";
		this.cashboxid 			= cashboxid;
		this.userid 			= userid;
		this.admissionid 		= admissionid;
		if (bankid != 0) this.bankid = bankid; else this.bankid = null;
		if (!number.equals("")) this.number = number; else number=null;
		if (paymentresponsibleid != 0) this.paymentresponsibleid = paymentresponsibleid; else this.paymentresponsibleid = null;
		if (salepointid != 0) this.salepointid = salepointid; else this.salepointid = null;
		if (banktoid != 0) this.banktoid = banktoid; else this.banktoid = null;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.AddCashBoxPayment " + typeid + ", " + methodid + ", " + amount + ", " +
										cashboxid + "," + userid + "," + admissionid + "," + bankid + "," + number + "," +
										paymentresponsibleid + "," + salepointid + "," + banktoid);
			
			System.out.println("exec dbo.AddCashBoxPayment " + typeid + ", " + methodid + ", " + amount + ", " +
					cashboxid + "," + userid + "," + admissionid + "," + bankid + "," + number + "," +
					paymentresponsibleid + "," + salepointid + "," + banktoid);
			ps.execute();
		}
		catch(Exception e){
			System.out.println(e.getMessage());
			return 0;
		}
		finally {
			ps.close();
		}		
		
		return 1;
	}

}
