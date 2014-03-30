package domain;

import java.util.ArrayList;

public class PaymentResponsible {

	private Long id;
	private String name;
	private Long bussinessRuleId;
	private String ruleName;
	private ArrayList<ResponsibleRule> rrList;
	
	
	public void setId(Long id) {
		this.id = id;
	}
	
	public Long getId() {
		return id;
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
	
	
}
