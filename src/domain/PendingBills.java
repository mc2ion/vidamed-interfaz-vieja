package domain;


public class PendingBills {
	
	private Long billID;
	private Long estimationID;
	private Long admissionID;
	private Patient patient;
	private Specialist specialist;
	private PaymentResponsible paymentResponsible;
	private String total;
	private int wasGenerated;
	private String generationDate;
	private int wasPaid;
	private String paymentDate;
	private String totalWithDiscout;
	private String totalPaid;
	private int hasMultiplePaymentResponsibles;
	private Long creditNoteID;
	private int wasDelivered;
	private String deliveryDate;
	
	
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
	
	public Long getAdmissionID() {
		return admissionID;
	}
	
	public void setAdmissionID(Long admissionID) {
		this.admissionID = admissionID;
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
	
	public int getWasPaid() {
		return wasPaid;
	}
	
	public void setWasPaid(int wasPaid) {
		this.wasPaid = wasPaid;
	}
	
	public int getWasGenerated() {
		return wasGenerated;
	}
	
	public void setWasGenerated(int wasGenerated) {
		this.wasGenerated = wasGenerated;
	}
	
	public String getGenerationDate() {
		return generationDate;
	}
	
	public void setGenerationDate(String generationDate) {
		this.generationDate = generationDate;
	}
	
	public String getPaymentDate() {
		return paymentDate;
	}
	
	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}
	
	public void setTotalWithDiscount(String totalWithDiscout) {
		this.totalWithDiscout = totalWithDiscout;
		
	}
	public String getTotalWithDiscount() {
		return totalWithDiscout;
	}

	public void setTotalPaid(String totalPaid) {
		this.totalPaid = totalPaid;
		
	}
	public String getTotalPaid() {
		return totalPaid;
	}

	public void setHasMultiplePaymentResponsibles(
			int hasMultiplePaymentResponsibles) {
		this.hasMultiplePaymentResponsibles = hasMultiplePaymentResponsibles;
	}

	public int getHasMultiplePaymentResponsibles() {
		return hasMultiplePaymentResponsibles;
	}

	public void setCreditNoteID(Long creditNoteID) {
		this.creditNoteID = creditNoteID;
	}

	public Long getCreditNoteID() {
		return creditNoteID;
	}

	public void setWasDelivered(int wasDelivered) {
		this.wasDelivered = wasDelivered;
	}

	public int getWasDelivered() {
		return wasDelivered;
	}

	public void setDeliveryDate(String deliveryDate) {
		this.deliveryDate = deliveryDate;
	}

	public String getDeliveryDate() {
		return deliveryDate;
	}

}
