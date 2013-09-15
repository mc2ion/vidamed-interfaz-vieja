package domain;

public class Estimate {
	
	private long id;
	private long patientId;
	private long doctorId;
	private String releaseDate;
	private double total;
	
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

	public void setDoctorId(long doctorId) {
		this.doctorId = doctorId;
	}

	public long getDoctorId() {
		return doctorId;
	}

	public void setReleaseDate(String releaseDate) {
		this.releaseDate = releaseDate;
	}

	public String getReleaseDate() {
		return releaseDate;
	}

	public void setTotal(double total) {
		this.total = total;
	}

	public double getTotal() {
		return total;
	}
	
	

}
