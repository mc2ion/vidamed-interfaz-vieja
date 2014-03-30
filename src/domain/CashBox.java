package domain;

public class CashBox {
	
	private Long cashBoxID;
	private String name;
	private String description;
	private Integer isOpen;
	private Double initialAmount;
	
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
	
	public String getDescription() {
		return description;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}
	
	public Integer getIsOpen() {
		return isOpen;
	}
	
	public void setIsOpen(Integer isOpen) {
		this.isOpen = isOpen;
	}
	
	public Double getInitialAmount() {
		return initialAmount;
	}
	
	public void setInitialAmount(Double initialAmount) {
		this.initialAmount = initialAmount;
	}
	
}
