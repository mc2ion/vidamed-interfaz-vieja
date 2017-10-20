package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import domain.MedicalFee;
import domain.PendingBills;
import domain.Specialist;

public class GetMedicalFeeReceipt implements DatabaseCommand {
	
	private String receiptNumber;

	public GetMedicalFeeReceipt(String receiptNumber) {
		this.receiptNumber = receiptNumber;
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		ArrayList<MedicalFee> mfList =  new ArrayList<MedicalFee>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		DateFormat fromFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		fromFormat.setLenient(false);
		DateFormat toFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		toFormat.setLenient(false);
		
		try {
			ps = conn.prepareStatement("exec dbo.GetMedicalFeeReceipt '" + receiptNumber + "'");
			rs = ps.executeQuery();

			while (rs.next()) {
				MedicalFee mf = new MedicalFee();				
				String dateStr = rs.getString(1);
				Date date;
				
				try {
					if(dateStr != null){
						date = fromFormat.parse(dateStr);
						mf.setDischargeDate(toFormat.format(date));
					}
				} catch (ParseException e1) {
					e1.printStackTrace();
				}
				
				PendingBills b = new PendingBills();
				b.setCreditNoteID(rs.getLong(2));
				mf.setBill(b);
				
				Specialist s = new Specialist();
				s.setId(rs.getLong(3));
				s.setFirstName(rs.getString(4));
				s.setLastName(rs.getString(5));
				mf.setSpecialist(s);
				
				mf.setPatientName(rs.getString(6));
				mf.setPaymentResponsibleName(rs.getString(7));
				mf.setReasonName(rs.getString(8));
				mf.setAmount(rs.getString(9));
				mf.setFinalAmount(rs.getString(10));
				mf.setRetentionRate(rs.getString(11));
				mf.setRetentionAmount(rs.getString(12));

				mfList.add(mf);
			}
		}
		finally {
			rs.close();
			ps.close();
		}		
		
		return mfList;
	}

}
