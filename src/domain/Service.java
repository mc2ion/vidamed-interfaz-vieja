package domain;

public class Service {

	private Long serviceID;
	private Long serviceTypeID;
	private String name;
	private String price;
	
	public Long getServiceID() {
		return serviceID;
	}

	public void setServiceID(Long serviceID) {
		this.serviceID = serviceID;
	}

	public Long getServiceTypeID() {
		return serviceTypeID;
	}

	public void setServiceTypeID(Long serviceTypeID) {
		this.serviceTypeID = serviceTypeID;
	}
	
	public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}
	
	public void setPrice(String price) {
		this.price = price;
	}

	public String getPrice() {
		return price;
	}
	
}
