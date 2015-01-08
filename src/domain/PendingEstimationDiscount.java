package domain;


public class PendingEstimationDiscount {
	
	private Long discountID;
	private String firstName;
	private String lastName;
	private String type;
	private String amount;
	private String total;
	private Long estimationID;
	private Long patientID;
	private String identityCard;
	private String justification;
	private String requestDate;
	private String gender;
	private int isAdult;
	private int isApproved;
	private String reviewDate;
	
	public Long getDiscountID() {
		return discountID;
	}
	
	public void setDiscountID(Long discountID) {
		this.discountID = discountID;
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
	
	
	public String getType() {
		return type;
	}
	
	public void setType(String type) {
		this.type = type;
	}
	
	public String getTotal() {
		return total;
	}
	
	public void setTotal(String str, Double total) {
		if(str != null){			
			this.total = Estimation.format.format(total);
		} else {
			this.total = null;
		}
	}
	
	public String getAmount() {
		return amount;
	}
	
	public void setAmount(String str, Double amount) {
		if(str != null){
			this.amount = Estimation.format.format(amount);
		} else {			
			this.amount = null;
		}
	}

	public Long getEstimationID() {
		return estimationID;
	}
	
	public void setEstimationID(Long estimationID) {
		this.estimationID = estimationID;
	}
	
	public String getJustification() {
		return justification;
	}
	
	public void setJustification(String justification) {
		this.justification = justification;
	}
	
	public String getRequestDate() {
		return requestDate;
	}
	
	public void setRequestDate(String requestDate) {
		this.requestDate = requestDate;
	}
	
	
	public int getIsAdult() {
		return isAdult;
	}
	
	public void setIsAdult(int isAdult) {
		this.isAdult = isAdult;
	}
	
	public String getGender() {
		return gender;
	}
	
	public void setGender(String gender) {
		this.gender = gender;
	}
	
	public String getIdentityCard() {
		return identityCard;
	}
	
	public void setIdentityCard(String identityCard) {
		this.identityCard = identityCard;
	}
	
	public Long getPatientID() {
		return patientID;
	}
	
	public void setPatientID(Long patientID) {
		this.patientID = patientID;
	}
	
	public int getIsApproved() {
		return isApproved;
	}
	
	public void setIsApproved(int isApproved) {
		this.isApproved = isApproved;
	}
	
	
	public String getReviewDate() {
		return reviewDate;
	}
	
	public void setReviewDate(String reviewDate) {
		this.reviewDate = reviewDate;
	}
	
	
}
