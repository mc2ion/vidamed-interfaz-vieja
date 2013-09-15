package domain;

public class EmergencyService {
	
	private long emergencyId;
	private long serviceId;
	
	public void setEmergencyId(long emergencyId) {
		this.emergencyId = emergencyId;
	}
	
	public long getEmergencyId() {
		return emergencyId;
	}

	public void setServiceId(long serviceId) {
		this.serviceId = serviceId;
	}

	public long getServiceId() {
		return serviceId;
	}
}
