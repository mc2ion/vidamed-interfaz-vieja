package domain;

public class PatientSupply {
	
	private Long admissionID;
	private Long patientSupplyID;
	private Long estimationID;
	private Patient patient;
	private Long supplyID;
	private Supply supply;
	private String supplyName;
	private String supplyForm;
	private String amount;
	private String unitPrice;
	private String total;
	private String supplyDate;
	private SupplyInventory supplyInventory;
	private Long protocolScaleID;
	private String protocolScaleName;
	private Long bussinessRuleMicroID;	
	private String bussinessRuleMicroName;
	private String totalDollar;
	
	public Long getAdmissionID() {
		return admissionID;
	}
	
	public void setAdmissionID(Long admissionID) {
		this.admissionID = admissionID;
	}
	
	public Long getPatientSupplyID() {
		return patientSupplyID;
	}
	
	public void setPatientSupplyID(Long patientSupplyID) {
		this.patientSupplyID = patientSupplyID;
	}
	
	public Long getSupplyID() {
		return supplyID;
	}
	
	public void setSupplyID(Long supplyID) {
		this.supplyID = supplyID;
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
	
	public Supply getSupply() {
		return supply;
	}
	
	public void setSupply(Supply supply) {
		this.supply = supply;
	}
	
	public String getSupplyName() {
		return supplyName;
	}
	
	public void setSupplyName(String supplyName) {
		this.supplyName = supplyName;
	}
	
	public String getSupplyForm() {
		return supplyForm;
	}
	
	public void setSupplyForm(String supplyForm) {
		this.supplyForm = supplyForm;
	}
	
	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}
	
	public String getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(String unitPrice) {
		this.unitPrice = unitPrice;
	}
	
	public String getTotal() {
		return total;
	}

	public void setTotal(String total) {
		this.total = total;
	}
	
	public String getSupplyDate() {
		return supplyDate;
	}

	public void setSupplyDate(String supplyDate) {
		this.supplyDate = supplyDate;
	}

	public void setSupplyInventory(SupplyInventory supplyInventory) {
		this.supplyInventory = supplyInventory;
	}

	public SupplyInventory getSupplyInventory() {
		return supplyInventory;
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

	public String getTotalDollar() {
		return totalDollar;
	}

	public void setTotalDollar(String totalDollar) {
		this.totalDollar = totalDollar;
	}
}
