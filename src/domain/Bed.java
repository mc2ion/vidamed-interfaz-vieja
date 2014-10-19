package domain;

public class Bed {
	
	private long id;
	private String name;
	private long locationId;
	private int isOccuped;
	private String locationName;
	
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

	public void setLocationId(long locationId) {
		this.locationId = locationId;
	}

	public long getLocationId() {
		return locationId;
	}

	public void setOccuped(int isOccuped) {
		this.isOccuped = isOccuped;
	}

	public int isOccuped() {
		return isOccuped;
	}
	
	public void setLocationName(String locationName) {
		this.locationName = locationName;
	}
	
	public String getLocationName() {
		return locationName;
	}
}
