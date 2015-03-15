package domain;


public class PendingMedicalFee {
	
	private Long medicalFeeId;
	private Long billId;
	private int billWasPaid;
	private String billDate;
	private Specialist specialist;
	private String amount;
	private int feeWasPaid;
	private String paymentDate;
	private String billPaymentDate;
	
	public Long getMedicalFeeID() {
		return medicalFeeId;
	}
	
	public void setMedicalFeeID(Long medicalFeeId) {
		this.medicalFeeId = medicalFeeId;
	}
	
	public Long getBillID() {
		return billId;
	}
	
	public void setBillID(Long billId) {
		this.billId = billId;
	}
	
	public String getBillDate() {
		return billDate;
	}
	
	public void setBillDate(String billDate) {
		this.billDate = billDate;
	}
	
	public void setBillWasPaid(int billWasPaid) {
		this.billWasPaid = billWasPaid;
	}
	
	public int getBillWasPaid() {
		return billWasPaid;
	}
	
	public void setSpecialist(Specialist specialist) {
		this.specialist = specialist;
	}
	
	public Specialist getSpecialist() {
		return specialist;
	}
	
	public void setAmount(String amount){
		this.amount = amount;
	}
	
	public String getAmount(){
		return amount;
	}
	
	public void setFeeWasPaid(int feeWasPaid) {
		this.feeWasPaid = feeWasPaid;
	}
	
	public int getFeeWasPaid() {
		return feeWasPaid;
	}
	
	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}
	
	public String getPaymentDate() {
		return paymentDate;
	}

	public void setBillPaymentDate(String billPaymentDate) {
		this.billPaymentDate = billPaymentDate;
	}

	public String getBillPaymentDate() {
		return billPaymentDate;
	}
}
