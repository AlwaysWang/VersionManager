package com.wt.serviceimp;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Service;

import com.wt.basedao.programmoduleDao;
import com.wt.bean.ProgramModule;

@Service("programModuleService")
public class ProgramModuleService {
	 String resource="cfg.xml";
	 InputStream is = FunctionService.class.getClassLoader().getResourceAsStream(resource);
	 SqlSessionFactory sessionFactory = new SqlSessionFactoryBuilder().build(is);
	 SqlSession session = sessionFactory.openSession();
	 programmoduleDao programmoduleDao=session.getMapper(programmoduleDao.class);
	 public String  insertProgramModule(ProgramModule programModule){
		  programmoduleDao.insertProgramModule(programModule);
		  session.commit();
		  return null;
	 }
	 public List<ProgramModule>getProgramModuleListByMdId(long mdId){
		 return programmoduleDao.getProgramModuleListByMdId(mdId);
	 }
	 public String updateProgramModule(long pgId,long funId){
		 programmoduleDao.updateProgramModule(pgId,funId);
		 session.commit();
		 return null;
	 }
	 public String deleteProgramModuleByFunId(long funId){
		 programmoduleDao.deleteProgramModuleByFunId(funId);
		 session.commit();
		 return null;
	 }
	 public String deleteProgramModuleByPgId(long pgId){
		 programmoduleDao.deleteProgramModuleByPgId(pgId);
		 session.commit();
		 return null;
	 }
	 public List<ProgramModule> getProgramModuleListByPgId(long pgId){
		 return programmoduleDao.getProgramModuleListByPgId(pgId);
	 }
}
