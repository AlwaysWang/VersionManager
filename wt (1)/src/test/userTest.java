package test;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import com.wt.bean.user;
public class userTest {
public static void main(String[] args) throws IOException {
	 //ʹ�������������mybatis�������ļ�����Ҳ���ع�����ӳ���ļ���

	String resource="cfg.xml";
	 InputStream is = userTest.class.getClassLoader().getResourceAsStream(resource);
	 //����sqlSession�Ĺ���

	 SqlSessionFactory sessionFactory = new SqlSessionFactoryBuilder().build(is);
	//ʹ��MyBatis�ṩ��Resources�����mybatis�������ļ�����Ҳ���ع�����ӳ���ļ���
     //Reader reader = Resources.getResourceAsReader(resource); 
     //����sqlSession�Ĺ���
     //SqlSessionFactory sessionFactory = new SqlSessionFactoryBuilder().build(reader);
     //������ִ��ӳ���ļ���sql��sqlSession
   //  SqlSession session = sessionFactory.openSession();
    // String statement = "mapper.userMapper.getUser";//ӳ��sql�ı�ʶ�ַ���
    /// user user = session.selectOne(statement, 1);
     //System.out.println(user);
	 String filepath=System.getProperty("catalina.home")+"\\bin\\"+"uploadDir1/";
	 File file=new File(filepath);

}
}
