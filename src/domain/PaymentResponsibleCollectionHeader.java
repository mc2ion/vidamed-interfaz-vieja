package domain;

public class PaymentResponsibleCollectionHeader {

	private String bank;
	private String documentNumber;
	private String paymentDate;
	private String paymentResponsibleName;
	private String coverageAmount;
	private String retention;
	private String dif;
	
	public void setBank(String bank) {
		this.bank = bank;
	}
	
	public String getBank() {
		return bank;
	}

	public void setDocumentNumber(String documentNumber) {
		this.documentNumber = documentNumber;
	}

	public String getDocumentNumber() {
		return documentNumber;
	}

	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}

	public String getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentResponsibleName(String paymentResponsibleName) {
		this.paymentResponsibleName = paymentResponsibleName;
	}

	public String getPaymentResponsibleName() {
		return paymentResponsibleName;
	}

	public void setCoverageAmount(String coverageAmount) {
		this.coverageAmount = coverageAmount;
	}

	public String getCoverageAmount() {
		return coverageAmount;
	}

	public void setRetention(String retention) {
		this.retention = retention;
	}

	public String getRetention() {
		return retention;
	}

	public void setDif(String dif) {
		this.dif = dif;
	}

	public String getDif() {
		return dif;
	}
}
