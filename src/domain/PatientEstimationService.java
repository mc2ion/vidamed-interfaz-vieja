package domain;

public class PatientEstimationService {
	
	private Long admissionID;
	private Long bussinessRuleMicroID;
	private String bussinessRuleMicroName;
	private Long protocolScaleID;
	private String protocolScaleName;
	private Long serviceID;
	private String serviceName;
	private Long amount;	
	
	public Long getAdmissionID() {
		return admissionID;
	}
	
	public void setAdmissionID(Long admissionID) {
		this.admissionID = admissionID;
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

	public void setProtocolScaleID(Long protocolScaleID) {
		this.protocolScaleID = protocolScaleID;
	}

	public Long getProtocolScaleID() {
		return protocolScaleID;
	}

	public void setProtocolScaleName(String protocolScaleName) {
		this.protocolScaleName = protocolScaleName;
	}

	public String getProtocolScaleName() {
		return protocolScaleName;
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
	
	public Long getAmount() {
		return amount;
	}

	public void setAmount(Long amount) {
		this.amount = amount;
	}
}