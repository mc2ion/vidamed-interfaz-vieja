package domain;

public class Emergency {

	private long id;
	//private long patientId;
	private long estimationId;
	private String checkIn;
	private String checkOut;
	//private long bedId;
	private long dischargeTypeId;
	private Patient patient;
	private Bed bed;
	private LocationType location;
	private String admissionDate;
	
	
	public void setId(long id) {
		this.id = id;
	}
	
	public long getId() {
		return id;
	}

	/*public void setPatientId(long patientId) {
		this.patientId = patientId;
	}

	public long getPatientId() {
		return patientId;
	}*/
	
	public void setEstimationId(long estimationId) {
		this.estimationId = estimationId;
	}

	public long getEstimationId() {
		return estimationId;
	}
	
	public void setCheckIn(String checkIn) {
		this.checkIn = checkIn;
	}

	public String getCheckIn() {
		return checkIn;
	}

	public void setCheckOut(String checkOut) {
		this.checkOut = checkOut;
	}

	public String getCheckOut() {
		return checkOut;
	}

	/*public void setBedId(long bedId) {
		this.bedId = bedId;
	}

	public long getBedId() {
		return bedId;
	}*/

	public void setDischargeTypeId(long dischargeTypeId) {
		this.dischargeTypeId = dischargeTypeId;
	}

	public long getDischargeTypeId() {
		return dischargeTypeId;
	}
	
	public void setPatient(Patient patient){
		this.patient = patient;
	}
	
	public Patient getPatient(){
		return patient;
	}
	
	public void setBed(Bed bed){
		this.bed = bed;
	}
	
	public Bed getBed(){
		return bed;
	}
	
	public void setLocation(LocationType location){
		this.location = location;
	}
	
	public LocationType getLocation(){
		return location;
	}
	
	public void setAdmissionDate(String admissionDate){
		this.admissionDate = admissionDate;
	}
	
	public String getAdmissionDate(){
		return admissionDate;
	}
	
}
