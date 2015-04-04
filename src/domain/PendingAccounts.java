package domain;


public class PendingAccounts {
	
	private Long billID;
	private Long estimationID;
	private PaymentResponsible paymentResponsible;
	private String total;
	private String totalWithDiscount;
	private String totalPaid;	
	private String generationDate;
	
	
	public void setTotalWithDiscount(String totalWithDiscount, Double amount) {
		if(totalWithDiscount != null){
			this.totalWithDiscount = Estimation.format.format(amount);
		} else {			
			this.totalWithDiscount = null;
		}
	}
	
	public String getTotalWithDiscount(){
		return totalWithDiscount;
	}
	
	public void setTotalPaid(String totalPaid, Double amount) {
		if(totalPaid != null){
			this.totalPaid = Estimation.format.format(amount);
		} else {			
			this.totalPaid = null;
		}
	}
	
	public String getTotalPaid(){
		return totalPaid;
	}
	
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
	
	public void setTotal(String totalWithDiscount, Double amount) {
		if(totalWithDiscount != null){
			this.total = Estimation.format.format(amount);
		} else {			
			this.total = null;
		}
	}
	
	public String getGenerationDate() {
		return generationDate;
	}
	
	public void setGenerationDate(String generationDate) {
		this.generationDate = generationDate;
	}

}
