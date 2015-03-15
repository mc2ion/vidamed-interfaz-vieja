package domain;

public class PatientService {
	
	private Long admissionID;
	private Long servicePatientID;
	private Long serviceID;
	private String serviceName;
	private String servicePrice;
	private String associatedFile;
	private String associatedReport;
	
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
	
	public String getAssociatedFile() {
		return associatedFile;
	}

	public void setAssociatedFile(String associatedFile) {
		this.associatedFile = associatedFile;
	}

	public void setAssociatedReport(String associatedReport) {
		this.associatedReport = associatedReport;
	}

	public String getAssociatedReport() {
		return associatedReport;
	}
}
