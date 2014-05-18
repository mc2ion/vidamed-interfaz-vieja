package domain;


public class MedicalFee {
	
	private Long medicalFeeId;
	private String paymentDate;
	private Specialist specialist;
	private String amount;
	private int isPromptPayment;
	private String promptAmount;
	
	public Long getMedicalFeeID() {
		return medicalFeeId;
	}
	
	public void setMedicalFeeID(Long medicalFeeId) {
		this.medicalFeeId = medicalFeeId;
	}
	
	public String getPaymentDate() {
		return paymentDate;
	}
	
	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
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
	
	public void setIsPromptPayment(int isPromptPayment){
		this.isPromptPayment = isPromptPayment;
	}
	
	public int getIsPromptPayment(){
		return isPromptPayment;
	}
	
	public void setPromptAmount(String promptAmount){
		this.promptAmount = promptAmount;
	}
	
	public String getPromptAmount(){
		return promptAmount;
	}
}
