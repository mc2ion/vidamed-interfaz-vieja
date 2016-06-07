package domain;

public class ProtocolService {
	
	private Long   serviceID;
	private String serviceName;
	private String total;
	
	public void setServiceID(Long serviceID) {
		this.serviceID = serviceID;
	}

	public Long getServiceID() {
		return serviceID;
	}
	
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}

	public String getServiceName() {
		return serviceName;
	}
	
	public String getTotal() {
		return total;
	}
	
	public void setTotal(String total) {
		this.total = total;
	}		
}