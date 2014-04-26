package domain;

public class PatientSupply {
	
	private Long admissionID;
	private Long patientSupplyID;
	private Long supplyID;
	private String supplyName;
	private String supplyForm;
	private String amount;
	private String unitPrice;
	private String total;
	
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
}
