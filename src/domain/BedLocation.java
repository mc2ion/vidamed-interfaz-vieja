package domain;

public class BedLocation {

	private long id;
	private String name;
	private long typeId;
	
	public void setId(long id) {
		this.id = id;
	}
	
	public long getId() {
		return id;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setTypeId(long typeId) {
		this.typeId = typeId;
	}

	public long getTypeId() {
		return typeId;
	}
}
