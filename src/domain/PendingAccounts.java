package domain;


public class PendingAccounts {
	
	private Long billID;
	private Long estimationID;
	private PaymentResponsible paymentResponsible;
	private String total;
	private String generationDate;
	
	public Long getBillID() {
		return billID;
	}
	
	public void setBillID(Long billID) {
		this.billID = billID;
	}
	
	public Long getEstimationID() {
		return estimationID;
	}
	
	public void setEstimationID(Long estimationID) {
		this.estimationID = estimationID;
	}
	
	public PaymentResponsible getPaymentResposible() {
		return paymentResponsible;
	}
	
	public void setPaymentResposible(PaymentResponsible paymentResponsible) {
		this.paymentResponsible = paymentResponsible;
	}

	public String getTotal() {
		return total;
	}
	
	public void setTotal(String total) {
		this.total = total;
	}
	
	public String getGenerationDate() {
		return generationDate;
	}
	
	public void setGenerationDate(String generationDate) {
		this.generationDate = generationDate;
	}

}
