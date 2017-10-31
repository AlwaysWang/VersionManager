package com.wt.basedao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.wt.bean.Module;

@Repository
public interface moduleDao {
public List<Module> getModuleList();
public List<Module> getModuleListByUserType(@Param("userType")String userType);

}
