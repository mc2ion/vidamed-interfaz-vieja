package domain;


public class PendingBills {
	
	private Long billID;
	private Long estimationID;
	private Patient patient;
	private Specialist specialist;
	private PaymentResponsible paymentResponsible;
	private String total;
	
	public Long getBillID() {
		return billID;
	}
	
	public void setBillID(Long billID) {
		this.billID = billID;
	}
	
	public Long getEstimationID() {
		return estimationID;
	}
	
	public void setEstimationID(Long estimationID) {
		this.estimationID = estimationID;
	}
	
	public Patient getPatient() {
		return patient;
	}
	
	public void setPatient(Patient patient) {
		this.patient = patient;
	}
	
	public Specialist getSpecialist() {
		return specialist;
	}
	
	public void setSpecialist(Specialist specialist) {
		this.specialist = specialist;
	}
	
	public PaymentResponsible getPaymentResposible() {
		return paymentResponsible;
	}
	
	public void setPaymentResposible(PaymentResponsible paymentResponsible) {
		this.paymentResponsible = paymentResponsible;
	}

	public String getTotal() {
		return total;
	}
	
	public void setTotal(String total) {
		this.total = total;
	}

}
