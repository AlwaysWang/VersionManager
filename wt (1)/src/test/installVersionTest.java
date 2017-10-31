package test;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.wt.basedao.programDao;
import com.wt.bean.FunctionModule;
import com.wt.bean.Program;

public class installVersionTest {
public static void main(String[] args) {
	String resource="cfg.xml";
	 InputStream is = installVersionTest.class.getClassLoader().getResourceAsStream(resource);
	 SqlSessionFactory sessionFactory = new SqlSessionFactoryBuilder().build(is);
	 SqlSession session = sessionFactory.openSession();
	 programDao programDao=session.getMapper(com.wt.basedao.programDao.class);
	 List<Program>programList=programDao.getProgramByProgramNameAndTestCode("³ÌÐò1", 401);
}
}
