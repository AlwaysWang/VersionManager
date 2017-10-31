package com.wt.bean;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class Program {
private long id;
private String pgName;
private String pgEdition;
private String storagePath;
private String remark;
private List<FunctionModule>funList;
private List<InstallVersion> versionList;
private TestType testType;
private List<TestCode> testCode;
private String progdisc;
private String languageType;
private String systemType;
private Date istDate;
private Date istDateFormat;
private String nowDate;
private static SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//private static SimpleDateFormat df1 = new SimpleDateFormat("yyyy-MM-dd");
public String getIstDateFormat(){
if(null != this.istDate)
{
return df.format(this.istDate);
}
return null;
}

public String getNowDate() {
	Date date=new Date();	
	return df.format(date);
}
public Date getIstDate() {
	return istDate;
}
public void setIstDate(Date istDate) {
	this.istDate = istDate;
}
public String getProgdisc() {
	return progdisc;
}
public void setProgdisc(String progdisc) {
	this.progdisc = progdisc;
}
public String getLanguageType() {
	return languageType;
}
public void setLanguageType(String languageType) {
	this.languageType = languageType;
}
public String getSystemType() {
	return systemType;
}
public void setSystemType(String systemType) {
	this.systemType = systemType;
}
public List<TestCode> getTestCode() {
	return testCode;
}
public void setTestCode(List<TestCode> testCode) {
	this.testCode = testCode;
}
public List<InstallVersion> getVersionList() {
	return versionList;
}
public void setVersionList(List<InstallVersion> versionList) {
	this.versionList = versionList;
}
public TestType getTestType() {
	return testType;
}
public void setTestType(TestType testType) {
	this.testType = testType;
}
public List<FunctionModule> getFunList() {
	return funList;
}
public void setFunList(List<FunctionModule> funList) {
	this.funList = funList;
}
public long getId() {
	return id;
}
public void setId(long id) {
	this.id = id;
}
public String getPgName() {
	return pgName;
}
public void setPgName(String pgName) {
	this.pgName = pgName;
}
public String getPgEdition() {
	return pgEdition;
}
public void setPgEdition(String pgEdition) {
	this.pgEdition = pgEdition;
}
public String getStoragePath() {
	return storagePath;
}
public void setStoragePath(String storagePath) {
	this.storagePath = storagePath;
}
public String getRemark() {
	return remark;
}
public void setRemark(String remark) {
	this.remark = remark;
}


}
