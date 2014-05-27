package domain;

public class PatientServiceReport {
	
	private Long servicePatientID;
	private Long admissionID;
	private Long estimationID;
	private Patient patient;
	private Long serviceTypeID;
	private String serviceTypeName;
	private Long serviceID;
	private String serviceName;
	private String servicePrice;
	private String associatedFile;
	private String price;
	private String serviceDate;
	
	public Long getAdmissionID() {
		return admissionID;
	}
	
	public void setAdmissionID(Long admissionID) {
		this.admissionID = admissionID;
	}
	
	public Long getServicePatientID() {
		return servicePatientID;
	}
	
	public void setServicePatientID(Long servicePatientID) {
		this.servicePatientID = servicePatientID;
	}
	
	public Long getServiceID() {
		return serviceID;
	}
	
	public void setServiceTypeID(Long serviceTypeID) {
		this.serviceTypeID = serviceTypeID;
	}
	
	public Long getServiceTypeID() {
		return serviceTypeID;
	}
	
	public void setServiceTypeName(String serviceTypeName) {
		this.serviceTypeName = serviceTypeName;
	}
	
	public String getServiceTypeName() {
		return serviceTypeName;
	}
	
	public void setPatient(Patient patient) {
		this.patient = patient;
	}
	
	public Patient getPatient() {
		return patient;
	}
	
	public void setEstimationID(Long estimationId) {
		this.estimationID = estimationId;
	}
	
	public Long getEstimationID() {
		return estimationID;
	}
	
	public void setServiceID(Long serviceID) {
		this.serviceID = serviceID;
	}
	
	public String getServiceName() {
		return serviceName;
	}
	
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}
	
	public String getServicePrice() {
		return servicePrice;
	}
	
	public void setServicePrice(String servicePrice) {
		this.servicePrice = servicePrice;
	}
	
	public String getAssociatedFile() {
		return associatedFile;
	}

	public void setAssociatedFile(String associatedFile) {
		this.associatedFile = associatedFile;
	}
	
	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}
	
	public String getServiceDate() {
		return serviceDate;
	}

	public void setServiceDate(String serviceDate) {
		this.serviceDate = serviceDate;
	}
	
	
}
