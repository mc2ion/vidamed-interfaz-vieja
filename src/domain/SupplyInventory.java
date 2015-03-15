package domain;

public class SupplyInventory {

	private Long supplyInventoryID;
	private Long supplyID;
	private String manufacturer;
	private Long boxes;
	private Long amountPerBox;
	private Long amount;
	private Double purchasePrice;
	private Double salePrice;
	private String incomingDate;
	private SupplyProvider provider;
	private String lotNumber;
	private String expirationDate;
	
	public void setSupplyInventoryID(Long supplyInventoryID) {
		this.supplyInventoryID = supplyInventoryID;
	}
	
	public Long getSupplyInventoryID() {
		return supplyInventoryID;
	}

	public void setSupplyID(Long supplyID) {
		this.supplyID = supplyID;
	}

	public Long getSupplyID() {
		return supplyID;
	}

	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}

	public String getManufacturer() {
		return manufacturer;
	}

	public void setBoxes(Long boxes) {
		this.boxes = boxes;
	}

	public Long getBoxes() {
		return boxes;
	}

	public void setAmountPerBox(Long amountPerBox) {
		this.amountPerBox = amountPerBox;
	}

	public Long getAmountPerBox() {
		return amountPerBox;
	}

	public void setAmount(Long amount) {
		this.amount = amount;
	}

	public Long getAmount() {
		return amount;
	}

	public void setPurchasePrice(Double purchasePrice) {
		this.purchasePrice = purchasePrice;
	}

	public Double getPurchasePrice() {
		return purchasePrice;
	}

	public void setSalePrice(Double salePrice) {
		this.salePrice = salePrice;
	}

	public Double getSalePrice() {
		return salePrice;
	}

	public void setIncomingDate(String incomingDate) {
		this.incomingDate = incomingDate;
	}

	public String getIncomingDate() {
		return incomingDate;
	}

	public void setProvider(SupplyProvider provider) {
		this.provider = provider;
	}

	public SupplyProvider getProvider() {
		return provider;
	}

	public void setLotNumber(String lotNumber) {
		this.lotNumber = lotNumber;
	}

	public String getLotNumber() {
		return lotNumber;
	}

	public void setExpirationDate(String expirationDate) {
		this.expirationDate = expirationDate;
	}

	public String getExpirationDate() {
		return expirationDate;
	}
	
}
