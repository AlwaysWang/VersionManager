package com.wt.serviceimp;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wt.basedao.functionDao;
import com.wt.bean.FunctionModule;

@Service("funService")
public class FunctionService implements com.wt.service.FunctionService{

	 String resource="cfg.xml";
	 InputStream is = FunctionService.class.getClassLoader().getResourceAsStream(resource);
	 SqlSessionFactory sessionFactory = new SqlSessionFactoryBuilder().build(is);
	 SqlSession session = sessionFactory.openSession();
	 functionDao funDao=session.getMapper(functionDao.class);
	/* public List<FunctionModule> getFunListByName(String name){
		 String statement = "mapper.functionMapper.getFunctionModuleByName";
		 List<FunctionModule> funlist= session.selectList(statement, "��ѯ");
		 System.out.println(funlist.size());
		 return funlist;
	 }*/
	public List<FunctionModule>getFunListByNameAndType(String name,String typename){
		List<FunctionModule> funlist=funDao.getFunctionModuleByNameAndType(name, typename);
		return funlist;
		
	}
	public List<FunctionModule> getAllFunList(){
		List<FunctionModule> AllFunList=funDao.getAllFunList();
		return AllFunList;
	}
	public String insertFunctionModule(FunctionModule function){
		funDao.insertFunction(function);
		session.commit();
		return null;
	}
	public List<FunctionModule>getSomeFunctionList(String startDate,String endDate,String funName,String typeName){
		return funDao.getSomeFunctionList(startDate, endDate, funName, typeName);
	}
	public FunctionModule getFunction(long id){
		return funDao.getFunction(id);
		}
	public String updateFunction(FunctionModule function,long typeId,String typeName,long code,String funName,String debugFile,String remark,String nowDate,long id){
		 funDao.updateFunction(function,typeId,typeName,code, funName, debugFile, remark,nowDate, id);
		 session.commit();
		 return null;
	};
	public List<FunctionModule> getFunctionListByCriteria(int startPos,int endPos){
		return funDao.getFunctionListByCriteria(startPos, endPos);
	}
	public List<FunctionModule> getSomeFunctionListByCriteria(String startDate,String endDate,String funName,String typeName,int startPos,int endPos){
		return funDao.getSomeFunctionListByCriteria(startDate, endDate, funName, typeName, startPos, endPos);
	}
	public FunctionModule getFunctionByMaxId(){
		return funDao.getFunctionByMaxId();
	}
	public String  deleteFunctionById(long funId){
		 funDao.deleteFunctionById(funId);
		 session.commit();
		 return null;
	}
	}
	

