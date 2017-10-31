package com.wt.bean;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class TestType {
private long typeId;
private String typeName;
private String remark;
private Date istDate;
private Date uptDate;
private List<FunctionModule>funlist;
private List<Program>programlist;
private String nowDate;
private static SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
public void setNowDate(String nowDate){
	this.nowDate=nowDate;
}
public String getNowDate() {
	Date date=new Date();	
	return df.format(date);
}
public List<Program> getProgramlist() {
	return programlist;
}
public void setProgramlist(List<Program> programlist) {
	this.programlist = programlist;
}
public List<FunctionModule> getFunlist() {
	return funlist;
}
public void setFunlist(List<FunctionModule> funlist) {
	this.funlist = funlist;
}
public long getTypeId() {
	return typeId;
}
public void setTypeId(long typeId) {
	this.typeId = typeId;
}
public String getTypeName(){
	return typeName;
}
public void setTypeName(String typeName) {
	this.typeName = typeName;
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
public Date getUptDate() {
	return uptDate;
}
public void setUptDate(Date uptDate) {
	this.uptDate = uptDate;
}

}
