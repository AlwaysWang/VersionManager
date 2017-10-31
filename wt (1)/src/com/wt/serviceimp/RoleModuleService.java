package com.wt.serviceimp;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Service;

import com.wt.basedao.roleModuleDao;
import com.wt.bean.Module;
import com.wt.bean.RoleModule;

@Service("RoleModuleService")
public class RoleModuleService {
	String resource="cfg.xml";
	 InputStream is = InstallVersionService.class.getClassLoader().getResourceAsStream(resource);
	 SqlSessionFactory sessionFactory = new SqlSessionFactoryBuilder().build(is);
	 SqlSession session = sessionFactory.openSession();
	 roleModuleDao roleModuleDao=session.getMapper(roleModuleDao.class); 
	 public int insertRoleModule(RoleModule roleModule){
		 return  roleModuleDao.insertRoleModule(roleModule);
	 }
	 public List<Module> getModuleListByUserType(String userType){
		 return  roleModuleDao.getModuleListByUserType(userType);
	 }
	  

}
