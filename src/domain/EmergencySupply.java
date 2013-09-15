package domain;

public class EmergencySupply {

	private long emergencyId;
	private long supplyId;
	private int quantity;
	private double price;
	
	public void setEmergencyId(long emergencyId) {
		this.emergencyId = emergencyId;
	}
	
	public long getEmergencyId() {
		return emergencyId;
	}

	public void setSupplyId(long supplyId) {
		this.supplyId = supplyId;
	}

	public long getSupplyId() {
		return supplyId;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public double getPrice() {
		return price;
	}
	
	
}
