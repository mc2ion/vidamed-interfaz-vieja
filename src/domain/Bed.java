package domain;

public class Bed {
	
	private long id;
	private String name;
	private long locationId;
	private int isOccuped;
	
	/**
	 * 
	 * @param id
	 */
	public void setId(long id) {        
		this.id = id;
	}
	
	/**
	 * 
	 * @return
	 */
	public long getId() {
		return id;
	}
	
	/**
	 * 
	 * @param name
	 */
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * 
	 * @return
	 */
	public String getName() {
		return name;
	}

	/**
	 * 
	 * @param locationId
	 */
	public void setLocationId(long locationId) {
		this.locationId = locationId;
	}

	/**
	 * 
	 * @return
	 */
	public long getLocationId() {
		return locationId;
	}

	public void setOccuped(int isOccuped) {
		this.isOccuped = isOccuped;
	}

	public int isOccuped() {
		return isOccuped;
	}
}
