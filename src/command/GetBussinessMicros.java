package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.BussinessMicro;

public class GetBussinessMicros implements DatabaseCommand {
	
	public GetBussinessMicros(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<BussinessMicro> bussinessList = new ArrayList<BussinessMicro>();;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetBussinessRuleMicros");
			rs = ps.executeQuery();

			while (rs.next()) {
				BussinessMicro b = new BussinessMicro();
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
