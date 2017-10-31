package test;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.wt.bean.FunctionModule;

public class functionTest1 {
public static void main(String[] args) {
	String resource="cfg.xml";
	 InputStream is = functionTest.class.getClassLoader().getResourceAsStream(resource);
	 SqlSessionFactory sessionFactory = new SqlSessionFactoryBuilder().build(is);
	 SqlSession session = sessionFactory.openSession();
	 String statement = "com.wt.basedao.functionDao.getFunctionModuleByName1";
	 List<FunctionModule> funlist= session.selectList(statement,"·ÂÕæRNC");
	 System.out.println(funlist.isEmpty());
	 System.out.println(funlist.size());
	
	session.close();
}
}
