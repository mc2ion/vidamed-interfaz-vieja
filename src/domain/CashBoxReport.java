package domain;

public class CashBoxReport {
	
	private Long cashBoxID;
	private Long paymentID;
	private String cashBoxName;
	private User cashier;
	private Payment payment;
	private PaymentResponsible responsible;
	private String date;
	private String total;
	
	public Long getCashBoxID() {
		return cashBoxID;
	}
	
	public void setCashBoxID(Long cashBoxID) {
		this.cashBoxID = cashBoxID;
	}
	
	public Long getPaymentID() {
		return paymentID;
	}
	
	public void setPaymentID(Long paymentID) {
		this.paymentID = paymentID;
	}
	
	public String getName() {
		return cashBoxName;
	}
	
	public void setName(String name) {
		this.cashBoxName = name;
	}
	
	public User getCashier() {
		return cashier;
	}
	
	public void setCashier(User cashier) {
		this.cashier = cashier;
	}
	
	public Payment getPayment() {
		return payment;
	}
	
	public void setPayment(Payment payment) {
		this.payment = payment;
	}
	
	public PaymentResponsible getPaymentResponsible() {
		return responsible;
	}
	
	public void setPaymentResponsible(PaymentResponsible responsible) {
		this.responsible = responsible;
	}
	
	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
	
	public String getTotal() {
		return total;
	}

	public void setTotal(String total) {
		this.total = total;
	}

}
