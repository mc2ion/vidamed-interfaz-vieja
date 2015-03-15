package domain;

public class SupplyProvider {

	private Long providerID;
	private String name;
	
	public void setProviderID(Long providerID) {
		this.providerID = providerID;
	}
	
	public Long getProviderID() {
		return providerID;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getName() {
		return name;
	}
}
