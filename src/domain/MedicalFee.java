package domain;


public class MedicalFee {
	
	private Long medicalFeeId;
	private String paymentDate;
	private Specialist specialist;
	private String amount;
	private int isPromptPayment;
	private String promptAmount;
	private PendingBills bill;
	private int wasPaid;
	private String patientName;
	private String dischargeDate;
	
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
	
	public void setBill(PendingBills bill){
		this.bill = bill;
	}
	
	public PendingBills getBill(){
		return bill;
	}
	
	public int getWasPaid() {
		return wasPaid;
	}
	
	public void setWasPaid(int wasPaid) {
		this.wasPaid = wasPaid;
	}

	public void setPatientName(String patientName) {
		this.patientName = patientName;
	}

	public String getPatientName() {
		return patientName;
	}

	public void setDischargeDate(String dischargeDate) {
		this.dischargeDate = dischargeDate;
	}

	public String getDischargeDate() {
		return dischargeDate;
	}
	
	
}
