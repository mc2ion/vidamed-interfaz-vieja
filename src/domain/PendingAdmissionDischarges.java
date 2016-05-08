package domain;


public class PendingAdmissionDischarges {
	
	private Long admissionID;
	private Long estimationID;
	private Patient patient;
	private Specialist specialist;
	private String admissionDate;
	private String dischargeDate;
	private Long paymentResponsibleID;
	
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
			
	public String getAdmissionDate() {
		return admissionDate;
	}
	
	public void setAdmissionDate(String admissionDate) {
		this.admissionDate = admissionDate;
	}
	
	public String getDischargeDate() {
		return dischargeDate;
	}
	
	public void setDischargeDate(String dischargeDate) {
		this.dischargeDate = dischargeDate;
	}

	public void setPaymentResponsibleID(Long paymentResponsibleID) {
		this.paymentResponsibleID = paymentResponsibleID;
	}

	public Long getPaymentResponsibleID() {
		return paymentResponsibleID;
	}

}
