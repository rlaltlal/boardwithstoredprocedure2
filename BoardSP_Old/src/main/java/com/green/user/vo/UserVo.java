package com.green.user.vo;

public class UserVo {

	// Fields
	private    String    userid;
	private    String    userpass;
	private    String    username;
	private    int       userpoint;
	
	// Constructor
	public UserVo() {}
	
	public UserVo(String userid, String userpass, String username, int userpoint) {
		this.userid = userid;
		this.userpass = userpass;
		this.username = username;
		this.userpoint = userpoint;
	}
	
	// Getter / Setter 
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUserpass() {
		return userpass;
	}
	public void setUserpass(String userpass) {
		this.userpass = userpass;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public int getUserpoint() {
		return userpoint;
	}
	public void setUserpoint(int userpoint) {
		this.userpoint = userpoint;
	}
	
	// toString
	@Override
	public String toString() {
		return "UserVo [userid=" + userid + ", userpass=" + userpass + ", username=" + username + ", userpoint="
				+ userpoint + "]";
	}
	
	
}
