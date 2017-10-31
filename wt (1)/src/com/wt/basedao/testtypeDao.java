package com.wt.basedao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.wt.bean.FunctionModule;
import com.wt.bean.TestType;
@Repository
public interface testtypeDao {
 
 public List<TestType> getTestTypeList(String typeName);
 public List<TestType> getTestTypeAllList();
 public int insertTestType(TestType testType);
 public int updateTestType(TestType testType,@Param("typeId")long typeId,@Param("typeName")String typeName,@Param("remark")String remark,@Param("nowDate")String nowDate);
 public TestType getTestType(long typeId);
 public List<TestType> getSomeTestTypeList(@Param("testTypeName")String testTypeName,@Param("startDate")String startDate,@Param("endDate")String endDate);
 public List<TestType> getTestTypeByCriteria(@Param("StartPos")int startPos,@Param("EndPos")int endPos);
 public List<TestType> getSomeTestTypeByCriteria(@Param("testTypeName")String testTypeName,@Param("startDate")String startDate,@Param("endDate")String endDate,@Param("StartPos")int startPos,@Param("EndPos")int endPos);
 public int deleteTestTypeById(long testTypeId);
  
 
}
