package domain;

public class Protocol {

	private Long protocolID;
	private Long protocolScaleID;
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
	private Long bussinessRuleMicroId;
	private String cost;
	private String estCost;
	private String protocolScaleName;
	private Long generatedCostTypeID;
	private String unitID;
	private String tempCost;
	private String tempTotalP;
	private String tempEstCost;
	
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
	
	public void setBussinessRuleMicroID(long bussinessRuleMicroId) {
		this.bussinessRuleMicroId = bussinessRuleMicroId;
	}

	public Long getBussinessRuleMicroID() {
		return bussinessRuleMicroId;
	}
	
	public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}
	
	public void setCost(String str, Double cost) {
		if(str!=null){
			this.cost = Estimation.format.format(cost);
			this.tempCost = Estimation.format.format(cost/1000);
		} else {
			this.cost = null;
			this.tempCost = null;
		}
	}

	public String getCost() {
		return cost;
	}
	
	public String getTempCost() {
		return tempCost;
	}
	
	public void setEstimationCost(String str, Double estCost) {
		if(str!=null){
			this.estCost = Estimation.format.format(estCost);
			this.tempEstCost = Estimation.format.format(estCost/1000);
		} else {
			this.estCost = null;
			this.tempEstCost = null;
		}
	}

	public String getEstimationCost() {
		return estCost;
	}

	public String getTempEstimationCost() {
		return tempEstCost;
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
	
	public void setTotal(String str, Double total) {
		if(str!=null){			
			this.total = Estimation.format.format(total);
		} else {
			this.total = null;
		}
	}

	public String getTotal() {
		return total;
	}

	public void setTotalWithPercentage(String str, Double totalP) {
		if(str!=null){	
			this.totalP = Estimation.format.format(totalP);
			this.tempTotalP = Estimation.format.format(totalP/1000);
		} else {
			this.totalP = null;
			this.tempTotalP = null;
		}
	}
	
	public String getTotalWithPercentage() {
		return totalP;
	}
	
	public String getTempTotalWithPercentage() {
		return tempTotalP;
	}
	
	public void setProtocolScaleID(long protocolScaleID) {
		this.protocolScaleID = protocolScaleID;
	}
	
	public Long getProtocolScaleID() {
		return protocolScaleID;
	}

	public void setProtocolScaleName(String protocolScaleName) {
		this.protocolScaleName = protocolScaleName;
	}
	
	public String getProtocolScaleName() {
		return protocolScaleName;
	}

	public void setGeneratedCostTypeID(Long generatedCostTypeID) {
		this.generatedCostTypeID = generatedCostTypeID;
	}
	
	public Long getGeneratedCostTypeID() {
		return generatedCostTypeID;
	}

	public void setUnitID(String unitID) {
		this.unitID = unitID;
	}

	public String getUnitID() {
		return unitID;
	}
}
