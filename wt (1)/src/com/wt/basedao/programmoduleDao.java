package com.wt.basedao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.wt.bean.ProgramModule;

@Repository
public interface programmoduleDao {
public int insertProgramModule(ProgramModule programModule);
public List<ProgramModule> getProgramModuleListByMdId(@Param("mdId")long mdId);
public int updateProgramModule(@Param("pgId")long pgId, @Param("funId") long funId);
public int deleteProgramModuleByFunId(@Param("funId")long funId);
public int deleteProgramModuleByPgId(long pgId);
public List<ProgramModule> getProgramModuleListByPgId(long pgId);
}
