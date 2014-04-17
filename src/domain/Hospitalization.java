package domain;

public class Hospitalization {

	private long id;
	private long estimationId;
	private long dischargeTypeId;
	private Patient patient;
	private Bed bed;
	private Specialist specialist;
	private LocationType location;
	private String admissionDate;
	private Unit unit;
	private PaymentResponsible paymentResponsible;
	
	
	
	public void setId(long id) {
		this.id = id;
	}
	
	public long getId() {
		return id;
	}

	public void setEstimationId(long estimationId) {
		this.estimationId = estimationId;
	}

	public long getEstimationId() {
		return estimationId;
	}
	
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
	
	public void setSpecialist(Specialist specialist){
		this.specialist = specialist;
	}
	
	public Specialist getSpecialist(){
		return specialist;
	}
	
	public void setUnit(Unit unit){
		this.unit = unit;
	}
	
	public Unit getUnit(){
		return unit;
	}
	
	public void setResponsible(PaymentResponsible paymentResponsible){
		this.paymentResponsible = paymentResponsible;
	}
	
	public PaymentResponsible getResponsible(){
		return paymentResponsible;
	}
	
	
}
