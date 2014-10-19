package domain;


public class Payment {

	private Long paymentTypeID;
	private String paymentTypeName;
	private Long paymentMethodID;
	private String paymentMethodName;
	private String amount;
	
	public void setPaymentTypeID(Long paymentTypeID) {
		this.paymentTypeID = paymentTypeID;
	}
	
	public Long getPaymentTypeID() {
		return paymentTypeID;
	}
	
	public void setPaymentTypeName(String paymentTypeName) {
		this.paymentTypeName = paymentTypeName;
	}

	public String getPaymentTypeName() {
		return paymentTypeName;
	}
	
	public void setPaymentMethodID(Long paymentMethodID) {
		this.paymentMethodID = paymentMethodID;
	}
	
	public Long getPaymentMethodID() {
		return paymentMethodID;
	}
	
	public void setPaymentMethodName(String paymentMethodName) {
		this.paymentMethodName = paymentMethodName;
	}

	public String getPaymentMethodName() {
		return paymentMethodName;
	}
	public void setAmount(String amount){
		this.amount = amount;
	}
	
	public String getAmount(){
		return amount;
	}
	
}
