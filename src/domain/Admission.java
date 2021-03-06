package domain;

import java.text.NumberFormat;
import java.util.Locale;


public class Admission {
	
	public static Locale spanish = new Locale("es","ES");
	public static NumberFormat format = NumberFormat.getNumberInstance(spanish);

	private Long admissionID;
	private Long estimationID;
	private Long patientID;
	private String identityCard;
	private String firstName;
	private String lastName;
	private int isAdult;
	private long responsibleID;
	private String responsibleName;
	private String observation;
	private long statusID;
	private String statusName;
	private long reasonID;
	private String reasonName;
	private String admissionDate;
	private Long dischargeTypeId;
	private String dischargeName;
	private String dischargeDate;
	private int wasDischarge;
	private int wasPaid;
	private String total;
	private String totalPaid;
	private Specialist spec;
	private Estimation estimation;
	private String totalWithDiscount;
	private String responsibleAddress;
	private String responsibleRIF;
	private String keyNumber;
	private Double coverageAmount;
	private String guaranteeLetter;
	private Long billID;
	private String responsiblePayment;
	private String patientPayment;
	private String totalDollar;
	private String totalPaidDollar;
	private String totalWithDiscountDollar;
	private Long exchangeRateID;
	private String exchangeRate;
	private String exchangeRateDate;
	
	public Long getAdmissionID() {
		return admissionID;
	}
	
	public void setAdmissionID(Long admissionID) {
		this.admissionID = admissionID;
	}
	
	public Long getEstimationID() {
		return estimationID;
	}
	
	public void setEstimationID(Long estimationID) {
		this.estimationID = estimationID;
	}
	
	public Long getPatientID() {
		return patientID;
	}
	
	public void setPatientID(Long patientID) {
		this.patientID = patientID;
	}
	
	
	public String getIdentityCard() {
		return identityCard;
	}
	
	public void setIdentityCard(String identityCard) {
		this.identityCard = identityCard;
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
	
	public int getIsAdult() {
		return isAdult;
	}
	
	public void setIsAdult(int isAdult) {
		this.isAdult = isAdult;
	}
	
	public Long getResponsibleID() {
		return responsibleID;
	}
	
	public void setResponsibleID(Long responsibleID) {
		this.responsibleID = responsibleID;
	}
	
	public String getResponsibleName() {
		return responsibleName;
	}
	
	public void setResponsibleName(String responsibleName) {
		this.responsibleName = responsibleName;
	}
	
	public String getObservation() {
		return observation;
	}
	
	public void setObservation(String observation) {
		this.observation = observation;
	}
	
	public Long getStatusID() {
		return statusID;
	}
	
	public void setStatusID(Long statusID) {
		this.statusID = statusID;
	}
	
	public String getStatusName() {
		return statusName;
	}
	
	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}
	
	public Long getReasonID() {
		return reasonID;
	}
	
	public void setReasonID(Long reasonID) {
		this.reasonID = reasonID;
	}
	
	public String getReasonName() {
		return reasonName;
	}
	
	public void setReasonName(String reasonName) {
		this.reasonName = reasonName;
	}
	
	public String getAdmissionDate() {
		return admissionDate;
	}
	
	public void setAdmissionDate(String admissionDate) {
		this.admissionDate = admissionDate;
	}
	
	public Long getDischargeTypeID() {
		return dischargeTypeId;
	}
	
	public void setDischargeTypeID(Long dischargeTypeId) {
		this.dischargeTypeId = dischargeTypeId;
	}
	
	public String getDischargeName() {
		return dischargeName;
	}
	
	public void setDischargeName(String dischargeName) {
		this.dischargeName = dischargeName;
	}
	
	public String getDischargeDate() {
		return dischargeDate;
	}
	
	public void setDischargeDate(String dischargeDate) {
		this.dischargeDate = dischargeDate;
	}
	
	public int getWasDischarge() {
		return wasDischarge;
	}
	
	public void setWasDischarge(int wasDischarge) {
		this.wasDischarge = wasDischarge;
	}
	
	public int getWasPaid() {
		return wasPaid;
	}
	
	public void setWasPaid(int wasPaid) {
		this.wasPaid = wasPaid;
	}
	
	public String getTotal() {
		return total;
	}
	
