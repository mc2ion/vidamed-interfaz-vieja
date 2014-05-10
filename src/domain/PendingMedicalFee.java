package domain;


public class PendingMedicalFee {
	
	private Long medicalFeeId;
	private Long billId;
	private int billWasPaid;
	private Specialist specialist;
	private String amount;
	
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
	
	public Long GetBillID() {
		return billId;
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
	
}
