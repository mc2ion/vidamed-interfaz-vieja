package domain;

public class UserPermission {
	
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
