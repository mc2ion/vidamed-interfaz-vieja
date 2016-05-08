package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import domain.Admission;
import domain.Estimation;
import domain.Specialist;

public class GetAdmission implements DatabaseCommand {
	
	private Long id;
	
	public GetAdmission(long id){
		this.id = id;
	}
	
	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		

		Admission u = new Admission();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		DateFormat fromFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		fromFormat.setLenient(false);
		DateFormat toFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		toFormat.setLenient(false);
	
		
		try {
			ps = conn.prepareStatement("exec dbo.GetAdmission " + id);
			rs = ps.executeQuery();

			if (rs.next()) {
				u.setAdmissionID(rs.getLong(1));
				u.setEstimationID(rs.getLong(2));
				u.setPatientID(rs.getLong(3));
				u.setIdentityCard(rs.getString(4));
				u.setFirstName(rs.getString(5));
				u.setLastName(rs.getString(6));
				u.setIsAdult(rs.getInt(7));
				u.setResponsibleID(rs.getLong(8));
				u.setResponsibleName(rs.getString(9));
				u.setObservation(rs.getString(10));
				u.setStatusID(rs.getLong(11));
				u.setStatusName(rs.getString(12));
				u.setReasonID(rs.getLong(13));
				u.setReasonName(rs.getString(14));
				
				String dateStr = rs.getString(15);
				Date date;
				try {
					if (dateStr != null){
						date = fromFormat.parse(dateStr);
						u.setAdmissionDate(toFormat.format(date));
					}
				} catch (ParseException e1) {
					e1.printStackTrace();
				}
				
				Specialist e = new Specialist();
				e.setId(rs.getLong(16));
				e.setFirstName(rs.getString(17));
				e.setLastName(rs.getString(18));
				e.setUnit(rs.getLong(19));
				e.setUnitName(rs.getString(20));
				u.setSpecialist(e);
				u.setTotal(rs.getString(21), rs.getDouble(21));
				u.setTotalPaid(rs.getString(22), rs.getDouble(22));
				
				Estimation est = new Estimation();
				est.setTotal(rs.getString(23), rs.getDouble(23));
				est.setTotalWithDiscount(rs.getString(24), rs.getDouble(24));
				est.setPolicyHolderIdentityCard(rs.getString(27));
				est.setPolicyHolderName(rs.getString(28));
				u.setEstimation(est);
				u.setTotalWithDiscount(rs.getString(25), rs.getDouble(25));
				
				dateStr = rs.getString(26);
				try {
					if (dateStr != null){
						date = fromFormat.parse(dateStr);
						u.setDischargeDate(toFormat.format(date));
					}
				} catch (ParseException e1) {
					e1.printStackTrace();
				}
				
				u.setResponsibleAddress(rs.getString(29));
				u.setResponsibleRIF(rs.getString(30));
				u.setKeyNumber(rs.getString(31));
				u.setCoverageAmount(rs.getDouble(32));
				u.setGuaranteeLetter(rs.getString(33));
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return u;
	}

}
