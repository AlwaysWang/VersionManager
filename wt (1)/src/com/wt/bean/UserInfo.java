package com.wt.bean;

import java.text.SimpleDateFormat;
import java.util.Date;

public class UserInfo {
private long id;
private String userName;
private String loginName;
private String loginpass;
private String nowDate;
private static SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
public String getNowDate() {
	Date date=new Date();	
	return df.format(date);
}
public String getLoginpass() {
	return loginpass;
}
public void setLoginpass(String loginpass) {
	this.loginpass = loginpass;
}
private Date istDate;
public long getId() {
	return id;
}
public void setId(long id) {
	this.id = id;
}
public String getUserName() {
	return userName;
}
public void setUserName(String userName) {
	this.userName = userName;
}
public String getLoginName() {
	return loginName;
}
public void setLoginName(String loginName) {
	this.loginName = loginName;
}

public Date getIstDate() {
	return istDate;
}
public void setIstDate(Date istDate) {
	this.istDate = istDate;
}

}
