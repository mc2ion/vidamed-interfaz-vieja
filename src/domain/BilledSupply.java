package domain;

public class BilledSupply {
	
	private String generationDate;
	private Long creditNoteID;
	private String identityCard;
	private String patientName;
	private String supplyName;
	private Long supplyInventoryID;
	private String amount;
	private String unitPrice;
	private String price;
	private String supplyAreaName;
	private String supplyDate;
	private Long admissionID;

	public String getGenerationDate() {
		return generationDate;
	}

	public void setGenerationDate(String generationDate) {
		this.generationDate = generationDate;
	}

	public Long getCreditNoteID() {
		return creditNoteID;
	}

	public void setCreditNoteID(Long creditNoteID) {
		this.creditNoteID = creditNoteID;
	}

	public String getIdentityCard() {
		return identityCard;
	}

	public void setIdentityCard(String identityCard) {
		this.identityCard = identityCard;
	}

	public String getPatientName() {
		return patientName;
	}

	public void setPatientName(String patientName) {
		this.patientName = patientName;
	}

	public String getSupplyName() {
		return supplyName;
	}

	public void setSupplyName(String supplyName) {
		this.supplyName = supplyName;
	}

	public Long getSupplyInventoryID() {
		return supplyInventoryID;
	}

	public void setSupplyInventoryID(Long supplyInventoryID) {
		this.supplyInventoryID = supplyInventoryID;
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

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getSupplyAreaName() {
		return supplyAreaName;
	}

	public void setSupplyAreaName(String suppyAreaName) {
		this.supplyAreaName = suppyAreaName;
	}

	public String getSupplyDate() {
		return supplyDate;
	}

	public void setSupplyDate(String supplyDate) {
		this.supplyDate = supplyDate;
	}

	public Long getAdmissionID() {
		return admissionID;
	}

	public void setAdmissionID(Long admissionID) {
		this.admissionID = admissionID;
	}
}
