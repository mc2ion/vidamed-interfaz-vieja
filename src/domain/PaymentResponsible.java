package domain;

import java.util.ArrayList;

public class PaymentResponsible {

	private Long id;
	private Long estimationId;
	private String name;
	private Long bussinessRuleId;
	private String ruleName;
	private ArrayList<ResponsibleRule> rrList;
	private String address;
	private String phoneNumber;
	private String contactName;
	private int hasGuaranteeLetter;
	private int isPolicyHolder;
	private String policyHolderName;
	private String policyHolderIdentityCard;
	private double total;
	
	public void setId(Long id) {
		this.id = id;
	}
	
	public Long getId() {
		return id;
	}
	
	public void setEstimationId(Long estimationId) {
		this.estimationId = estimationId;
	}
	
	public Long getEstimationId() {
		return estimationId;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}
	
	public void setBussinessRuleId(Long bussinessRuleId) {
		this.bussinessRuleId = bussinessRuleId;
	}
	
	public Long getBussinessRuleId() {
		return bussinessRuleId;
	}
	
	public void setRuleName(String ruleName) {
		this.ruleName = ruleName;
	}

	public String getRuleName() {
		return ruleName;
	}
	
	public void setResponsableRulesList(ArrayList<ResponsibleRule> rrList) {
		this.rrList = rrList;
	}

	public ArrayList<ResponsibleRule> getResponsableRulesList() {
		return rrList;
	}
	
	public void setAddress(String address){
		this.address = address;
	}
	
	public String getAddress(){
		return address;
	}
	
	public void setPhone(String phone){
		this.phoneNumber = phone;
	}
	
	public String getPhone(){
		return phoneNumber;
	}
	
	public void setHasGuaranteeLetter(int hasGuaranteeLetter){
		this.hasGuaranteeLetter = hasGuaranteeLetter;
	}
	
	public int getHasGuaranteeLetter(){
		return hasGuaranteeLetter;
	}
	
	public void setIsPolicyHolder(int isPolicyHolder){
		this.isPolicyHolder = isPolicyHolder;
	}
	
	public int getIsPolicyHolder(){
		return isPolicyHolder;
	}
	
	public void setPolicyHolderName(String policyHolderName){
		this.policyHolderName = policyHolderName;
	}
	
	public String getPolicyHolderName(){
		return policyHolderName;
	}
	
	public void setPolicyHolderIdentityCard(String policyHolderIdentityCard){
		this.policyHolderIdentityCard = policyHolderIdentityCard;
	}
	
	public String getPolicyHolderIdentityCard(){
		return policyHolderIdentityCard;
	}
	
	public void setTotal(double total){
		this.total = total;
	}
	
	public double getTotal(){
		return total;
	}
	
	public void setContactName(String contactName){
		this.contactName = contactName;
	}
	
	public String getContactName(){
		return contactName;
	}
	
}
