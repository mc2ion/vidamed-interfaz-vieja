package domain;

public class Estimation {
	
	private long id;
	private long patientId;
	private String identityCard;
	private String firstName;
	private String lastName;
	private long paymentResponsibleId;
	private String responsibleName;
	
	public void setId(long id) {
		this.id = id;
	}
	
	public long getId() {
		return id;
	}

	public void setPatientId(long patientId) {
		this.patientId = patientId;
	}

	public long getPatientId() {
		return patientId;
	}

	
	public void setIdentityCard(String identityCard) {
		this.identityCard = identityCard;
	}

	public String getIdentityCard() {
		return identityCard;
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

	public void setPaymentResponsibleId(long paymentResponsibleId) {
		this.paymentResponsibleId = paymentResponsibleId;
	}
	
	public long getPaymentResponsibleId() {
		return paymentResponsibleId;
	}
	
	public void setResponsibleName(String responsibleName) {
		this.responsibleName = responsibleName;
	}

	public String getResponsibleName() {
		return responsibleName;
	}


}
