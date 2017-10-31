package com.wt.basedao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.wt.bean.Module;
import com.wt.bean.Role;
import com.wt.bean.UserInfo;
@Repository
public interface roleDao {
public List<UserInfo> getUserInfoListByUserName(String userName);
public UserInfo getUserByUserName(String userName);
public  List<Role> getRoleList();
public int insertRole(Role role);
public Role getNewRole();
public Role getModuleListByRoleId(@Param("roleId")long RoleId);
public Role getRoleByRoleName(@Param("roleName")String roleName);
public Role getRoleByRoleId(@Param("roleId")long roleId);


}
