package com.wt.basedao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.wt.bean.Module;
import com.wt.bean.RoleModule;

@Repository
public interface roleModuleDao {
public int insertRoleModule(RoleModule roleModule);
public List<Module> getModuleListByUserType(@Param("userType")String userType);
}
