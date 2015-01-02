package domain;

public class Protocol {

	private Long protocolID;
	private String name;
	private String description;
	private String type;
	private String gender;
	private String orHours;
	private String roomDays;
	private String anesthesiaID;
	private String diag;
	private String total;
	private String totalP;
	private String bussinessRuleMicroName;
	private String cost;
	private String estCost;
	
	public Long getProtocolID() {
		return protocolID;
	}

	public void setProtocolID(Long protocolID) {
		this.protocolID = protocolID;
	}

	public void setBussinessRuleMicroName(String bussinessRuleMicroName) {
		this.bussinessRuleMicroName = bussinessRuleMicroName;
	}

	public String getBussinessRuleMicroName() {
		return bussinessRuleMicroName;
	}
	
	public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}
	
	public void setCost(String cost) {
		this.cost = cost;
	}

	public String getCost() {
		return cost;
	}
	
	public void setEstimationCost(String estCost) {
		this.estCost = estCost;
	}

	public String getEstimationCost() {
		return estCost;
	}
	
	
	

	public void setType(String type) {
		this.type = type;
	}

	public String getType() {
		return type;
	}
	
	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getGender() {
		return gender;
	}
	
	public void setOrHours(String orHours) {
		this.orHours = orHours;
	}

	public String getOrHours() {
		return orHours;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}

	public String getDescription() {
		return description;
	}
	
	public void setRoomDays(String roomDays) {
		this.roomDays = roomDays;
	}

	public String getRoomDays() {
		return roomDays;
	}
	
	public void setAnesthesiaID(String anesthesiaID) {
		this.anesthesiaID = anesthesiaID;
	}

	public String getAnesthesiaID() {
		return anesthesiaID;
	}
	
	public void setDiagnosis(String diag) {
		this.diag = diag;
	}

	public String getDiagnosis() {
		if (diag != null) return diag;
		else return "";
	}
	
	public void setTotal(String total) {
		this.total = total;
	}

	public String getTotal() {
		return total;
	}

	public void setTotalWithPercentage(String totalP) {
		this.totalP = totalP;
	}
	
	public String getTotalWithPercentage() {
		return totalP;
	}
}
