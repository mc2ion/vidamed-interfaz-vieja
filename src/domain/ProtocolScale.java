package domain;

public class ProtocolScale {
	
	private Long protocolScaleID;
	private String name;
	private Long bussinessRuleMicroID;
	private Long isMandatory;
	private Long generatedCostTypeID;
	private String generatedCostTypeName;
	private String cost;
	private String total;
	private Long isSelected;
	private String bussinessRuleMicroName;
	
	
	public Long getProtocolScaleID() {
		return protocolScaleID;
	}
	
	public void setProtocolScaleID(Long protocolScaleID) {
		this.protocolScaleID = protocolScaleID;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public Long getBussinessRuleMicroID() {
		return bussinessRuleMicroID;
	}
	
	public void setBussinessRuleMicroID(Long bussinessRuleMicroID) {
		this.bussinessRuleMicroID = bussinessRuleMicroID;
	}
	
	public Long getIsMandatory() {
		return isMandatory;
	}
	
	public void setIsMandatory(Long isMandatory) {
		this.isMandatory = isMandatory;
	}
	
	public Long getGeneratedCostTypeID() {
		return generatedCostTypeID;
	}
	
	public void setGeneratedCostTypeID(Long generatedCostTypeID) {
		this.generatedCostTypeID = generatedCostTypeID;
	}
	
	public String getGeneratedCostTypeName() {
		return generatedCostTypeName;
	}
	
	public void setGeneratedCostTypeName(String generatedCostTypeName) {
		this.generatedCostTypeName = generatedCostTypeName;
	}
	
	public String getCost() {
		return cost;
	}
	
	public void setCost(String str, Double cost) {
		if(str != null){
			this.cost = Estimation.format.format(cost);
		} else {			
			this.cost = null;
		}
	}
	
	public String getTotal() {
		return total;
	}
	
	public void setTotal(String str, Double total) {
		if(str != null){
			this.total = Estimation.format.format(total);
		} else {
			this.total = null;
		}
	}
	
	public Long getIsSelected() {
		return isSelected;
	}
	
	public void setIsSelected(Long isSelected) {
		this.isSelected = isSelected;
	}

	public void setBussinessRuleMicroName(String bussinessRuleMicroName) {
		this.bussinessRuleMicroName = bussinessRuleMicroName;
	}

	public String getBussinessRuleMicroName() {
		return bussinessRuleMicroName;
	}
	
	
}
