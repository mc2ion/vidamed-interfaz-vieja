package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.DischargeType;

public class GetDischargeTypes implements DatabaseCommand {
	
	public GetDischargeTypes(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<DischargeType> bussinessList = new ArrayList<DischargeType>();;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetDischargeTypes");
			rs = ps.executeQuery();

			while (rs.next()) {
				DischargeType b = new DischargeType();
				b.setId(rs.getLong(1));
				b.setName(rs.getString(2));
				bussinessList.add(b);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return bussinessList;
	}

}
