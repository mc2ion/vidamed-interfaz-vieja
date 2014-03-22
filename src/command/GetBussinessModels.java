package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.BussinessModels;

public class GetBussinessModels implements DatabaseCommand {
	
	public GetBussinessModels(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<BussinessModels> bussinessList = new ArrayList<BussinessModels>();;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetBussinessModels");
			rs = ps.executeQuery();

			while (rs.next()) {
				BussinessModels b = new BussinessModels();
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
