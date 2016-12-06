package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.AdmissionPaymentResponsible;

public class GetAdmissionPaymentResponsibles implements DatabaseCommand {
	
	Long admissionId;
	
	public GetAdmissionPaymentResponsibles(Long admissionId){
		this.admissionId = admissionId;
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		
		ArrayList<AdmissionPaymentResponsible> responsibles = new ArrayList<AdmissionPaymentResponsible>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetAdmissionPaymentResponsibles " + admissionId);
			rs = ps.executeQuery();

			while (rs.next()) {
				AdmissionPaymentResponsible u = new AdmissionPaymentResponsible();
				u.setAdmissionID(rs.getLong(1));
				u.setPaymentResponsibleID(rs.getLong(2));
				u.setKeyNumber(rs.getString(3));
				u.setCoverageAmount(rs.getString(4), rs.getDouble(4));
				u.setGuaranteeLetter(rs.getString(5));
				u.setPaymentResponsibleName(rs.getString(6));
				responsibles.add(u);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return responsibles;
	}

}
