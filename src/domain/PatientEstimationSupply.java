package domain;

public class PatientEstimationSupply {
	
	private Long admissionID;
	private Long bussinessRuleMicroID;
	private String bussinessRuleMicroName;
	private Long protocolScaleID;
	private String protocolScaleName;
	private Long supplyID;
	private String supplyName;
	private Long amount;
	private Long inventory;
	private String status;	
	
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

	public Long getSupplyID() {
		return supplyID;
	}
	
	public void setSupplyID(Long supplyID) {
		this.supplyID = supplyID;
	}
	
	public String getSupplyName() {
		return supplyName;
	}
	
	public void setSupplyName(String supplyName) {
		this.supplyName = supplyName;
	}
	
	public Long getAmount() {
		return amount;
	}

	public void setAmount(Long amount) {
		this.amount = amount;
	}

	public void setInventory(Long inventory) {
		this.inventory = inventory;
	}

	public Long getInventory() {
		return inventory;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getStatus() {
		return status;
	}
}