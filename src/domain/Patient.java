package domain;

public class Patient {
	
	private Long patientID;
	private int isAdult;
	private String firstName;
	private String lastName;
	private String identityCard;
	private String gender;
	private long numEstimation;
	private long estimationPaymentResponsibleId;
	private String estimationResponsibleName;
	private String address;
	private String email;
	private String birthday;
	
	public Long getPatientID() {
		return patientID;
	}
	
	public void setPatientID(Long patientID) {
		this.patientID = patientID;
	}
	
	public String getIdentityCard() {
		return identityCard;
	}
	
	public void setIdentityCard(String identityCard) {
		this.identityCard = identityCard;
	}
	
	public String getFirstName() {
		return firstName;
	}
	
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	
	public String getLastName() {
		return lastName;
	}
	
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	
	
	public int getIsAdult() {
		return isAdult;
	}
	
	public void setIsAdult(int isAdult) {
		this.isAdult = isAdult;
	}
	
	public Long getEstimationID() {
		return numEstimation;
	}
	
	public void setEstimationID(Long numEstimation) {
		this.numEstimation = numEstimation;
	}
	
	public void setPaymentResponsibleId(long paymentResponsibleId) {
		this.estimationPaymentResponsibleId = paymentResponsibleId;
	}
	
	public long getPaymentResponsibleId() {
		return estimationPaymentResponsibleId;
	}
	
	public void setResponsibleName(String responsibleName) {
		this.estimationResponsibleName = responsibleName;
	}

	public String getResponsibleName() {
		return estimationResponsibleName;
	}
	
	public String getGender() {
		return gender;
	}
	
	public void setGender(String gender) {
		this.gender = gender;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAddress() {
		return address;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getEmail() {
		return email;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getBirthday() {
		return birthday;
	}
	
}
