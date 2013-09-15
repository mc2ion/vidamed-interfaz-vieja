package domain;

public class DoctorPhone {
	
	private long doctorId;
	private String phoneNumber;
	private long phoneTypeId;
	
	public void setDoctorId(long doctorId) {
		this.doctorId = doctorId;
	}
	
	public long getDoctorId() {
		return doctorId;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneType(long phoneTypeId) {
		this.phoneTypeId = phoneTypeId;
	}

	public long getPhoneType() {
		return phoneTypeId;
	}
	

}
