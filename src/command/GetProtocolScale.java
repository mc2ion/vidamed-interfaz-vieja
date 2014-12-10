package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import domain.ProtocolScale;

public class GetProtocolScale implements DatabaseCommand {
	
	public String id;
	
	public GetProtocolScale(String id){
		this.id = id;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<ProtocolScale> p = new ArrayList<ProtocolScale>();
		
		try {
			ps = conn.prepareStatement("exec dbo.GetProtocolScale " + id);
			
			rs = ps.executeQuery();

			while (rs.next()) {
				ProtocolScale u = new ProtocolScale();
				u.setProtocolScaleID(rs.getLong(1));
				u.setName(rs.getString(2));
				u.setBussinessRuleMicroID(rs.getLong(3));
				u.setIsMandatory(rs.getLong(4));
				u.setGeneratedCostTypeID(rs.getLong(5));
				u.setGeneratedCostTypeName(rs.getString(6));
				u.setCost(rs.getString(7));
				u.setTotal(rs.getString(8));
				u.setIsSelected(rs.getLong(9));
				p.add(u);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		return p;
	}

}
