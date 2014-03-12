package domain;

public class SupplyArea {

	private Long supplyAreaID;
	private String name;
	private String description;
	
	public Long getSupplyAreaID() {
		return supplyAreaID;
	}

	public void setSupplyAreaID(Long supplyAreaID) {
		this.supplyAreaID = supplyAreaID;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDescription() {
		return description;
	}
}
