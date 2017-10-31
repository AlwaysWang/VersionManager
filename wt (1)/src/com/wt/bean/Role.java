package com.wt.bean;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class Role {
private long roleId;
private String roleName;
private int state;
private String remark;
private Date istDate;
private String nowDate;
private List<Module> moduleList;
public String setNowDate(String nowDate) {
	return nowDate;
}
private static SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
public String getNowDate() {
	Date date=new Date();	
	return df.format(date);
}

public List<Module> getModuleList() {
	return moduleList;
}
public void setModuleList(List<Module> moduleList) {
	this.moduleList = moduleList;
}
public long getRoleId() {
	return roleId;
}
public void setRoleId(long roleId) {
	this.roleId = roleId;
}
public String getRoleName() {
	return roleName;
}
public void setRoleName(String roleName) {
	this.roleName = roleName;
}
public int getState() {
	return state;
}
public void setState(int state) {
	this.state = state;
}
public String getRemark() {
	return remark;
}
public void setRemark(String remark) {
	this.remark = remark;
}
public Date getIstDate() {
	return istDate;
}
public void setIstDate(Date istDate) {
	this.istDate = istDate;
}

}
