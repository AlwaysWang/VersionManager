package com.wt.bean;

import java.util.Date;
import java.util.List;

public class Module {
private String mdId;
private String mdName;
private int state;
private int isMenu;
private String parent;
private String url;
private Date istDate;
private Date uptDate;
private List<Role> roleList;
public Module() {
	super();
}
public List<Role> getRoleList() {
	return roleList;
}
public void setRoleList(List<Role> roleList) {
	this.roleList = roleList;
}
public String getMdId() {
	return mdId;
}
public void setMdId(String mdId) {
	this.mdId = mdId;
}
public String getMdName() {
	return mdName;
}
public void setMdName(String mdName) {
	this.mdName = mdName;
}
public int getState() {
	return state;
}
public void setState(int state) {
	this.state = state;
}
public int getIsMenu() {
	return isMenu;
}
public void setIsMenu(int isMenu) {
	this.isMenu = isMenu;
}
public String getParent() {
	return parent;
}
public void setParent(String parent) {
	this.parent = parent;
}
public String getUrl() {
	return url;
}
public void setUrl(String url) {
	this.url = url;
}
public Date getIstDate() {
	return istDate;
}
public void setIstDate(Date istDate) {
	this.istDate = istDate;
}
public Date getUptDate() {
	return uptDate;
}
public void setUptDate(Date uptDate) {
	this.uptDate = uptDate;
}


}
