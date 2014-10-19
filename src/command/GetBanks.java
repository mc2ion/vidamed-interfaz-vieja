package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.Bank;

public class GetBanks implements DatabaseCommand {
	
	public GetBanks(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<Bank> p = new ArrayList<Bank>();
		PreparedStatement ps = null; 
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetBanks");
			rs = ps.executeQuery();

			while (rs.next()) {
				Bank a = new Bank();
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
