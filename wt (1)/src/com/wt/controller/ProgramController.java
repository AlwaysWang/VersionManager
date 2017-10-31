package com.wt.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import page.Page;

import com.wt.bean.FunctionModule;
import com.wt.bean.InstallVersion;
import com.wt.bean.Program;
import com.wt.bean.ProgramModule;
import com.wt.bean.Role;
import com.wt.bean.TestCode;
import com.wt.bean.TestType;
import com.wt.serviceimp.FunctionService;
import com.wt.serviceimp.InstallVersionService;
import com.wt.serviceimp.ProgramModuleService;
import com.wt.serviceimp.ProgramService;
import com.wt.serviceimp.RoleService;
import com.wt.serviceimp.TestCodeService;
import com.wt.serviceimp.TestTypeService;

import fileoperateutil.FileOperateUtil;
@Controller
@RequestMapping("/program")
public class ProgramController {
	@Autowired
 private ProgramService pgService;
	@Autowired
	 private TestCodeService testCodeService;
	@Autowired
	private InstallVersionService installVersionService;
	@Autowired 
	private TestTypeService testTypeService;
	@Autowired
	private FunctionService funService;
	@Autowired
	private RoleService roleService;
	@Autowired
	private ProgramModuleService programModuleService;
	@RequestMapping("/queryAllProgram")
	public String loginError(HttpServletRequest request){
		  return "loginerror";
	}
 @RequestMapping("/queryAllProgram/{userId}")
 public String getAllProgramList1(HttpServletRequest request,Map<String, Object> map,@PathVariable("userId")long userId) throws IOException{
	 Role role=roleService.getRoleByRoleId(userId);
	  String remark=role.getRemark();
	 List<TestCode> testCodeList=testCodeService.getTestCodeList();
	 List<Program> pgAllList=pgService.getProgramAllList();
	 List<Program> pgList=pgService.getProgramListByCriteria(1,10);
	 List<TestType> testTypeAllList=testTypeService.getTestTypeAllList();
	 request.setAttribute("testTypeAllList", testTypeAllList);
	for (Program program : pgList) {
	List <FunctionModule>funlist=program.getFunList();
		}
	 
	  Page page = new Page(pgAllList.size(), 1); 
		map.put("page", page);  
	    map.put("list", pgList);
		request.setAttribute("testCodeList", testCodeList);
	   request.setAttribute("pgList",pgList);
	   request.setAttribute("pgAllList",pgAllList);
	   request.setAttribute("userType", remark);
	   request.setAttribute("userid", userId);
	 return "/programquery";
 }
 @RequestMapping("/programprotect/insertprogram")
 public String insertProgram(HttpServletRequest request,HttpServletResponse response,Program program,@RequestParam  MultipartFile[] files, Map<String, Object> map) throws Exception{
	 String uploadPath=System.getProperty("catalina.home")+"\\bin\\"+"uploadDir\\";
	 File uploadfile=new File(uploadPath);
	 if  (!uploadfile .exists()  && !uploadfile .isDirectory())      
	 {         
		 uploadfile.mkdir();    
	 } 
	    String pgName = request.getParameter("programname");
		String languageType= request.getParameter("languagetype");
		String systemType=request.getParameter("systemtype");
		String remark= request.getParameter("descripton");
		String pgEdition=request.getParameter("pgEdition");
		program.setPgName(pgName);
		program.setRemark(remark);
		program.setPgEdition(pgEdition);
		program.setLanguageType(languageType);
		program.setSystemType(systemType);
		String filePath=files[0].getOriginalFilename();
		String filePath1=files[1].getOriginalFilename();
		/*String progdisc= request.getSession().getServletContext()  
	                .getRealPath("/")  
	                + FileOperateUtil.UPLOADDIR+filePath;  */
		String progdisc=System.getProperty("catalina.home")+"\\bin\\" + FileOperateUtil.UPLOADDIR+filePath;
		progdisc= progdisc.replaceAll("\\\\", "\\\\\\\\");
		String storagePath=System.getProperty("catalina.home")+"\\bin\\"
                + FileOperateUtil.UPLOADDIR+filePath1;
		storagePath=storagePath.replaceAll("\\\\", "\\\\\\\\");
	    program.setProgdisc(progdisc);
		program.setStoragePath(storagePath);
		pgService.insertProgram(program);
		    String uploadDir =System.getProperty("catalina.home")+"\\bin\\"+"uploadDir/";
			File file=new File(uploadDir,filePath);
				files[0].transferTo(file);
			File file1=new File(uploadDir,filePath1);
				files[1].transferTo(file1);
	    	String userid=request.getParameter("userid");
	    	long userId=Long.valueOf(userid);
	    	 Role role=roleService.getRoleByRoleId(userId);
	   	  String userType=role.getRemark();
	   	 List<TestCode> testCodeList=testCodeService.getTestCodeList();
	   	 List<Program> pgAllList=pgService.getProgramAllList();
	   	 List<Program> pgList=pgService.getProgramListByCriteria(1,10);
	   	 List<TestType> testTypeAllList=testTypeService.getTestTypeAllList();
	   	 request.setAttribute("testTypeAllList", testTypeAllList);
	   	  Page page = new Page(pgAllList.size(), 1); 
	   		map.put("page", page);  
	   	    map.put("list", pgList);
	   		request.setAttribute("testCodeList", testCodeList);
	   	   request.setAttribute("pgList",pgList);
	   	   request.setAttribute("pgAllList",pgAllList);
	   	   request.setAttribute("userType", remark);
	   	   request.setAttribute("userid", userId);
	 return "/programquery";
 }
 @RequestMapping("/updateprogram")
 public String updateProgram(HttpServletRequest request,Model model){
	 String userId=request.getParameter("userid");
	 System.out.println(userId);
	 long userid=Long.valueOf(userId);
	 String pid=request.getParameter("id");
	 long pId=Long.valueOf(pid);
	 Program program=pgService.getProgramById(pId);
	 System.out.println( program);
	 List<Program>pgAllList=pgService.getProgramAllList();
	 request.setAttribute("pgAllList", pgAllList);
	 model.addAttribute("program",program);
	 request.setAttribute("program",program);
	 List<InstallVersion> versionList=installVersionService.getInstallVersionAllList();
	 request.setAttribute("versionList", versionList);
	 request.setAttribute("userid", userid);
	 return "/programupdate";
 }
 @RequestMapping("/doupdateprogram")
 public String doupdateProgram(HttpServletRequest request,Program program,@RequestParam  MultipartFile[] files,Map<String, Object> map) throws Exception{
	 String uploadPath=System.getProperty("catalina.home")+"\\bin\\"+"uploadDir\\";
	 File uploadfile=new File(uploadPath);
	 if  (!uploadfile .exists()  && !uploadfile .isDirectory())      
	 {         
		 uploadfile.mkdir();    
	 } 
	 String userid=request.getParameter("userid");
	  long userId=Long.valueOf(userid);
	 String pid=request.getParameter("id");
	   long pId=Long.valueOf(pid);
	  program=pgService.getProgramById(pId);
	   String pgName = request.getParameter("programname");
		String languageType= request.getParameter("languagetype");
		String systemType=request.getParameter("systemtype");
		String remark= request.getParameter("descripton");
		String pgEdition=request.getParameter("pgEdition");
		String filePath=files[0].getOriginalFilename();
		String filePath1="";
		if(files.length>1){
	      filePath1=files[1].getOriginalFilename();
		}
	
		String storagePath=null;
		String progdisc=null;
		if(filePath!=""){
		progdisc= System.getProperty("catalina.home")+"\\bin\\"
	                + FileOperateUtil.UPLOADDIR+filePath;  
		progdisc= progdisc.replaceAll("\\\\", "\\\\\\\\");

		program.setProgdisc(progdisc);
		 String uploadDir = System.getProperty("catalina.home")+"\\bin\\"+"uploadDir/";
			File file=new File(uploadDir,filePath);
				files[0].transferTo(file);
			
		}
		if(filePath==""){
			 progdisc=program.getProgdisc();
		}
		if(filePath1!=""){
			storagePath=System.getProperty("catalina.home")+"\\bin\\"
		             + FileOperateUtil.UPLOADDIR+filePath1;
				storagePath=storagePath.replaceAll("\\\\", "\\\\\\\\");
				program.setStoragePath(storagePath);
				 String uploadDir =System.getProperty("catalina.home")+"\\bin\\"+"uploadDir/";
					File file=new File(uploadDir,filePath1);
						files[1].transferTo(file);
		}
		if(filePath1==""){
			 storagePath=program.getStoragePath();
				
		}
		program=pgService.getProgramById(pId);
		program.setPgName(pgName);
		program.setRemark(remark);
		program.setPgEdition(pgEdition);
		program.setLanguageType(languageType);
		program.setSystemType(systemType);
		//pgService.insertProgram(program);
		System.out.println(storagePath);
		System.out.println( progdisc);
		pgService.updateProgram(program, pId, pgName, languageType, systemType, pgEdition, progdisc, storagePath, remark);
		Role role=roleService.getRoleByRoleId(userId);
		  String userType=role.getRemark();
		 List<TestCode> testCodeList=testCodeService.getTestCodeList();
		 List<Program> pgAllList=pgService.getProgramAllList();
		 List<Program> pgList=pgService.getProgramListByCriteria(1,10);
		 List<TestType> testTypeAllList=testTypeService.getTestTypeAllList();
		 request.setAttribute("testTypeAllList", testTypeAllList);
		  Page page = new Page(pgAllList.size(), 1); 
			map.put("page", page);  
		    map.put("list", pgList);
			request.setAttribute("testCodeList", testCodeList);
		   request.setAttribute("pgList",pgList);
		   request.setAttribute("pgAllList",pgAllList);
		   request.setAttribute("userType", userType);
		   request.setAttribute("userid", userId);
	 return "/programquery";
 }
 @RequestMapping("/protectProgram/{userid}")
 public String protectProgram(HttpServletRequest request,@PathVariable long userid){
	 List<Program>pgAllList=pgService.getProgramAllList();
	 request.setAttribute("pgAllList", pgAllList);
	 List<InstallVersion> versionList=installVersionService.getInstallVersionAllList();
	 request.setAttribute("versionList", versionList);
	 List<FunctionModule> funList=funService.getAllFunList();
	 request.setAttribute("funList", funList);
	 request.setAttribute("userid", userid);
	 return "/programadd";
 }
 @RequestMapping("/protectProgram")
 public String protectProgram(HttpServletRequest request){
	
	 return "/loginerror";
 }
 
