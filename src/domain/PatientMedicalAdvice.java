package domain;

public class PatientMedicalAdvice {
	
	private Long admissionID;
	private Long estimationID;
	private Long patientMedicalAdviceID;
	private Long unitID;
	private String unitName;
	private Specialist specialist;
	private double medicalFeed;
	private String medicalAdviceDate;
	private Patient patient;
	
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
	
	
	public Long getPatientMedicalAdviceID() {
		return patientMedicalAdviceID;
	}
	
	public void setPatientMedicalAdviceID(Long patientMedicalAdviceID) {
		this.patientMedicalAdviceID = patientMedicalAdviceID;
	}
	
	public Long getUnitID() {
		return unitID;
	}
	
	public void setUnitID(Long unitID) {
		this.unitID = unitID;
	}
	
	public String getUnitName() {
		return unitName;
	}
	
	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}
	
	public Specialist getSpecialist() {
		return specialist;
	}
	
	public void setSpecialist(Specialist specialist) {
		this.specialist = specialist;
	}
	
	public double getMedicalFeed() {
		return medicalFeed;
	}

	public void setMedicalFeed(double medicalFeed) {
		this.medicalFeed = medicalFeed;
	}
	
	public String getMedicalAdviceDate() {
		return medicalAdviceDate;
	}
	
	public void setMedicalAdviceDate(String medicalAdviceDate) {
		this.medicalAdviceDate = medicalAdviceDate;
	}
	
	public Patient getPatient() {
		return patient;
	}
	
	public void setPatient(Patient patient) {
		this.patient = patient;
	}
}
