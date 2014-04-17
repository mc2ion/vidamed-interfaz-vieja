package domain;

public class PatientSupply {
	
	private Long admissionID;
	private Long servicePatientID;
	private Long serviceID;
	private String serviceName;
	private String servicePrice;
	private String associatedFile;
	
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
	
	public String getActiveComponent() {
		return associatedFile;
	}

	public void setAssociatedFile(String associatedFile) {
		this.associatedFile = associatedFile;
	}
}
