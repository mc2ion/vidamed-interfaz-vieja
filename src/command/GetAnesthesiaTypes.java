package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.AnesthesiaType;

public class GetAnesthesiaTypes implements DatabaseCommand {

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<AnesthesiaType> anestesiaTypeList = new ArrayList<AnesthesiaType>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("exec dbo.GetAnesthesiaTypes");
			rs = ps.executeQuery();

			while (rs.next()) {
				AnesthesiaType a = new AnesthesiaType();
				a.setAnesthesiaTypeId(rs.getLong(1));
				a.setName(rs.getString(2));
				anestesiaTypeList.add(a);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return anestesiaTypeList;
	}

}
