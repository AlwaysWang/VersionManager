package com.wt.basedao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSessionFactory;
//import org.junit.runners.Parameterized.Parameters;
//import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.wt.bean.UserInfo;

@Repository
public interface userinfoDao {
@Resource(name = "sqlSessionFactory") 
 public List<UserInfo> getUserInfoList();
 public int insertUserInfo(UserInfo user);
 public UserInfo selectUserInfo(@Param("userName")String userName);
 public List<UserInfo>getUserInfoByName(@Param("userName")String userName);
 public  int updatePass(UserInfo user,@Param("loginPass")String loginPass,@Param("loginName")String loginName);
 public UserInfo getUserByLoginName(@Param("loginName")String loginName);
 public UserInfo getUserInfoById(@Param("id")long id);
 public int updateUser(UserInfo user,@Param("id") long id,@Param("userName")String userName,@Param("loginName")String loginName,@Param("loginPass")String loginPass);
 public List<UserInfo> getUserListByCriteria(@Param("StartPos")int startPos,@Param("EndPos")int endPos);
 public List<UserInfo> getSomeUserListByCriteria(@Param("userName")String userName,@Param("StartPos")int startPos,@Param("EndPos")int endPos);
  
 
}
