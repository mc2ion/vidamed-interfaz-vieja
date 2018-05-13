package domain;

import java.text.NumberFormat;
import java.util.Locale;

public class Estimation {
	
	public static Locale spanish = new Locale("es","ES");
	public static NumberFormat format = NumberFormat.getNumberInstance(spanish);
	
	static {
		format.setMinimumFractionDigits(2);
		format.setMaximumFractionDigits(2);
	}
	
	private long id;
	private long patientId;
	private long specialistId;
	private long unitId;
	private String identityCard;
	private String firstName;
	private String lastName;
	private long paymentResponsibleId;
	private int isPolicyHolder;
	private int hasGuaranteeLetter;
	private long clinicTypeID;
	private String policyHolderIdentityCard;
	private String policyHolderID;
	private String policyHolderName;
	private String responsibleName;
	private String specialistName;
	private String isAdult;
	private String discount;
	private String total;
	private String editionDate;
	private String creationUser;
	private String editionUser;
	private String totalWithDiscount;
	private String clinicName;
	private String paymentResponsibleName;
	private String tempTotal;
	private String tempTotalWithDiscount;
	
	public void setIsPolicyHolder(int isPolicyHolder) {
		this.isPolicyHolder = isPolicyHolder;
	}
	
	public int getIsPolicyHolder() {
		return isPolicyHolder;
	}
	
	public void setPolicyHolderIdentityCard(String policyHolderIdentityCard ) {
		this.policyHolderIdentityCard = policyHolderIdentityCard;
	}
	
	public String getPolicyHolderIdentityCard() {
		return policyHolderIdentityCard;
	}
	
	public void setHasGuaranteeLetter(int hasGuaranteeLetter) {
		this.hasGuaranteeLetter = hasGuaranteeLetter;
	}
	
	public int getHasGuaranteeLetter() {
		return hasGuaranteeLetter;
	}
	
	public void setClinicTypeID(long clinicTypeID) {
		this.clinicTypeID = clinicTypeID;
	}
	
	public long getClinicTypeID() {
		return clinicTypeID;
	}
	
	public void setId(long id) {
		this.id = id;
	}
	
	public long getId() {
		return id;
	}

	public void setPatientId(long patientId) {
		this.patientId = patientId;
	}

	public long getPatientId() {
		return patientId;
	}
	
	public void setSpecialistId(long specialistId) {
		this.specialistId = specialistId;
	}

	public long getSpecialistId() {
		return specialistId;
	}
	
	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}

	public long getUnitId() {
		return unitId;
	}

	
	public void setIdentityCard(String identityCard) {
		this.identityCard = identityCard;
	}

	public String getIdentityCard() {
		return identityCard;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getFirstName() {
		return firstName;
	}
	
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setPaymentResponsibleId(long paymentResponsibleId) {
		this.paymentResponsibleId = paymentResponsibleId;
	}
	
	public long getPaymentResponsibleId() {
		return paymentResponsibleId;
	}
	
	public void setResponsibleName(String responsibleName) {
		this.responsibleName = responsibleName;
	}

	public String getPolicyHolderID() {
		return policyHolderID;
	}
	
	public void setPolicyHolderID(String policyHolderID) {
		this.policyHolderID = policyHolderID;
	}
	
	public String getPolicyHolderName() {
		return policyHolderName;
	}
	
	public void setPolicyHolderName(String policyHolderName) {
		this.policyHolderName = policyHolderName;
	}

	
	public String getResponsibleName() {
		return responsibleName;
	}
	
	public void setSpecialistName(String specialistName) {
		this.specialistName = specialistName;
	}


	public String getSpecialistName() {
		return specialistName;
	}
	
	
	public void setIsAdult(String isAdult) {
		this.isAdult = isAdult;
	}

	public String getIsAdult() {
		return isAdult;
	}
	
	public void setDiscount(String discount) {
		this.discount = discount;
	}

	public String getDiscount() {
		return discount;
	}
	
	public void setTotal(String str, Double total) {
		if(str!=null){
			this.total = format.format(total);
			this.tempTotal = format.format(total/1000);
		} else {
			this.total = null;
		}
	}

	public String getTotal() {
		return total;
	}
	
	public String getTempTotal() {
		return tempTotal;
	}
	
	public void setEditionDate(String editionDate) {
		this.editionDate = editionDate;
	}

	public String getEditionDate() {
		return editionDate;
	}
	
	public void setCreationUser(String creationUser) {
		this.creationUser = creationUser;
	}

	public String getCreationUser() {
		return creationUser;
	}
	
	public void setEditionUser(String editionUser) {
		this.editionUser = editionUser;
	}

	public String getEditionUser() {
		return editionUser;
	}
	
	public void setTotalWithDiscount(String str, Double totalWithDiscount) {
		if(str!=null){
			this.totalWithDiscount = format.format(totalWithDiscount);
			this.tempTotalWithDiscount = format.format(totalWithDiscount/1000);
		} else {
			this.totalWithDiscount = null;
			this.tempTotalWithDiscount = null;
		}
	}

	public String getTotalWithDiscount() {
		return totalWithDiscount;
	}

	public String getTempTotalWithDiscount() {
		return tempTotalWithDiscount;
	}

	public void setClinicName(String clinicName) {
		this.clinicName = clinicName;
	}
	
	public String getClinicName() {
		return this.clinicName;
	}
	
	public void setPaymentResponsibleName(String paymentResponsibleName) {
		this.paymentResponsibleName = paymentResponsibleName;
	}
	
	public String getPaymentResponsibleName() {
		return this.paymentResponsibleName;
	}
	
	public static String leftPadStringWithChar(String s, int fixedLength, char c){

	    if(fixedLength < s.length()){
	        throw new IllegalArgumentException();
	    }

	    StringBuilder sb = new StringBuilder(s);

	    for(int i = 0; i < fixedLength - s.length(); i++){
	        sb.insert(0, c);
	    }

	    return sb.toString();
	}
}
