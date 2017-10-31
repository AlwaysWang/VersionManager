package com.wt.serviceimp;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Service;

import com.wt.basedao.moduleDao;
import com.wt.bean.Module;
@Service("moduleService")
public class ModuleService {
	 String resource="cfg.xml";
	 InputStream is = InstallVersionService.class.getClassLoader().getResourceAsStream(resource);
	 SqlSessionFactory sessionFactory = new SqlSessionFactoryBuilder().build(is);
	 SqlSession session = sessionFactory.openSession();
	 moduleDao moduleDao=session.getMapper(moduleDao.class);
	 public List<Module> getModuleList(){
		 return moduleDao.getModuleList();
	 }
	public List<Module> getModuleListByUserType(String userType){
		return moduleDao.getModuleListByUserType(userType);
	}
}
