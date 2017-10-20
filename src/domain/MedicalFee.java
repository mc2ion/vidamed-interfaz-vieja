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
	private String paymentResponsibleName;
	private String reasonName;
	private String finalAmount;
	private String retentionRate;
	private String retentionAmount;
	private String islr;
	private String total;
	
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

	public void setPaymentResponsibleName(String paymentResponsibleName) {
		this.paymentResponsibleName = paymentResponsibleName;
	}

	public String getPaymentResponsibleName() {
		return paymentResponsibleName;
	}

	public void setReasonName(String reasonName) {
		this.reasonName = reasonName;
	}

	public String getReasonName() {
		return reasonName;
	}

	public void setFinalAmount(String finalAmount) {
		this.finalAmount = finalAmount;
	}

	public String getFinalAmount() {
		return finalAmount;
	}

	public void setRetentionRate(String retentionRate) {
		this.retentionRate = retentionRate;
	}

	public String getRetentionRate() {
		return retentionRate;
	}

	public void setRetentionAmount(String retentionAmount) {
		this.retentionAmount = retentionAmount;
	}

	public String getRetentionAmount() {
		return retentionAmount;
	}

	public void setIslr(String islr) {
		this.islr = islr;
	}

	public String getIslr() {
		return islr;
	}

	public void setTotal(String total) {
		this.total = total;
	}

	public String getTotal() {
		return total;
	}
}
