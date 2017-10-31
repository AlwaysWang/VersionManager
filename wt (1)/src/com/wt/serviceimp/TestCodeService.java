package com.wt.serviceimp;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Service;
import com.wt.basedao.testcodeDao;
import com.wt.bean.TestCode;

@Service("testCodeService")
public class TestCodeService {
	 String resource="cfg.xml";
	 InputStream is = FunctionService.class.getClassLoader().getResourceAsStream(resource);
	 SqlSessionFactory sessionFactory = new SqlSessionFactoryBuilder().build(is);
	 SqlSession session = sessionFactory.openSession();
	 testcodeDao codeDao=session.getMapper(testcodeDao.class);
	 
public List<TestCode> getTestCodeList(){
	return codeDao.getTestCodeList();
}
public List<TestCode> getTestCodeListByTypeName(String testTypeName){
	return codeDao.getTestCodeListByTypeName(testTypeName);
}
public  String  insertTestCode(TestCode testCode){
	 codeDao.insertTestCode(testCode);
	 session.commit();
	 return  null;
}
public TestCode getTestCodeById(long testcode){
	return codeDao.getTestCodeById(testcode);
}
}
