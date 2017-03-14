package domain;

public class PaymentResponsibleCollection {

	private String billID;
	private String coverageAmount;
	private String retention;
	private Integer reasonID;
	private String reasonName;
	private String promptPaymentAmount;
	private String refund;
	
	public void setBillID(String billID) {
		this.billID = billID;
	}
	
	public String getBillID() {
		return billID;
	}

	public void setCoverageAmount(String coverageAmount) {
		this.coverageAmount = coverageAmount;
	}

	public String getCoverageAmount() {
		return coverageAmount;
	}

	public void setRetention(String retention) {
		this.retention = retention;
	}

	public String getRetention() {
		return retention;
	}

	public void setReasonID(Integer reasonID) {
		this.reasonID = reasonID;
	}

	public Integer getReasonID() {
		return reasonID;
	}

	public void setReasonName(String reasonName) {
		this.reasonName = reasonName;
	}

	public String getReasonName() {
		return reasonName;
	}

	public void setPromptPaymentAmount(String promptPaymentAmount) {
		if(promptPaymentAmount != null) {
			this.promptPaymentAmount = promptPaymentAmount;
		} else {
			this.promptPaymentAmount = "0.00";
		}
	}

	public String getPromptPaymentAmount() {
		return promptPaymentAmount;
	}

	public void setRefund(String refund) {
		if(refund != null) {
			this.refund = refund;
		} else {
			this.refund = "0.00";
		}
	}

	public String getRefund() {
		return refund;
	}
}
