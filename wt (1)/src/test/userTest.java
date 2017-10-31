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
	 //使用类加载器加载mybatis的配置文件（它也加载关联的映射文件）

	String resource="cfg.xml";
	 InputStream is = userTest.class.getClassLoader().getResourceAsStream(resource);
	 //构建sqlSession的工厂

	 SqlSessionFactory sessionFactory = new SqlSessionFactoryBuilder().build(is);
	//使用MyBatis提供的Resources类加载mybatis的配置文件（它也加载关联的映射文件）
     //Reader reader = Resources.getResourceAsReader(resource); 
     //构建sqlSession的工厂
     //SqlSessionFactory sessionFactory = new SqlSessionFactoryBuilder().build(reader);
     //创建能执行映射文件中sql的sqlSession
   //  SqlSession session = sessionFactory.openSession();
    // String statement = "mapper.userMapper.getUser";//映射sql的标识字符串
    /// user user = session.selectOne(statement, 1);
     //System.out.println(user);
	 String filepath=System.getProperty("catalina.home")+"\\bin\\"+"uploadDir1/";
	 File file=new File(filepath);

}
}
