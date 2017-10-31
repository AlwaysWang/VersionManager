package com.wt.basedao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.wt.bean.TestCode;
@Repository
public interface testcodeDao {
public List<TestCode> getTestCodeList();
public List<TestCode> getTestCodeListByTypeName(@Param("testTypeName")String testTypeName);
public int insertTestCode(TestCode testCode);
public TestCode getTestCodeById(@Param("testcode")long testcode);
}
