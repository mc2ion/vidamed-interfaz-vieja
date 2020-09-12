package domain;

import java.text.NumberFormat;
import java.util.Locale;

public class ExchangeRate {
	
	public static Locale spanish = new Locale("es","ES");
	public static NumberFormat format = NumberFormat.getNumberInstance(spanish);
	
	private Long exchangeRateID;
	private String value;
	private String createdDate;
	private Long createUserID;
	private String createdUserName;
	
	public Long getExchangeRateID() {
		return exchangeRateID;
	}
	
	public void setExchangeRateID(Long exchangeRateID) {
		this.exchangeRateID = exchangeRateID;
	}

	public String getValue() {
		return value;
	}
	
	public void setValue(String str, Double value) {
		if(str!=null){
			this.value = Estimation.format.format(value);
		} else {
			this.value = null;
		}
	}

	public String getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}

	public Long getCreateUserID() {
		return createUserID;
	}

	public void setCreateUserID(Long createUserID) {
		this.createUserID = createUserID;
	}

	public String getCreatedUserName() {
		return createdUserName;
	}

	public void setCreatedUserName(String createdUserName) {
		this.createdUserName = createdUserName;
	}
}
