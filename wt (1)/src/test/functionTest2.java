package test;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.log4j.chainsaw.Main;
//import org.junit.Test;

import com.wt.basedao.functionDao;
import com.wt.basedao.installVersionDao;
import com.wt.basedao.moduleDao;
import com.wt.basedao.newsDao;
import com.wt.basedao.programDao;
import com.wt.basedao.roleDao;
import com.wt.basedao.testtypeDao;
import com.wt.basedao.userinfoDao;
import com.wt.bean.FunctionModule;
import com.wt.bean.InstallVersion;
import com.wt.bean.Module;
import com.wt.bean.News;
import com.wt.bean.Program;
import com.wt.bean.Role;
import com.wt.bean.TestType;
import com.wt.bean.UserInfo;

public class functionTest2 {
	public static void main(String[] args) {
		
	String resource="cfg.xml";
	 InputStream is = functionTest2.class.getClassLoader().getResourceAsStream(resource);
	 SqlSessionFactory sessionFactory = new SqlSessionFactoryBuilder().build(is);
	 SqlSession session = sessionFactory.openSession();
	 testtypeDao testTypeDao=session.getMapper(testtypeDao.class);
	 functionDao fundao=session.getMapper(functionDao.class);
	 programDao programDao=session.getMapper(com.wt.basedao.programDao.class);
	 installVersionDao indao=session.getMapper(com.wt.basedao.installVersionDao.class);
	 roleDao roleDao=session.getMapper(com.wt.basedao.roleDao.class);
	 newsDao newsDao=session.getMapper(com.wt.basedao.newsDao.class);
	 userinfoDao  userdao=session.getMapper(com.wt.basedao.userinfoDao.class);
	 UserInfo user=userdao.getUserByLoginName("Tom");
	 moduleDao moduleDao=session.getMapper(com.wt.basedao.moduleDao.class);
	 List list=moduleDao.getModuleListByUserType("��������Ա");
	 com.wt.basedao.userinfoDao userinfoDao=session.getMapper(com.wt.basedao.userinfoDao.class);
	 UserInfo user1=new UserInfo();
	 List<UserInfo> userList=userinfoDao.getUserInfoList();
	 //System.out.println(userList.size());
	// user1.setLoginName("����");
	// user1.setLoginpass("123456");
	 //user1.setUserName("С��");
	// userdao.insertUserInfo(user1);
	 //System.out.println(userdao.insertUserInfo(user1));
	 List<UserInfo> userList1=userinfoDao.getUserInfoList();
	// System.out.println(userList1.size());
	 //System.out.println(userList1.get(6).getLoginName());
	// System.out.println(userList1.get(6).getId());
	 InstallVersion version=indao.getVersionByMaxId();
	 //System.out.println(version.getId());
	 List<News> list1=newsDao.getNewsListByMaxDate();
	for (News news : list1) {
		//System.out.println(news.getContent());
	}
	List list22=new ArrayList();
	list22.add(1);
	list22.add(2);
	 long i2=Long.valueOf((String)list22.get(1));
	 System.out.println(i2);
	
	}

	}

	 