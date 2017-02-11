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

}
