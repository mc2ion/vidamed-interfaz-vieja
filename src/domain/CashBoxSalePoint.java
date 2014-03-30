package domain;

public class CashBoxSalePoint {
	
	private Long salePointID;
	private Long cashBoxID;
	private String name;
	private Double commission;
	private Double islrPercentage;
	
	public Long getSalePointID() {
		return salePointID;
	}
	
	public void setSalePointID(Long salePointID) {
		this.salePointID = salePointID;
	}
	
	public Long getCashBoxID() {
		return cashBoxID;
	}
	
	public void setCashBoxID(Long cashBoxID) {
		this.cashBoxID = cashBoxID;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public Double getCommission() {
		return commission;
	}
	
	public void setCommission(Double commission) {
		this.commission = commission;
	}
	
	public Double getIslrPercentage() {
		return islrPercentage;
	}
	
	public void setIslrPercentage(Double islrPercentage) {
		this.islrPercentage = islrPercentage;
	}

}
