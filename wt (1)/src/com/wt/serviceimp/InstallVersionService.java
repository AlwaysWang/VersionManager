package com.wt.serviceimp;

import java.io.InputStream;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.ibatis.transaction.Transaction;
import org.apache.ibatis.transaction.TransactionFactory;
import org.apache.ibatis.transaction.jdbc.JdbcTransactionFactory;
import org.springframework.stereotype.Service;

import com.wt.basedao.installVersionDao;
import com.wt.bean.InstallVersion;
@Service("installVersionService")
public class InstallVersionService {
	 String resource="cfg.xml";
	 InputStream is = InstallVersionService.class.getClassLoader().getResourceAsStream(resource);
	 SqlSessionFactory sessionFactory = new SqlSessionFactoryBuilder().build(is);
	 SqlSession session = sessionFactory.openSession();
	  installVersionDao installDao=session.getMapper(installVersionDao.class); 
	  
	
	 public List<InstallVersion>getInstallVersionAllList(){
		 return installDao.getInstallVersionList();
	 }
	 public String insertInstallVersion(InstallVersion version){
		 installDao.insertInstallVersion(version);
		 session.commit();
		 return null;
	 }
	 
	 public List<InstallVersion> getSomeInstallVersionList(String startDate,String endDate,String typeName,String testName){
		 return installDao.getSomeInstallVersionList(startDate, endDate, typeName, testName);
	 }
	 public InstallVersion getVersion(String verCode){
		 return installDao.getVersion(verCode);
	 }
	 public List<InstallVersion>getAllVersion(){
		 return installDao.getAllVersion();
	 }
	 public String  updateVersion(InstallVersion version,String verCode,String verName,String remark,String operName,String savePath,long id){
		  installDao.updateInstallVersion(version,verCode, verName,remark,operName,savePath,id);
		  session.commit();
		  return null;
	 }
	 public InstallVersion getVersionById(long id){
		 return installDao.getVersionById(id);
	 }
	 public List<InstallVersion>getSomeInstallVersionListByCriteria(String startDate,String endDate,String typeName,String testName,int startPos,int pageSize){
		 return installDao.getSomeInstallVersionListByCriteria(startDate, endDate, typeName, testName, startPos, pageSize);
	 }
	 public List<InstallVersion>getInstallVersionListByCriteria(int startPos,int pageSize){
		 return installDao.getInstallVersionListByCriteria(startPos, pageSize);
	 }
	 	public List<InstallVersion> getVersionListByTestTypeByCriteria(String typeName,String testName,int startPos,int endPos){
	 		return installDao.getVersionListByTestTypeByCriteria(typeName, testName, startPos, endPos);
	 	}
	 	public List<InstallVersion>getAllVersionByCriteria(int startPos,int endPos){
	 		return installDao.getAllVersionByCriteria(startPos, endPos);
	 	}
	 	public InstallVersion getVersionByMaxId(){
	 		return installDao.getVersionByMaxId();
	 	}
	 	public String deleteInstallVersionById(long VId){
	 		installDao.deleteInstallVersionById(VId);
	 		session.commit();
	 		return null;
	 	}
}