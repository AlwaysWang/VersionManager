package com.wt.bean;

import java.util.Date;

public class RoleModule {
private long roleId;
private String mdId;
private String  remark;
private Date istDate;
public long getRoleId() {
	return roleId;
}
public void setRoleId(long roleId) {
	this.roleId = roleId;
}
public String getMdId() {
	return mdId;
}
public void setMdId(String mdId) {
	this.mdId = mdId;
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
