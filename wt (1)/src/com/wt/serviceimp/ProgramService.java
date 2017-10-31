package com.wt.serviceimp;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wt.basedao.functionDao;
import com.wt.basedao.programDao;
import com.wt.bean.Program;
@Service("pgService")
public class ProgramService {
	String resource="cfg.xml";
	 InputStream is = ProgramService.class.getClassLoader().getResourceAsStream(resource);
	 SqlSessionFactory sessionFactory = new SqlSessionFactoryBuilder().build(is);
	 SqlSession session = sessionFactory.openSession();
	 //functionDao funDao=session.getMapper(functionDao.class);
	programDao pgdao=session.getMapper(programDao.class);
	 public List<Program> getProgramList(String pgName,long testCode){
		 return pgdao.getProgramByProgramNameAndTestCode(pgName, testCode);
	 }
	 public List<Program> getProgramAllList(){
		 return pgdao.getAllProgramList();
	 }
	 @Transactional
	 public String insertProgram(Program program){
		 pgdao.insertProgram(program);
		 session.commit();
		 return null;
	 }
	 public List<Program>getProgramList(){
		 return pgdao.getProgramList();
	 }
	 public List<Program>getSomeProgamList(String startDate,String endDate,String programName){
		 return pgdao.getSomeProgramList(startDate,endDate,programName);
	 }
	 public Program getProgramById(long id){
		 return pgdao.getProgramById(id);
	 }
	 @Transactional
	 public String  updateProgram(Program program,long id,String pgName, String languageType,String systemType, String pgEdition, String progdisc,String storagePath,String remark){
		 pgdao.updateProgram( program,id, pgName,  languageType, systemType,  pgEdition, progdisc,storagePath,remark);
		 session.commit();
		 return null;
	 }
	 public List<Program> getProgramListByCriteria(int startPos,int endPos){
		 return pgdao.getProgramListByCriteria(startPos, endPos);
	 }
	 public List<Program> getSomeProgramListByCriteria(String startDate,String endDate,String programName,int startPos,int endPos){
		 return pgdao.getSomeProgramListByCriteria(startDate,endDate,programName,startPos, endPos);
	 }
public String deleteProgramById(long pgId){
	pgdao.deleteProgramById(pgId);
	session.commit();
	return null;
}
}
