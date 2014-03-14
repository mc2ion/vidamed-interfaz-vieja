package domain;

public class UserPhoneNumber {
	
	private Long phoneNumberID;
	private Long userID;
	private String phoneNumber;
	private String type;
	
	public Long getPhoneNumberID() {
		return phoneNumberID;
	}

	public void setPhoneNumberID(Long phoneNumberID) {
		this.phoneNumberID = phoneNumberID;
	}

	public void setUserID(Long userID) {
		this.userID = userID;
	}
	
	public Long getUserID() {
		return userID;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getType() {
		return type;
	}
	

}
