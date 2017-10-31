package com.wt.bean;

import java.text.SimpleDateFormat;
import java.util.Date;

public class VersionRelation {
private long id;
private long vid;
private long mdid;
private String nowDate;
private static SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
public String getNowDate() {
	Date date=new Date();	
	return df.format(date);
}
public long getId() {
	return id;
}
public long getVid() {
	return vid;
}
public long getMdid() {
	return mdid;
}
public void setId(long id) {
	this.id = id;
}
public void setVid(long vid) {
	this.vid = vid;
}
public void setMdid(long mdid) {
	this.mdid = mdid;
}

}
