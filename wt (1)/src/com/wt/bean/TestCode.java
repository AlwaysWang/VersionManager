package com.wt.bean;

import java.text.SimpleDateFormat;
import java.util.Date;

public class TestCode {
private  long id;
private  long code;
private String testName;
private int state;
private Date istDate;
private Date uptDate;
private String remark;
private long typeId;
private TestType testType;
private String nowDate;
private static SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
public void setNowDate(String nowDate){
	this.nowDate=nowDate;
}
public String getNowDate() {
	Date date=new Date();	
	return df.format(date);
}
public TestType getTestType() {
	return testType;
}
public void setTestType(TestType testType) {
	this.testType = testType;
}
public long getId() {
	return id;
}
public void setId(long id) {
	this.id = id;
}
public long getCode() {
	return code;
}
public void setCode(long code) {
	this.code = code;
}
public String getTestName() {
	return testName;
}
public void setTestName(String testName) {
	this.testName = testName;
}
public int getState() {
	return state;
}
public void setState(int state) {
	this.state = state;
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
public String getRemark() {
	return remark;
}
public void setRemark(String remark) {
	this.remark = remark;
}
public long getTypeId() {
	return typeId;
}
public void setTypeId(long typeId) {
	this.typeId = typeId;
}
public TestCode(long id, long code, String testName, int state, Date istDate,
		Date uptDate, String remark, long typeId) {
	super();
	this.id = id;
	this.code = code;
	this.testName = testName;
	this.state = state;
	this.istDate = istDate;
	this.uptDate = uptDate;
	this.remark = remark;
	this.typeId = typeId;
}
public TestCode() {
	super();
}


 
}
