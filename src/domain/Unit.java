package domain;

public class Unit {

	private Long unitID;
	private String name;
	private String description;
	
	public void setUnitID(Long unitID) {
		this.unitID = unitID;
	}
	
	public Long getUnitID() {
		return unitID;
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
