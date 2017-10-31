package com.wt.basedao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.alibaba.druid.sql.ast.expr.SQLSequenceExpr.Function;
import com.wt.bean.FunctionModule;
@Repository
public interface functionDao {
	public List<FunctionModule> getAllFunList();
	public  List<FunctionModule> getFunctionModuleByName(String name);
	public  List<FunctionModule> getFunctionModuleByNameAndType(@Param("name")String name,@Param("typename")String typename);
	public FunctionModule getFunctionById(int id);
	public  int insertFunction(FunctionModule function);
	public List<FunctionModule> getSomeFunctionList(@Param("startDate")String startDate,@Param("endDate")String endDate,@Param("funName")String funName,@Param("typeName")String typeName);
	public FunctionModule getFunction(@Param("Id")long id);
	public int updateFunction(FunctionModule function,@Param("typeId")long typeId,@Param("typeName")String typeName,@Param("code") long code, @Param("funName")String funName,@Param("debugFile")String debugFile,@Param("remark")String remark,@Param("nowDate")String nowDate,@Param("Id")long id);
	public List<FunctionModule> getFunctionListByCriteria(@Param("StartPos")int startPos,@Param("EndPos")int endPos);
	public List<FunctionModule> getSomeFunctionListByCriteria(@Param("startDate")String startDate,@Param("endDate")String endDate,@Param("funName")String funName,@Param("typeName")String typeName,@Param("StartPos")int startPos,@Param("EndPos")int endPos);
	public FunctionModule getFunctionByMaxId();
	public int deleteFunctionById(long funId);
	
}
