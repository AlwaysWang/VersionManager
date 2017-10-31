package com.wt.serviceimp;
import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wt.basedao.testtypeDao;
import com.wt.bean.TestType;
@Service("testTypeService")
@Transactional
public class TestTypeService {
	String resource="cfg.xml";
	 InputStream is = TestTypeService.class.getClassLoader().getResourceAsStream(resource);
	 SqlSessionFactory sessionFactory = new SqlSessionFactoryBuilder().build(is);
	 SqlSession session = sessionFactory.openSession();
	 testtypeDao testTypeDao=session.getMapper(testtypeDao.class);
	 public List<TestType> getTestTypeList(String typeName){
		 return testTypeDao.getTestTypeList(typeName);
	 }
	 public List<TestType> getTestTypeAllList(){
		 return testTypeDao.getTestTypeAllList();
	 }
	 public String insertTestType(TestType testType){
		 testTypeDao.insertTestType(testType);
		 session.commit();
		 return null;
	 }
	 public List<TestType>getSomeTestType(String testTypeName,String startDate,String endDate){
		 return testTypeDao.getSomeTestTypeList(testTypeName, startDate, endDate);
	 }
	 public TestType getTestType(long typeId){
		 return testTypeDao.getTestType(typeId);
	 }
	 public String updateTestType(TestType testType,long typeId,String typeName,String remark,String nowDate){
		 testTypeDao.updateTestType(testType,typeId, typeName, remark,nowDate);
		 session.commit();
		 return null;
		 }
	 public List<TestType> getTestTypeByCriteria(int startPos,int endPos){
		 return testTypeDao.getTestTypeByCriteria(startPos, endPos);
	 }
	 public List<TestType> getSomeTestTypeByCriteria(String testTypeName,String startDate,String endDate,int startPos,int endPos){
		 return testTypeDao.getSomeTestTypeByCriteria(testTypeName, startDate, endDate, startPos, endPos);
	 }
	 public String deleteTestTypeById(long testTypeId){
		 testTypeDao.deleteTestTypeById(testTypeId);
		 session.commit();
		 return null;
	 }
 }