	public void setTotal(String str, Double total) {
		if(str!=null){
			this.total = Estimation.format.format(total);
		} else {
			this.total = null;
		}
	}
	
	public String getTotalPaid() {
		return totalPaid;
	}
	
	public void setTotalPaid(String str, Double totalPaid) {
		if(str!=null){
			this.totalPaid = Estimation.format.format(totalPaid);
		} else {
			this.totalPaid = null;
		}
	}
	
	public Specialist getSpecialist() {
		return spec;
	}
	
	public void setSpecialist(Specialist spec) {
		this.spec = spec;
	}

	public void setEstimation(Estimation estimation) {
		this.estimation = estimation;
	}

	public Estimation getEstimation() {
		return estimation;
	}
	
	public String getTotalWithDiscount() {
		return totalWithDiscount;
	}
	
	public void setTotalWithDiscount(String str, Double totalWithDiscount) {
		if(str!=null){
			this.totalWithDiscount = format.format(totalWithDiscount);
		} else {
			this.totalWithDiscount = null;
		}
	}

	public void setResponsibleAddress(String responsibleAddress) {
		this.responsibleAddress = responsibleAddress;
	}

	public String getResponsibleAddress() {
		return responsibleAddress;
	}

	public void setResponsibleRIF(String responsibleRIF) {
		this.responsibleRIF = responsibleRIF;
	}

	public String getResponsibleRIF() {
		return responsibleRIF;
	}

	public void setKeyNumber(String keyNumber) {
		this.keyNumber = keyNumber;
	}

	public String getKeyNumber() {
		return keyNumber;
	}

	public void setCoverageAmount(Double coverageAmount) {
		this.coverageAmount = coverageAmount;
	}

	public Double getCoverageAmount() {
		return coverageAmount;
	}

	public void setGuaranteeLetter(String guaranteeLetter) {
		this.guaranteeLetter = guaranteeLetter;
	}

	public String getGuaranteeLetter() {
		return guaranteeLetter;
	}

	public void setBillID(Long billID) {
		this.billID = billID;
	}

	public Long getBillID() {
		return billID;
	}

	public String getResponsiblePayment() {
		return responsiblePayment;
	}
	
	public void setResponsiblePayment(String str, Double responsiblePayment) {
		if(str!=null){
			this.responsiblePayment = Estimation.format.format(responsiblePayment);
		} else {
			this.responsiblePayment = null;
		}
	}
	
	public String getPatientPayment() {
		return patientPayment;
	}
	
	public void setPatientPayment(String str, Double patientPayment) {
		if(str!=null){
			this.patientPayment = Estimation.format.format(patientPayment);
		} else {
			this.patientPayment = null;
		}
	}

	public String getTotalDollar() {
		return totalDollar;
	}

	public void setTotalDollar(String str, Double totalDollar) {
		if(str!=null){
			this.totalDollar = Estimation.format.format(totalDollar);
		} else {
			this.totalDollar = null;
		}
	}

	public String getTotalPaidDollar() {
		return totalPaidDollar;
	}

	public void setTotalPaidDollar(String str, Double totalPaidDollar) {
		if(str!=null){
			this.totalPaidDollar = Estimation.format.format(totalPaidDollar);
		} else {
			this.totalPaidDollar = null;
		}
	}

	public String getTotalWithDiscountDollar() {
		return totalWithDiscountDollar;
	}

	public void setTotalWithDiscountDollar(String str, Double totalWithDiscountDollar) {
		if(str!=null){
			this.totalWithDiscountDollar = format.format(totalWithDiscountDollar);
		} else {
			this.totalWithDiscountDollar = null;
		}
	}

	public Long getExchangeRateID() {
		return exchangeRateID;
	}

	public void setExchangeRateID(Long exchangeRateID) {
		this.exchangeRateID = exchangeRateID;
	}

	public String getExchangeRate() {
		return exchangeRate;
	}

	public void setExchangeRate(String str, Double exchangeRate) {
		if(str!=null){
			this.exchangeRate = format.format(exchangeRate);
		} else {
			this.exchangeRate = null;
		}
	}

	public String getExchangeRateDate() {
		return exchangeRateDate;
	}

	public void setExchangeRateDate(String exchangeRateDate) {
		this.exchangeRateDate = exchangeRateDate;
	}
}
