package domain;

public class Invoice {
	
	private Long billID;
	private String clinicTotal;
	private String drugs;
	private String materials;
	private String labs;
	private String xRays;
	private String ecos;
	private String professionalFees;
	private String total;
	private String discount;
	private Long paymentResponsibleID;
	private String paymentResponsibleName;
	private Long reasonID;
	private String reasonName;
	private Long admissionID;
	private String coverageAmount;
	private String coverageTotalPaid;
	private Integer billsAmount;
	
	public void setBillID(Long billID) {
		this.billID = billID;
	}
	
	public Long getBillID() {
		return billID;
	}

	public void setClinicTotal(String clinicTotal) {
		this.clinicTotal = clinicTotal;
	}

	public String getClinicTotal() {
		return clinicTotal;
	}

	public void setDrugs(String drugs) {
		this.drugs = drugs;
	}

	public String getDrugs() {
		return drugs;
	}

	public void setMaterials(String materials) {
		this.materials = materials;
	}

	public String getMaterials() {
		return materials;
	}

	public void setLabs(String labs) {
		this.labs = labs;
	}

	public String getLabs() {
		return labs;
	}

	public void setxRays(String xRays) {
		this.xRays = xRays;
	}

	public String getxRays() {
		return xRays;
	}

	public void setEcos(String ecos) {
		this.ecos = ecos;
	}

	public String getEcos() {
		return ecos;
	}

	public void setProfessionalFees(String professionalFees) {
		this.professionalFees = professionalFees;
	}

	public String getProfessionalFees() {
		return professionalFees;
	}

	public void setTotal(String total) {
		this.total = total;
	}

	public String getTotal() {
		return total;
	}

	public void setDiscount(String discount) {
		this.discount = discount;
	}

	public String getDiscount() {
		return discount;
	}

	public void setPaymentResponsibleID(Long paymentResponsibleID) {
		this.paymentResponsibleID = paymentResponsibleID;
	}

	public Long getPaymentResponsibleID() {
		return paymentResponsibleID;
	}

	public void setPaymentResponsibleName(String paymentResponsibleName) {
		this.paymentResponsibleName = paymentResponsibleName;
	}

	public String getPaymentResponsibleName() {
		return paymentResponsibleName;
	}

	public void setReasonID(Long reasonID) {
		this.reasonID = reasonID;
	}

	public Long getReasonID() {
		return reasonID;
	}

	public void setReasonName(String reasonName) {
		this.reasonName = reasonName;
	}

	public String getReasonName() {
		return reasonName;
	}

	public void setAdmissionID(Long admissionID) {
		this.admissionID = admissionID;
	}

	public Long getAdmissionID() {
		return admissionID;
	}

	public void setCoverageAmount(String coverageAmount) {
		this.coverageAmount = coverageAmount;
	}

	public String getCoverageAmount() {
		return coverageAmount;
	}

	public void setCoverageTotalPaid(String coverageTotalPaid) {
		this.coverageTotalPaid = coverageTotalPaid;
	}

	public String getCoverageTotalPaid() {
		return coverageTotalPaid;
	}

	public void setBillsAmount(Integer billsAmount) {
		this.billsAmount = billsAmount;
	}

	public Integer getBillsAmount() {
		return billsAmount;
	}

}
