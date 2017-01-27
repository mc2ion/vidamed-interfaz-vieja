package domain;

public class Sale {

	private Long billID;
	private Long correlativeNumber;
	private String firstName;
	private String lastName;
	private String identityCard;
	private String total;
	private String dischargeDate;
	
	public void setBillID(Long billID) {
		this.billID = billID;
	}
	
	public Long getBillID() {
		return billID;
	}

	public void setCorrelativeNumber(Long correlativeNumber) {
		this.correlativeNumber = correlativeNumber;
	}

	public Long getCorrelativeNumber() {
		return correlativeNumber;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setIdentityCard(String identityCard) {
		this.identityCard = identityCard;
	}

	public String getIdentityCard() {
		return identityCard;
	}

	public void setTotal(String total) {
		this.total = total;
	}

	public String getTotal() {
		return total;
	}

	public void setDischargeDate(String dischargeDate) {
		this.dischargeDate = dischargeDate;
	}

	public String getDischargeDate() {
		return dischargeDate;
	}
	
}
