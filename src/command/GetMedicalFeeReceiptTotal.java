package command;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import domain.MedicalFee;
import domain.Specialist;

public class GetMedicalFeeReceiptTotal implements DatabaseCommand {

	private String receiptNumber;

	public GetMedicalFeeReceiptTotal(String receiptNumber) {
		this.receiptNumber = receiptNumber;
	}

	@Override
	public Object executeDatabaseOperation(Connection conn) throws SQLException {
		ArrayList<MedicalFee> mfList =  new ArrayList<MedicalFee>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("exec dbo.GetMedicalFeeReceiptTotal '" + receiptNumber + "'");
			rs = ps.executeQuery();

			while (rs.next()) {
				MedicalFee mf = new MedicalFee();
				
				Specialist s = new Specialist();
				s.setId(rs.getLong(1));
				s.setIdentityCard(rs.getString(2));
				mf.setSpecialist(s);
				
				mf.setAmount(rs.getString(3));
				mf.setFinalAmount(rs.getString(4));
				mf.setRetentionAmount(rs.getString(5));
				mf.setIslr(rs.getString(6));
				mf.setTotal(rs.getString(7));

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
