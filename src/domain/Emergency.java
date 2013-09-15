package domain;

public class Emergency {

	private long id;
	private long patientId;
	private String checkIn;
	private String checkOut;
	private long bedId;
	private long dischargeTypeId;
	
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

	public void setBedId(long bedId) {
		this.bedId = bedId;
	}

	public long getBedId() {
		return bedId;
	}

	public void setDischargeTypeId(long dischargeTypeId) {
		this.dischargeTypeId = dischargeTypeId;
	}

	public long getDischargeTypeId() {
		return dischargeTypeId;
	}
}
