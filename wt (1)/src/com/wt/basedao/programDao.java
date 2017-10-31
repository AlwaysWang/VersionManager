package com.wt.basedao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.wt.bean.Program;

@Repository
public interface programDao {
public List<Program> getProgramByProgramNameAndTestCode(@Param("pgName")String programName,@Param("testCode")long  testCode);
public List<Program> getAllProgramList();
public int insertProgram(Program program);
public List<Program> getProgramList();
//public List<Program>getSomeProgramList(@Param("startDate")String startDate,@Param("endDate")String endDate,@Param("pgName")String programName,@Param("testCode")String  testCode);
public List<Program>getSomeProgramList(@Param("startDate")String startDate,@Param("endDate")String endDate,@Param("pgName")String programName);
public Program getProgramById(@Param("pId")long id);
public int updateProgram(Program program,@Param("pId")long id,@Param("pgName")String pgName,@Param("languageType") String languageType,@Param("systemType")String systemType,@Param("pgEdition") String pgEdition,@Param("progdisc") String progdisc,@Param("storagePath")String storagePath,@Param("remark")String remark);
public List<Program> getProgramListByCriteria(@Param("StartPos")int startPos,@Param("EndPos")int endPos);
//public List<Program> getSomeProgramListByCriteria(@Param("startDate")String startDate,@Param("endDate")String endDate,@Param("pgName")String programName,@Param("testCode")String  testCode,@Param("StartPos")int startPos,@Param("EndPos")int endPos);
public List<Program> getSomeProgramListByCriteria(@Param("startDate")String startDate,@Param("endDate")String endDate,@Param("pgName")String programName,@Param("StartPos")int startPos,@Param("EndPos")int endPos);
public int deleteProgramById(long pgId);


} 
