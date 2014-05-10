package domain;


public class PendingPromptPayment {
	
	private Long medicalFeeId;
	private Long billId;
	private int billWasPaid;
	private String billDate;
	private Specialist specialist;
	private String amount;
	private String discountedAmount;
	private String totalAmount;
	
	
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
	
	
	public String getBillDate(){
		return billDate;
	}
	
	public void setBillDate(String billDate){
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
	
	public void setDiscountedAmount(String discountedAmount){
		this.discountedAmount = discountedAmount;
	}
	
	public String getDiscountedAmount(){
		return discountedAmount;
	}
	
	public void setTotalAmount(String totalAmount){
		this.totalAmount = totalAmount;
	}
	
	public String getTotalAmount(){
		return totalAmount;
	}
	
	
	
}
