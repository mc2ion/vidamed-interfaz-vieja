package domain;

public class AdmissionReasons {
	
	private long id;
	private String name;
	
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
}
