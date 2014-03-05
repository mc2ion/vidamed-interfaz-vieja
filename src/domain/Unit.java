package domain;

public class Unit {

	private long unitID;
	private String name;
	private String description;
	
	public void setUnitID(long unitID) {
		this.unitID = unitID;
	}
	
	public long getUnitID() {
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
