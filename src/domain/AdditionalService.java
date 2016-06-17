package domain;

public class AdditionalService {

	private Long additionalServiceID;
	private String additionalServiceName;
	private Long bussinessRuleMicroID;
	private String bussinessRuleMicroName;
	
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
}
