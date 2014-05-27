package domain;

import java.io.Serializable;

public class UserPermission implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Long userID;
	private Long permissionID;
	
	public Long getUserID() {
		return userID;
	}
	
	public void setUserID(Long userID) {
		this.userID = userID;
	}
	
	public Long getPermissionID() {
		return permissionID;
	}
	
	public void setPermissionID(Long permissionID) {
		this.permissionID = permissionID;
	}
	
}
