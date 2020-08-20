package domain;

public class Service {

	private Long serviceID;
	private Long serviceTypeID;
	private String name;
	private String price;
	private String serviceTypeName;
	private Long amout;
	private String unitPrice;
	private String priceDollar;
	
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

	public void setServiceTypeName(String serviceTypeName) {
		this.serviceTypeName = serviceTypeName;
	}

	public String getServiceTypeName() {
		return serviceTypeName;
	}

	public void setAmout(Long amout) {
		this.amout = amout;
	}

	public Long getAmout() {
		return amout;
	}

	public void setUnitPrice(String unitPrice) {
		this.unitPrice = unitPrice;
	}

	public String getUnitPrice() {
		return unitPrice;
	}

	public String getPriceDollar() {
		return priceDollar;
	}

	public void setPriceDollar(String priceDollar) {
		this.priceDollar = priceDollar;
	}
	
}
