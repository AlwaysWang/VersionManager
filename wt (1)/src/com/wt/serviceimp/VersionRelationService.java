package com.wt.serviceimp;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Service;
import com.wt.basedao.versionrelationDao;
import com.wt.bean.VersionRelation;
@Service("versionrelationService")
public class VersionRelationService {
	String resource="cfg.xml";
	 InputStream is = InstallVersionService.class.getClassLoader().getResourceAsStream(resource);
	 SqlSessionFactory sessionFactory = new SqlSessionFactoryBuilder().build(is);
	 SqlSession session = sessionFactory.openSession();
	 versionrelationDao versionrelationDao=session.getMapper(versionrelationDao.class);
	 public String insertVersionRelationDao(VersionRelation versionrelation){
		 versionrelationDao.insertVersionRelation(versionrelation);
		 session.commit();
		 return null;
	 }
	 public List<VersionRelation> getversionrelationByVId(long vId){
		 return versionrelationDao.getversionrelationByVId(vId);
	 }
	 public String deleteVersionRelationByVId(long vId){
		 versionrelationDao.deleteVersionRelationByVId(vId);
		 session.commit();
		 return null;
	 }
public String deleteVersionRelationByFunId(long funId){
	versionrelationDao.deleteVersionRelationByFunId(funId);
	session.commit();
	return null;
	
}
public List<VersionRelation>getversionrelationByFId(long FunId){
	return versionrelationDao.getversionrelationByFId(FunId);
}
}
