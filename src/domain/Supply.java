package domain;

public class Supply {
	
	private Long supplyID;
	private Long supplyAreaID;
	private String supplyAreaName;
	private String name;
	private Integer type;
	private String description;
	private String activeComponent;
	private String manufacturer;
	private Long supplyFormID;
	private String supplyFormName;
	private Long amount;
	private Double unitPrice;
	private Integer isRegulated;
	
	public Long getSupplyID() {
		return supplyID;
	}
	
	public void setSupplyID(Long supplyID) {
		this.supplyID = supplyID;
	}
	
	public Long getSupplyAreaID() {
		return supplyAreaID;
	}
	
	public void setSupplyAreaID(Long supplyAreaID) {
		this.supplyAreaID = supplyAreaID;
	}
	
	
	public String getSupplyAreaName() {
		return supplyAreaName;
	}
	
	public void setSupplyAreaName(String supplyAreaName) {
		this.supplyAreaName = supplyAreaName;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public Integer getType() {
		return type;
	}
	
	public void setType(Integer type) {
		this.type = type;
	}
	
	public String getDescription() {
		return description;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getActiveComponent() {
		return activeComponent;
	}

	public void setActiveComponent(String activeComponent) {
		this.activeComponent = activeComponent;
	}

	public String getManufacturer() {
		return manufacturer;
	}

	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}

	public Long getSupplyFormID() {
		return supplyFormID;
	}

	public void setSupplyFormID(Long supplyFormID) {
		this.supplyFormID = supplyFormID;
	}
	
	public String getSupplyFormName() {
		return supplyFormName;
	}

	public void setSupplyFormName(String supplyFormName) {
		this.supplyFormName = supplyFormName;
	}

	public Long getAmount() {
		return amount;
	}
	
	public void setAmount(Long amount) {
		this.amount = amount;
	}
	
	public Double getUnitPrice() {
		return unitPrice;
	}
	
	public void setUnitPrice(Double unitPrice) {
		this.unitPrice = unitPrice;
	}
	
	public Integer getIsRegulated() {
		return isRegulated;
	}
	
	public void setIsRegulated(Integer isRegulated) {
		this.isRegulated = isRegulated;
	}
	
}
