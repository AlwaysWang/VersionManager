package com.wt.bean;

import java.text.SimpleDateFormat;
import java.util.Date;

public class ProgramModule {
private long id;
private long pdId;
private long mdId;
private String remark;
private Date istDate;
private String nowDate;
private static SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
public String getNowDate() {
	Date date=new Date();	
	return df.format(date);
}
public long getId() {
	return id;
}
public void setId(long id) {
	this.id = id;
}
public long getPdId() {
	return pdId;
}
public void setPdId(long pdId) {
	this.pdId = pdId;
}
public long getMdId() {
	return mdId;
}
public void setMdId(long mdId) {
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
