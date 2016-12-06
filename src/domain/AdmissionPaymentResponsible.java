package domain;

public class AdmissionPaymentResponsible {
	private long admissionID;
	private long paymentResponsibleID;
	private String keyNumber;
	private String coverageAmount;
	private String guaranteeLetter;
	private String paymentResponsibleName;
	
	public void setAdmissionID(long admissionID) {
		this.admissionID = admissionID;
	}
	public long getAdmissionID() {
		return admissionID;
	}
	public void setPaymentResponsibleID(long paymentResponsibleID) {
		this.paymentResponsibleID = paymentResponsibleID;
	}
	public long getPaymentResponsibleID() {
		return paymentResponsibleID;
	}
	public void setKeyNumber(String keyNumber) {
		this.keyNumber = keyNumber;
	}
	public String getKeyNumber() {
		return keyNumber;
	}	
	public void setCoverageAmount(String str, Double coverageAmount) {
		if(str!=null){
			this.coverageAmount = Estimation.format.format(coverageAmount);
		} else {
			this.coverageAmount = null;
		}
	}
	public String getCoverageAmount() {
		return coverageAmount;
	}
	public void setGuaranteeLetter(String guaranteeLetter) {
		this.guaranteeLetter = guaranteeLetter;
	}
	public String getGuaranteeLetter() {
		return guaranteeLetter;
	}
	public void setPaymentResponsibleName(String paymentResponsibleName) {
		this.paymentResponsibleName = paymentResponsibleName;
	}
	public String getPaymentResponsibleName() {
		return paymentResponsibleName;
	}
}
