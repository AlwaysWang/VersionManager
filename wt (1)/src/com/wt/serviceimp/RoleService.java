package com.wt.serviceimp;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wt.basedao.functionDao;
import com.wt.basedao.roleDao;
import com.wt.bean.Module;
import com.wt.bean.Role;
@Transactional
@Service("roleService")
public class RoleService {
	String resource="cfg.xml";
	 InputStream is = RoleService.class.getClassLoader().getResourceAsStream(resource);
	 SqlSessionFactory sessionFactory = new SqlSessionFactoryBuilder().build(is);
	 SqlSession session = sessionFactory.openSession();
	roleDao roledao=session.getMapper(roleDao.class);
	public List<Role> getRoleList(){
		return roledao.getRoleList();
	}
	public String insertRole(Role role){
				roledao.insertRole(role);
				session.commit();
				return null;
	}
	public Role getNewRole(){
		return roledao.getNewRole();
	}
	public Role getModuleListByRoleId(long roleId){
		return roledao.getModuleListByRoleId(roleId);
	}
	public Role getRoleByRoleName(String roleName){
		return roledao.getRoleByRoleName(roleName);
	}
	public Role getRoleByRoleId(long roleId){
		return roledao.getRoleByRoleId(roleId);
	}

}
