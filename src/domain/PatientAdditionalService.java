package domain;

public class PatientAdditionalService {

	private Long patientAdditionalServiceID;
	private Long admissionID;
	private Long additionalServiceID;
	private String additionalServiceName;
	private Long bussinessRuleMicroID;
	private String bussinessRuleMicroName;
	private Double amount;
	private String additionalServiceDate;
	
	public void setPatientAdditionalServiceID(Long patientAdditionalServiceID) {
		this.patientAdditionalServiceID = patientAdditionalServiceID;
	}
	public Long getPatientAdditionalServiceID() {
		return patientAdditionalServiceID;
	}
	public void setAdmissionID(Long admissionID) {
		this.admissionID = admissionID;
	}
	public Long getAdmissionID() {
		return admissionID;
	}
	public void setAdditionalServiceID(Long additionalServiceID) {
		this.additionalServiceID = additionalServiceID;
	}
	public Long getAdditionalServiceID() {
		return additionalServiceID;
	}
	public void setAdditionalServiceName(String additionalServiceName) {
		this.additionalServiceName = additionalServiceName;
	}
	public String getAdditionalServiceName() {
		return additionalServiceName;
	}
	public void setBussinessRuleMicroID(Long bussinessRuleMicroID) {
		this.bussinessRuleMicroID = bussinessRuleMicroID;
	}
	public Long getBussinessRuleMicroID() {
		return bussinessRuleMicroID;
	}
	public void setBussinessRuleMicroName(String bussinessRuleMicroName) {
		this.bussinessRuleMicroName = bussinessRuleMicroName;
	}
	public String getBussinessRuleMicroName() {
		return bussinessRuleMicroName;
	}
	public void setAmount(Double amount) {
		this.amount = amount;
	}
	public Double getAmount() {
		return amount;
	}
	public void setAdditionalServiceDate(String additionalServiceDate) {
		this.additionalServiceDate = additionalServiceDate;
	}
	public String getAdditionalServiceDate() {
		return additionalServiceDate;
	}
}
