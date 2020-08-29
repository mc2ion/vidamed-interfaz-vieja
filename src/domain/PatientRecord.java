package domain;

public class PatientRecord {

	private Long admissionID;
	private String admissionDate;
	private String patientName;
	private String identityCard;
	private String age;
	private String gender;
	private String diagnosis;
	private String protocolName;
	private String type;
	private String attendingSpecialist;
	private String helper1;
	private String helper2;
	private String anesthesiologist;
	private String roomDays;
	private String dischargeDate;
	
	public Long getAdmissionID() {
		return admissionID;
	}
	
	public void setAdmissionID(Long admissionID) {
		this.admissionID = admissionID;
	}

	public String getAdmissionDate() {
		return admissionDate;
	}

	public void setAdmissionDate(String admissionDate) {
		this.admissionDate = admissionDate;
	}

	public String getPatientName() {
		return patientName;
	}

	public void setPatientName(String patientName) {
		this.patientName = patientName;
	}

	public String getIdentityCard() {
		return identityCard;
	}

	public void setIdentityCard(String identityCard) {
		this.identityCard = identityCard;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getDiagnosis() {
		return diagnosis;
	}

	public void setDiagnosis(String diagnosis) {
		this.diagnosis = diagnosis;
	}

	public String getProtocolName() {
		return protocolName;
	}

	public void setProtocolName(String protocolName) {
		this.protocolName = protocolName;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getAttendingSpecialist() {
		return attendingSpecialist;
	}

	public void setAttendingSpecialist(String attendingSpecialist) {
		this.attendingSpecialist = attendingSpecialist;
	}

	public String getHelper1() {
		return helper1;
	}

	public void setHelper1(String helper1) {
		this.helper1 = helper1;
	}

	public String getHelper2() {
		return helper2;
	}

	public void setHelper2(String helper2) {
		this.helper2 = helper2;
	}

	public String getAnesthesiologist() {
		return anesthesiologist;
	}

	public void setAnesthesiologist(String anesthesiologist) {
		this.anesthesiologist = anesthesiologist;
	}

	public String getRoomDays() {
		return roomDays;
	}

	public void setRoomDays(String roomDays) {
		this.roomDays = roomDays;
	}

	public String getDischargeDate() {
		return dischargeDate;
	}

	public void setDischargeDate(String dischargeDate) {
		this.dischargeDate = dischargeDate;
	}
}
