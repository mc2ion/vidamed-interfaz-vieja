package domain;

public class Protocol {

	private Long protocolID;
	private String name;
	private String description;
	
	public Long getProtocolID() {
		return protocolID;
	}

	public void setProtocolID(Long protocolID) {
		this.protocolID = protocolID;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDescription() {
		return description;
	}
}
