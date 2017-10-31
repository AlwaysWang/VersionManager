package com.wt.bean;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

public class FunctionModule {
private String edit;
private String delete;
private String pgEdition;
public String getEdit() {
	return edit;
}

public void setEdit(String edit) {
	this.edit = edit;
}

public String getDelete() {
	return delete;
}

public void setDelete(String delete) {
	this.delete = delete;
}

public String getPgEdition() {
	return pgEdition;
}

public void setPgEdition(String pgEdition) {
	this.pgEdition = pgEdition;
}
private long id;
private String name;
private String remark;
private long typeid;
private String debugFile;
private long testCode;
@DateTimeFormat(pattern = "yyyy-MM-dd")
private Date istdate;
private Date uptdate;
private TestType testType;
private String typeName;

public String getTypeName() {
	return typeName;
}

public void setTypeName(String typeName) {
	this.typeName = typeName;
}
private TestCode testcode;
private String nowDate;
private Date istDateFormat;
public String getIstDateFormat(){
if(null != this.istdate)
{
return df.format(this.istdate);
}
return null;
}

public String setNowDate(String nowDate) {
	return nowDate;
}
private static SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
public String getNowDate() {
	Date date=new Date();	
	return df.format(date);
}

public TestCode getTestcode() {
	return testcode;
}
public void setTestcode(TestCode testcode) {
	this.testcode = testcode;
}
private List<Program>programList;
private List<InstallVersion>installversionList;
public List<InstallVersion> getInstallversionList() {
	return installversionList;
}
public void setInstallversionList(List<InstallVersion> installversionList) {
	this.installversionList = installversionList;
}
public List<Program> getProgramList() {
	return programList;
}
public void setProgramList(List<Program> programList) {
	this.programList = programList;
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
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getRemark() {
	return remark;
}
public void setRemark(String remark) {
	this.remark = remark;
}
public long getTypeid() {
	return typeid;
}
public void setTypeid(long typeid) {
	this.typeid = typeid;
}
public String getDebugFile() {
	return debugFile;
}
public void setDebugFile(String debugFile) {
	this.debugFile = debugFile;
}
public long getTestCode() {
	return testCode;
}
public void setTestCode(long testCode) {
	this.testCode = testCode;
}
public Date getIstdate() {
	return istdate;
}
public void setIstdate(Date istdate) {
	this.istdate = istdate;
}
public Date getUptdate() {
	return uptdate;
}
public void setUptdate(Date uptdate) {
	this.uptdate = uptdate;
}
public String toString() {
    return "Function [id=" + id + ", name=" + name + ", Istdate=" + istdate + "]";
}
}
