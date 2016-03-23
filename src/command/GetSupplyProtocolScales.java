package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.ProtocolScale;

public class GetSupplyProtocolScales implements DatabaseCommand {
	
	public GetSupplyProtocolScales(){}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<ProtocolScale> protocolScales = new ArrayList<ProtocolScale>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetSupplyProtocolScales");
			rs = ps.executeQuery();

			while(rs.next()) {
				ProtocolScale s = new ProtocolScale();
				s.setBussinessRuleMicroID(rs.getLong(1));
				s.setBussinessRuleMicroName(rs.getString(2));
				s.setProtocolScaleID(rs.getLong(3));
				s.setName(rs.getString(4));
				protocolScales.add(s);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return protocolScales;
	}

}

