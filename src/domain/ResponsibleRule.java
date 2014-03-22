package domain;

public class ResponsibleRule {

	private Long paymentRid;
	private Long bussinesRuleMicroId;
	private Long bussinessModelId;
	private double percentage;
	
	public void setPaymentResponsableId(Long paymentRid) {
		this.paymentRid = paymentRid;
	}
	
	public Long getPaymentResponsableId() {
		return paymentRid;
	}

	public void setBussinesRuleMicroId(Long bussinesRuleMicroId) {
		this.bussinesRuleMicroId = bussinesRuleMicroId;
	}
	
	public Long getBussinesRuleMicroId() {
		return bussinesRuleMicroId;
	}
	
	public void setBussinessModelId(Long bussinessModelId) {
		this.bussinessModelId = bussinessModelId;
	}
	
	public Long getBussinessModelId() {
		return bussinessModelId;
	}
	
	public void setPercentage(double percentage) {
		this.percentage = percentage;
	}
	
	public double getPercentage() {
		return percentage;
	}
}
