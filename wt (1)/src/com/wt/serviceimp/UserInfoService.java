package com.wt.serviceimp;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.wt.basedao.roleDao;
import com.wt.basedao.userinfoDao;
import com.wt.bean.UserInfo;
@Service("userService")
@Transactional
public class UserInfoService {
	 String resource="cfg.xml";
	 InputStream is = UserInfoService.class.getClassLoader().getResourceAsStream(resource);
	 SqlSessionFactory sessionFactory = new SqlSessionFactoryBuilder().build(is);
	 SqlSession  session = sessionFactory.openSession(true);
	 userinfoDao  userInfoDao=session.getMapper(userinfoDao.class);
	 public String insertUserInfo(UserInfo user){
		 
			 //userinfoDao  userInfoDao=session.getMapper(userinfoDao.class);
			   userInfoDao.insertUserInfo(user);
			   session.commit();
			   return null;
		
	 }
	
	
	public List<UserInfo>getUserInfoList(){
		
		
		
		return userInfoDao.getUserInfoList();
	}
	/*public int insertUserInfo(UserInfo user){
		return userInfoDao.insertUserInfo(user);
	}*/
	public UserInfo getUserInfo(String userName){
		return userInfoDao.selectUserInfo(userName);
	}
	public List<UserInfo >getUserInfoListByName(String userName){
		return userInfoDao.getUserInfoByName(userName);
	}
	public String updatePass(UserInfo user,String loginPass,String loginName){
		userInfoDao.updatePass(user, loginPass, loginName);
		session.commit();
		return null;
	}
	public UserInfo  getUserByLoginName(String loginName){
		return userInfoDao.getUserByLoginName(loginName);
	}
	public String update(UserInfo user,long id,String userName,String loginName,String loginPass){
		userInfoDao.updateUser(user, id, userName, loginName, loginPass);
		return "/passwordupdate";
	}
	public UserInfo getUserById(long id){
		return userInfoDao.getUserInfoById(id);
	}
	public List<UserInfo> getUserListByCriteria(int startPos,int endPos){
		return userInfoDao.getUserListByCriteria(startPos, endPos);
		
	}
	public List<UserInfo> getSomeUserListByCriteria(String userName,int startPos,int endPos){
		return userInfoDao.getSomeUserListByCriteria(userName, startPos, endPos);
	}

}
