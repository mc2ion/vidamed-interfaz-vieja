package domain;

public class AnesthesiaType {
	
	private Long anesthesiaTypeId;
	private String name;
	private Double firstHourPrice;
	private Double extraHourPrice;
	
	public void setAnesthesiaTypeId(Long anesthesiaTypeId) {
		this.anesthesiaTypeId = anesthesiaTypeId;
	}
	
	public Long getAnesthesiaTypeId() {
		return anesthesiaTypeId;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setFirstHourPrice(Double firstHourPrice) {
		this.firstHourPrice = firstHourPrice;
	}

	public Double getFirstHourPrice() {
		return firstHourPrice;
	}

	public void setExtraHourPrice(Double extraHourPrice) {
		this.extraHourPrice = extraHourPrice;
	}

	public Double getExtraHourPrice() {
		return extraHourPrice;
	}
}