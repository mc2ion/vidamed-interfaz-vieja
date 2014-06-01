package domain;


public class Admission {
	
	private Long admissionID;
	private Long estimationID;
	private Long patientID;
	private String identityCard;
	private String firstName;
	private String lastName;
	private int isAdult;
	private long responsibleID;
	private String responsibleName;
	private String observation;
	private long statusID;
	private String statusName;
	private long reasonID;
	private String reasonName;
	private String admissionDate;
	private Long dischargeTypeId;
	private String dischargeName;
	private String dischargeDate;
	
	
	public Long getAdmissionID() {
		return admissionID;
	}
	
	public void setAdmissionID(Long admissionID) {
		this.admissionID = admissionID;
	}
	
	public Long getEstimationID() {
		return estimationID;
	}
	
	public void setEstimationID(Long estimationID) {
		this.estimationID = estimationID;
	}
	
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
	
	public Long getResponsibleID() {
		return responsibleID;
	}
	
	public void setResponsibleID(Long responsibleID) {
		this.responsibleID = responsibleID;
	}
	
	public String getResponsibleName() {
		return responsibleName;
	}
	
	public void setResponsibleName(String responsibleName) {
		this.responsibleName = responsibleName;
	}
	
	public String getObservation() {
		return observation;
	}
	
	public void setObservation(String observation) {
		this.observation = observation;
	}
	
	public Long getStatusID() {
		return statusID;
	}
	
	public void setStatusID(Long statusID) {
		this.statusID = statusID;
	}
	
	public String getStatusName() {
		return statusName;
	}
	
	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}
	
	public Long getReasonID() {
		return reasonID;
	}
	
	public void setReasonID(Long reasonID) {
		this.reasonID = reasonID;
	}
	
	public String getReasonName() {
		return reasonName;
	}
	
	public void setReasonName(String reasonName) {
		this.reasonName = reasonName;
	}
	
	public String getAdmissionDate() {
		return admissionDate;
	}
	
	public void setAdmissionDate(String admissionDate) {
		this.admissionDate = admissionDate;
	}
	
	public Long getDischargeTypeID() {
		return dischargeTypeId;
	}
	
	public void setDischargeTypeID(Long dischargeTypeId) {
		this.dischargeTypeId = dischargeTypeId;
	}
	
	public String getDischargeName() {
		return dischargeName;
	}
	
	public void setDischargeName(String dischargeName) {
		this.dischargeName = dischargeName;
	}
	
	public String getDischargeDate() {
		return dischargeDate;
	}
	
	public void setDischargeDate(String dischargeDate) {
		this.dischargeDate = dischargeDate;
	}
	
	
}
