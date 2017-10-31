package com.wt.bean;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class InstallVersion {
	private String pgdownload;
	private String edit;
	private String delete;
public String getPgdownload() {
		return pgdownload;
	}

	public void setPgdownload(String pgdownload) {
		this.pgdownload = pgdownload;
	}

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
private String verName;
public String getVerName() {
	return verName;
}

public void setVerName(String verName) {
	this.verName = verName;
}
private long id;
private String verCode;
private long mdId;
private String remark;
private String operName;
private String savePath;
private Date istDate;
private FunctionModule functionmodule;
private TestType testtype;
private Program program;
private TestType testType;
private TestCode testCode;
private String nowDate;
private Date istDateFormat;
public String getIstDateFormat(){
if(null != this.istDate)
{
return df.format(this.istDate);
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

public TestCode getTestCode() {
	return testCode;
}
public void setTestCode(TestCode testCode) {
	this.testCode = testCode;
}
public TestType getTestType() {
	return testType;
}
public void setTestType(TestType testType) {
	this.testType = testType;
}
public Program getProgram() {
	return program;
}
public void setProgram(Program program) {
	this.program = program;
}
public TestType getTesttype() {
	return testtype;
}
public void setTesttype(TestType testtype) {
	this.testtype = testtype;
}
public FunctionModule getFunctionmodule() {
	return functionmodule;
}
public void setFunctionmodule(FunctionModule functionmodule) {
	this.functionmodule = functionmodule;
}
public long getMdId() {
	return mdId;
}
public void setMdId(long mdId) {
	this.mdId = mdId;
}
public long getId() {
	return id;
}
public void setId(long id) {
	this.id = id;
}
public String getVerCode() {
	return verCode;
}
public void setVerCode(String verCode) {
	this.verCode = verCode;
}
public long getPsId() {
	return mdId;
}
public void setPsId(long psId) {
	this.mdId = psId;
}
public String getRemark() {
	return remark;
}
public void setRemark(String remark) {
	this.remark = remark;
}
public String getOperName() {
	return operName;
}
public void setOperName(String operName) {
	this.operName = operName;
}
public String getSavePath() {
	return savePath;
}
public void setSavePath(String savePath) {
	this.savePath = savePath;
}
public Date getIstDate() {
	return istDate;
}
public void setIstDate(Date istDate) {
	this.istDate = istDate;
}


}
