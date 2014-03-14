package domain;

public class Permission {
	
	private Long permissionID;
	private Long permissionModuleID;
	private String name;
	
	public Long getPermissionID() {
		return permissionID;
	}
	
	public void setPermissionID(Long permissionID) {
		this.permissionID = permissionID;
	}
	
	public Long getPermissionModuleID() {
		return permissionModuleID;
	}
	
	public void setPermissionModuleID(Long permissionModuleID) {
		this.permissionModuleID = permissionModuleID;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
}
