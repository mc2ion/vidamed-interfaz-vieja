package domain;

public class PaymentMethod {
	
	private long id;
	private String name;
		
	public void setId(long id) {        
		this.id = id;
	}
	
	public long getId() {
		return id;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getName() {
		return name;
	}

}
