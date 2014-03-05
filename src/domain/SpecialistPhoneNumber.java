package domain;

public class SpecialistPhoneNumber {
	
	private Long phoneNumberID;
	private Long specialistID;
	private String phoneNumber;
	private String type;
	
	public Long getPhoneNumberID() {
		return phoneNumberID;
	}

	public void setPhoneNumberID(Long phoneNumberID) {
		this.phoneNumberID = phoneNumberID;
	}

	public void setSpecialistID(Long specialistID) {
		this.specialistID = specialistID;
	}
	
	public Long getSpecialistID() {
		return specialistID;
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
