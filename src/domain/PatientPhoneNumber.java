package domain;

public class PatientPhoneNumber {

	private Long phoneNumberID;
	private Long patientID;
	private String phoneNumber;
	private String type;
	
	public Long getPhoneNumberID() {
		return phoneNumberID;
	}

	public void setPhoneNumberID(Long phoneNumberID) {
		this.phoneNumberID = phoneNumberID;
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

	public void setPatientID(Long patientID) {
		this.patientID = patientID;
	}

	public Long getPatientID() {
		return patientID;
	}
	
}
