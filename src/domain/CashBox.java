package domain;

public class CashBox {
	
	private Long cashBoxID;
	private String name;
	private String description;
	private Integer isOpen;
	private Long userID;
	private Double initialAmount;
	private Double chargedAmount;
	private Double paidAmount;
	private Double totalAmount;
	
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
	
	public Long getUserID() {
		return userID;
	}

	public void setUserID(Long userID) {
		this.userID = userID;
	}

	public Double getInitialAmount() {
		return initialAmount;
	}
	
	public void setInitialAmount(Double initialAmount) {
		this.initialAmount = initialAmount;
	}

	public Double getChargedAmount() {
		return chargedAmount;
	}

	public void setChargedAmount(Double chargedAmount) {
		this.chargedAmount = chargedAmount;
	}

	public Double getPaidAmount() {
		return paidAmount;
	}

	public void setPaidAmount(Double paidAmount) {
		this.paidAmount = paidAmount;
	}

	public Double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(Double totalAmount) {
		this.totalAmount = totalAmount;
	}

}
