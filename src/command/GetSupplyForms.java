package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.SupplyForm;

public class GetSupplyForms implements DatabaseCommand {
	
	public GetSupplyForms(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<SupplyForm> supplyForms = new ArrayList<SupplyForm>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetSupplyForms");
			rs = ps.executeQuery();

			while(rs.next()) {
				SupplyForm sf = new SupplyForm();
				sf.setSupplyFormID(rs.getLong(1));
				sf.setName(rs.getString(2));
				supplyForms.add(sf);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return supplyForms;
	}

}
