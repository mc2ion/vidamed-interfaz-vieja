package domain;


public class PendingCreditNotes {
	
	private Long creditNoteID;
	private Long estimationID;
	private Patient patient;
	private Specialist specialist;
	private PaymentResponsible paymentResponsible;
	private String total;
	private Long admissionID;
	
	public Long getCreditNoteID() {
		return creditNoteID;
	}
	
	public void setCreditNoteID(Long creditNoteID) {
		this.creditNoteID = creditNoteID;
	}
	
	public Long getAdmissionID() {
		return admissionID;
	}
	
	public void setAdmissionID(Long admissionID) {
		this.admissionID = admissionID;
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
