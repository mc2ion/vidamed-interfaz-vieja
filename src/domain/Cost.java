package domain;

public class Cost {
	
	private String name;
	private String estCost;
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getName() {
		return name;
	}

	public void setCost(String str, Double estCost) {
		this.estCost = str;
	}
	
	public String getCost() {
		return estCost;
	}
}
