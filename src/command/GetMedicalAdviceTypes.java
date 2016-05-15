package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.MedicalAdviceType;

public class GetMedicalAdviceTypes implements DatabaseCommand {
	
	public GetMedicalAdviceTypes(){}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {

		ArrayList<MedicalAdviceType> types = new ArrayList<MedicalAdviceType>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetMedicalAdviceTypes");
			rs = ps.executeQuery();

			while(rs.next()) {
				MedicalAdviceType t = new MedicalAdviceType();
				t.setMedicalAdviceTypeID(rs.getInt(1));
				t.setName(rs.getString(2));
				types.add(t);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return types;
	}

}
