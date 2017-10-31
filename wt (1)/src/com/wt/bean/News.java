package com.wt.bean;

import java.text.SimpleDateFormat;
import java.util.Date;

public class News {
private long id;
private String title;
private String name;
private String content;
private String remark;
private Date istDate;
private Date istDateFormat;
private String nowDate;
public String setNowDate(String nowDate) {
	return nowDate;
}
public String getNowDate() {
	Date date=new Date();	
	return df.format(date);
}

public String getTitle() {
	return title;
}
public void setTitle(String title) {
	this.title = title;
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
public String getContent() {
	return content;
}
public void setContent(String content) {
	this.content = content;
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
private static SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
public String getIstDateFormat(){
if(null != this.istDate)
{
return df.format(this.istDate);
}
return null;
}

}
