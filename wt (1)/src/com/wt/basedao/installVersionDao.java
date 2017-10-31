package com.wt.basedao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.wt.bean.InstallVersion;
@Repository
public interface installVersionDao {
public List<InstallVersion> getInstallVersionList();
public int insertInstallVersion(InstallVersion version);
public int updateInstallVersion(InstallVersion version,@Param("verCode")String verCode,@Param("verName")String verName,@Param("remark")String remark,@Param("operName")String operName,@Param("savePath")String savePath,@Param("Id")long id);
public List<InstallVersion> getSomeInstallVersionList(@Param("startDate")String startDate,@Param("endDate")String endDate,@Param("typeName")String typeName,@Param("testName")String testName);
public  InstallVersion getVersion(@Param("verCode")String verCode);
public List<InstallVersion>getAllVersion();
public InstallVersion getVersionById(@Param("Id")long id);
public List<InstallVersion> getSomeInstallVersionListByCriteria(@Param("startDate")String startDate,@Param("endDate")String endDate,@Param("typeName")String typeName,@Param("testName")String testName,@Param("StartPos")int startPos,@Param("Endpos")int pageSize);
public List<InstallVersion>  getInstallVersionListByCriteria(@Param("StartPos")int startPos,@Param("Endpos")int pageSize);
public List<InstallVersion> getVersionListByTestTypeByCriteria(@Param("typeName")String typeName,@Param("testName")String testName,@Param("StartPos")int startPos,@Param("Endpos")int endPos);
public List<InstallVersion> getAllVersionByCriteria(@Param("StartPos")int startPos,@Param("Endpos")int endPos);
public InstallVersion getVersionByMaxId();
public int getListCount();
public int deleteInstallVersionById(long VId);
}
