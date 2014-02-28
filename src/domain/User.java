package domain;

import java.sql.Date;

public class User {
	
	private long id;
	private String name;
	private String lastname;
	private String cedula;
	private int departmentId;
	private String department;
	private String userName;
	private String password;
	private Date birthDate;
	private String gender;
	private String dir;
	private String email;
	private String[] numbers;
	private Date admissionDate;
	private String charge;
	private String salary;
	
	
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

	public void setLastname(String lastname){
		this.lastname = lastname;
	}
	
	public String getLastname(){
		return lastname;
	}

	public void setCedula(String cedula){
		this.cedula = cedula;
	}
	
	public String getCedula(){
		return cedula;
	}
	
	public void setDepartamntId(int departamentId){
		this.departmentId = departamentId;
	}
	
	public int getDepartamntId(){
		return departmentId;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}

	public String getPassword() {
		return password;
	}
	
	public void setDepartment(String department) {
		this.department = department;
	}

	public String getDepartment() {
		return department;
	}
	
	public void setBirthDate(Date birthdate) {
		this.birthDate = birthdate;
	}

	public Date getBirthDate() {
		return birthDate;
	}
	
	
	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getGender() {
		return gender;
	}
	
	public void setDir(String dir) {
		this.dir = dir;
	}

	public String getDir() {
		return dir;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}

	public String getEmail() {
		return email;
	}
	
	public void setCharge(String charge) {
		this.charge = charge;
	}

	public String getCharge() {
		return charge;
	}
	
	public void setSalary(String salary) {
		this.salary = salary;
	}

	public String getSalary() {
		return salary;
	}
	
	public void setNumbers(String[] numbers) {
		this.numbers = numbers;
	}

	public String[] getNumber() {
		return numbers;
	}
	
	public void setAdmissionDate(Date admissionDate) {
		this.admissionDate = admissionDate;
	}

	public Date getAdmissionDate() {
		return admissionDate;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserName() {
		return userName;
	}
}