 @RequestMapping(value="/queryByCriteria", method=RequestMethod.POST)
 public @ResponseBody Map<String,Object> queryByCriteria(HttpServletRequest request,HttpServletResponse response) throws IOException{
	 String pagesize=request.getParameter("pagesize");
 	   int pageSize=Integer.valueOf(pagesize);
 	   String pagenumber=request.getParameter("pagenumber");
 	   int pageNumber=Integer.valueOf(pagenumber);
 	   String listcount=request.getParameter("listcount");
 	   int listCount=Integer.valueOf(listcount);
 	   Page page = new Page(listCount, pageNumber); 
 	   page.setPageSize(pageSize);
 	   page.setPageNow(pageNumber);
 	   int pageCount=page.getTotalPageCount();
      int endpos=page.getStartPos()-1+page.getPageSize();
      int endPos=(endpos<=listCount)?endpos:listCount;
 	   List<Program> programList=pgService.getProgramListByCriteria(page.getStartPos(), endPos);
 	 
 	   for (Program program : programList) {

	}
 	   int listsize=programList.size();
 	   Map<String, Object> map = new HashMap<String, Object>();  
 	   map.put("programlist",programList);
 	   map.put("pageCount",pageCount);
 	   map.put("page",page);
 	   map.put("listsize",listsize);
 	   return map;
 }
 @RequestMapping(value="/querysomeprogram", method=RequestMethod.POST)
 public @ResponseBody  Map<String,Object> querySomeFunction(HttpServletRequest request){
	  String pagesize=request.getParameter("pagesize");
	   int pageSize=Integer.valueOf(pagesize);
	   String pagenumber=request.getParameter("pagenumber");
	   int pageNumber=1;
	   if(pagenumber!=""){
		  pageNumber=Integer.valueOf(pagenumber);
	   }
	   String listcount=request.getParameter("listcount");
	   int listCount=Integer.valueOf(listcount);
	    String startDate= request.getParameter("startDate");
	    String endDate= request.getParameter("endDate");
	   // System.out.println(endDate+"querysomeprogram");
	    String endDate1=null;
	    if(endDate!=""){
		endDate1=endDate+" "+"23:59:59";
		}
		String programName=request.getParameter("pgname");
		List<Program> pgList1=pgService.getSomeProgamList(startDate, endDate1, programName);
		Page page = new Page(pgList1.size(), pageNumber); 
	 	   page.setPageSize(pageSize);
	 	   page.setPageNow(pageNumber);
	 	   int pageCount=page.getTotalPageCount();
	 	   int listSize=pgList1.size();
	       int endpos=page.getStartPos()-1+page.getPageSize();
	       int endPos=(endpos<=listSize)?endpos:listSize;
	       System.out.println("此次查询list的总数"+listSize);
	         System.out.println("理论结点数"+endpos);
	         System.out.println("此次查询结点"+endPos);
		List<Program> pgList2=pgService.getSomeProgramListByCriteria(startDate, endDate1,programName,  page.getStartPos(), endPos);
 		 int listsize=pgList1.size();
 		request.setAttribute("AllFunList", pgList1);
 		    request.setAttribute("page", page);
 		    Map<String, Object> map = new HashMap<String, Object>(); 
 		    map.put("page", page);  
 		    map.put("programlist", pgList2);
 		    map.put("listsize", listsize);
 	return map;
 }
 
 
@RequestMapping(value="/querySomeListByCriteria", method=RequestMethod.POST)
 public @ResponseBody Map<String,Object> somelist(HttpServletRequest request,HttpServletResponse response) throws IOException{
	      String startDate= request.getParameter("startDate");
			String endDate= request.getParameter("endDate");
			System.out.println("endDate"+endDate);
			System.out.println(startDate+"startDate");
			String endDate1=null;
			//System.out.println(endDate!=null);
			if(endDate!=""){
			endDate1=endDate+" "+"23:59:59";
			}
			String programName=request.getParameter("pgname");
	   String pagesize=request.getParameter("pagesize");
 	   int pageSize=Integer.valueOf(pagesize);
 	   String pagenumber=request.getParameter("pagenumber");
 	   int pageNumber=Integer.valueOf(pagenumber);
 	   String listcount=request.getParameter("listcount");
 	   int listCount=Integer.valueOf(listcount);
 	   Page page = new Page(listCount, pageNumber); 
 	   page.setPageSize(pageSize);
 	   page.setPageNow(pageNumber);
 	   int pageCount=page.getTotalPageCount();
   
 	  List<Program> programList1=pgService.getSomeProgamList(startDate, endDate1, programName);
 	  int listSize=programList1.size();
      int endpos=page.getStartPos()-1+page.getPageSize();
      int endPos=(endpos<=listSize)?endpos:listSize;
      System.out.println("此次查询list的总数"+listSize);
      System.out.println("理论结点数"+endpos);
      System.out.println("此次查询结点"+endPos);
      System.out.println("-----------------");
 	   List<Program> programList=pgService.getSomeProgramListByCriteria(startDate, endDate1,programName, page.getStartPos(), endPos);
 	  for (Program program : programList) {
	}
 	   int listsize=programList.size();
 	   Map<String, Object> map = new HashMap<String, Object>();  
 	   map.put("programlist",programList);
 	   map.put("pageCount",pageCount);
 	   map.put("page",page);
 	   map.put("listsize",listsize);
 	   return map;
 }
@RequestMapping("/deleteProgramById")
public  @ResponseBody Map<String,Object>  deleteVersionById(HttpServletRequest request){
	System.out.println("hhh");
	Map<String, Object> map = new HashMap<String, Object>(); 
	 List<ProgramModule> pgModuleList=new ArrayList();
	  String pagesize=request.getParameter("pagesize");
	   int pageSize=Integer.valueOf(pagesize);
	   String pagenumber=request.getParameter("pagenumber");
	   int pageNumber=1;
	   if(pagenumber!=""){
		   pageNumber=Integer.valueOf(pagenumber);
	   }
	   String pgid=request.getParameter("id");
	   if(pgid!=null){
		   long pgId=Long.valueOf(pgid);
		   pgService.deleteProgramById(pgId);
		   programModuleService.deleteProgramModuleByPgId(pgId);
	   }
	   List<Program> pgAllList=pgService.getProgramAllList();
	   Page page=new Page(pgAllList.size(),pageNumber);
	   page.setPageSize(pageSize);
	   int endpos=page.getStartPos()-1+page.getPageSize();
		List<Program> pgList=pgService.getProgramListByCriteria(page.getStartPos(),endpos);
	   map.put("page", page);
	   map.put("list", pgList);
	
	
	
	return map;
	
	
	
	
	
}
@RequestMapping("/ConfirmProgramById")
public @ResponseBody Map<String,Object> ConfirmProgramById(HttpServletRequest request){
	Map<String, Object> map = new HashMap<String, Object>(); 
	List<ProgramModule> pgModuleList1=new ArrayList();
	List<Long> FunIdList1=new ArrayList();
	List FunNameList1=new ArrayList();
	List<Long> FunIdList2=new ArrayList();
	Set FunNameList2=new HashSet();
	String id=request.getParameter("id");
	if(id!=null){
		Long pgId=Long.valueOf(id);
		List<ProgramModule> pgModuleList=programModuleService.getProgramModuleListByPgId(pgId);
		for (ProgramModule programModule : pgModuleList) {
			if(programModule!=null){
				 pgModuleList1=programModuleService.getProgramModuleListByMdId( programModule.getMdId());
			}
			if(pgModuleList1.size()==1){
				for (ProgramModule programModule1: pgModuleList1) {
					if(programModule1!=null){
						FunIdList1.add(programModule1.getMdId());
					}
				}
			}
			if(pgModuleList1.size()>1){
				for (ProgramModule programModule2 : pgModuleList1) {
					if(programModule2!=null){
						FunIdList2.add(programModule2.getMdId());
					}
				}
				
			}
		}
		if(FunIdList1.size()>0){
		for (Long funId :FunIdList1) {
			FunctionModule fun=funService.getFunction(funId);
			if(fun!=null){
				FunNameList1.add(fun.getName());
			}
		}
		}
		if(FunIdList2.size()>0){
		for (Long funId :FunIdList2) {
			FunctionModule fun=funService.getFunction(funId);
			if(fun!=null){
				FunNameList2.add(fun.getName());
			}
		}
		}
		map.put("FunNameList1", FunNameList1);
		map.put("FunNameList2", FunNameList2);
			map.put("pgModuleList", pgModuleList);
	

	}
	return map;
}
 }
