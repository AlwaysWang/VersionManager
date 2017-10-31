package com.wt.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.apache.tools.ant.types.CommandlineJava.SysProperties;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import page.ExcelUtils;
import page.FileUploadUtil;
import page.HttpUtils;
import page.Page;

import com.itextpdf.text.log.SysoCounter;
import com.wt.basedao.functionDao;
import com.wt.bean.FunctionModule;
import com.wt.bean.InstallVersion;
import com.wt.bean.Program;
import com.wt.bean.ProgramModule;
import com.wt.bean.Role;
import com.wt.bean.TestCode;
import com.wt.bean.TestType;
import com.wt.bean.VersionRelation;
import com.wt.serviceimp.FunctionService;
import com.wt.serviceimp.InstallVersionService;
import com.wt.serviceimp.ProgramModuleService;
import com.wt.serviceimp.ProgramService;
import com.wt.serviceimp.RoleService;
import com.wt.serviceimp.TestCodeService;
import com.wt.serviceimp.TestTypeService;
import com.wt.serviceimp.VersionRelationService;

import fileoperateutil.DownloadRecord;
import fileoperateutil.FileOperateUtil;
import fileoperateutil.download;

@Controller
@RequestMapping("/function")
public class FunctionController {
	@Autowired
	private FunctionService funService;
	@Autowired
	private TestCodeService testCodeService;
	@Autowired
	private TestTypeService testTypeService;
	@Autowired
	private ProgramService pgService;
	@Autowired
	private ProgramModuleService programModuleService;
	@Autowired
	private RoleService roleService;
	@Autowired
	private VersionRelationService versionrelationService;
	@Autowired
	private InstallVersionService installVersionService;
@RequestMapping("/queryByName")
public String queryFunByName(@RequestParam("name")String name,@RequestParam("typename")String typename,HttpServletRequest request){
	List<FunctionModule>funList=funService.getFunListByNameAndType(name, typename);
	request.setAttribute("funList", funList);
	return "/queryByName";
}@RequestMapping("/queryAllFun")
public String loginError(HttpServletRequest request){
	  return "loginerror";
}
@RequestMapping("/queryAllFun/{userId}")
public String queryAllFunList(HttpServletRequest request,Map<String, Object> map,@PathVariable("userId")long userId){
	long id=Long.valueOf(userId);
	 Role role=roleService.getRoleByRoleId(id);
	  String remark=role.getRemark();
	List<FunctionModule>AllFunList=funService.getAllFunList();
	List<FunctionModule>AllFunList1=funService.getFunctionListByCriteria(1, 10) ;
	  List<TestType> testTypeAllList=testTypeService.getTestTypeAllList();
	  request.setAttribute("testTypeAllList", testTypeAllList);
	  Page page = new Page(AllFunList.size(), 1); 
	  map.put("page", page);  
      map.put("list", AllFunList1);
	  request.setAttribute("AllFunList", AllFunList1);
	  request.setAttribute("userType", remark);
	  request.setAttribute("userid", userId);
	return "/functionquery";
}
@RequestMapping("/functionprotect/insertFunction")
public String insertFunction(HttpServletRequest request,@RequestParam(value = "programlist")String[] data,@RequestParam  MultipartFile debugFile,Map<String, Object> map) throws Exception{
	String uploadPath=System.getProperty("catalina.home")+"\\bin\\"+"uploadDir\\";
	 File uploadfile=new File(uploadPath);
	 if  (!uploadfile .exists()  && !uploadfile .isDirectory())      
	 {         
		 uploadfile.mkdir();    
	 } 
	    String userid=request.getParameter("userid");
		long userId=1;
		if(userid!=null){
			 userId=Long.valueOf(userid);
		}
	    String name = request.getParameter("functionname");
		String testtype = request.getParameter("typetest");
		String typename=request.getParameter("typetest1");
		long typeid=Long.valueOf(testtype);
		String Code=request.getParameter("testCode");
		long code=Long.valueOf(Code);
		String descripton=request.getParameter("descripton");
		String filePath=debugFile.getOriginalFilename();
		/*String debugfile= request.getSession().getServletContext()  
                .getRealPath("/")  
                + FileOperateUtil.UPLOADDIR+filePath;  */
		String debugfile=System.getProperty("catalina.home")+"\\bin\\"+FileOperateUtil.UPLOADDIR+filePath;
		debugfile= debugfile.replaceAll("\\\\", "\\\\\\\\");
		FunctionModule function=new FunctionModule();
		function.setName(name);
		function.setDebugFile(debugfile);
		function.setTypeid(typeid);
		function.setTestCode(code);
		function.setRemark(descripton);
		function.setTypeName(typename);
		TestType testType=new TestType();
		testType.setTypeName(typename);
		funService.insertFunctionModule(function);
		//String uploadDir = request.getSession().getServletContext().getRealPath("/") +"uploadDir/";
		String uploadDir=System.getProperty("catalina.home")+"\\bin\\"+"uploadDir/";
		File file=new File(uploadDir,filePath);
		
		
			debugFile.transferTo(file);
		
			//向程序功能表中添加程序功能关系,先找到功能表中ID最大的功能数据
		FunctionModule fun=funService.getFunctionByMaxId();
		for (int i = 0; i < data.length; i++) {
			ProgramModule pm=new ProgramModule();
			pm.setMdId(fun.getId());
			long pgId=Long.valueOf(data[i]);
			pm.setPdId(pgId);
			programModuleService.insertProgramModule(pm);
		}
		
		
		long id=Long.valueOf(userId);
		 Role role=roleService.getRoleByRoleId(userId);
		  String remark=role.getRemark();
		List<FunctionModule>AllFunList=funService.getAllFunList();
		List<FunctionModule>AllFunList1=funService.getFunctionListByCriteria(1, 10) ;
		 List<TestType> testTypeAllList=testTypeService.getTestTypeAllList();
		 request.setAttribute("testTypeAllList", testTypeAllList);
		Page page = new Page(AllFunList.size(), 1); 
		map.put("page", page);  
	    map.put("list", AllFunList1);
		request.setAttribute("AllFunList", AllFunList1);
		  request.setAttribute("userType", remark);
		  request.setAttribute("userid", userId);
	return "/functionquery";

}
@RequestMapping("/querysomefunction")
public  @ResponseBody Map<String,Object> querySomeFunction(HttpServletRequest request,FunctionModule function){
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
		String endDate1=null;
		if(endDate!=""){
		endDate1=endDate+" "+"23:59:59";
		}
		String funName = request.getParameter("funname");
		String typeName= request.getParameter("typename");
		if(typeName.equals("请选择")){
			typeName="";
		}
		List<FunctionModule>AllFunList=funService.getSomeFunctionList(startDate, endDate1, funName, typeName);
		Page page = new Page(AllFunList.size(), pageNumber); 
	 	   page.setPageSize(pageSize);
	 	   page.setPageNow(pageNumber);
	 	   int pageCount=page.getTotalPageCount();
	 	   int listSize=AllFunList.size();
	       int endpos=page.getStartPos()-1+page.getPageSize();;
	       int  endPos=(endpos<=listSize)?endpos:listSize;
	       System.out.println("此次查询list的总数"+listSize);
	         System.out.println("理论结点数"+endpos);
	         System.out.println("此次查询结点"+endPos);
	         System.out.println("-----------------");
		List<FunctionModule>AllFunList1=funService.getSomeFunctionListByCriteria(startDate, endDate1, funName, typeName,  page.getStartPos(), endPos);
		 int listsize=AllFunList.size();
		request.setAttribute("AllFunList", AllFunList1);
		    request.setAttribute("page", page);
		    Map<String, Object> map = new HashMap<String, Object>(); 
		    map.put("page", page);  
		    map.put("funlist", AllFunList1);
		    map.put("listsize", listsize);
	return map;
}

@RequestMapping("/updatefunction")
public String updateFunction(HttpServletRequest request,Model model){
	String userid=request.getParameter("userid");
    long userId=1;
	String pid=request.getParameter("id");
	long Id=Long.valueOf(pid);
	FunctionModule function=funService.getFunction(Id);
	model.addAttribute("function",function);
	List<FunctionModule>AllFunList=funService.getAllFunList();
	List<ProgramModule> pgList1=programModuleService.getProgramModuleListByMdId(Id);
	 List<TestType> testTypeAllList=testTypeService.getTestTypeAllList();
	 request.setAttribute("testTypeAllList", testTypeAllList);
	request.setAttribute("AllFunList", AllFunList);
	List<Program> pgList=pgService.getProgramAllList();
	for (Program program : pgList) {
		System.out.println(program.getId()+"hh");
		System.out.println(program.getPgName()+"h");
	}
	request.setAttribute("pgList", pgList);
	List pgIdList=new ArrayList();
	for (ProgramModule program : pgList1) {
		pgIdList.add(program.getPdId());
	}
	request.setAttribute("pgIdList", pgIdList);
	request.setAttribute("userid", userId);
	request.setAttribute("id", Id);
	return "/functionupdate";
}
@RequestMapping(value="/showPgList", method = RequestMethod.POST)
public  @ResponseBody Map<String,Object>  showPgList(HttpServletRequest request){
	String id=request.getParameter("funid");
	long Id = 0;
if(id!=null){
	Id=Long.valueOf(id);
}
	List<ProgramModule> pgList1=programModuleService.getProgramModuleListByMdId(Id);
	//查询所有的pg
	List<Program> pgAllList=pgService.getProgramAllList();
	List<Program> pgList=pgService.getProgramListByCriteria(1, 10);
	request.setAttribute("pgList", pgList);
	List pgIdList=new ArrayList();
	List pgIdAllList=new ArrayList();
	List pgNameList=new ArrayList();
	for (ProgramModule program : pgList1) {
		pgIdList.add(program.getPdId());
	}
	for (Program program : pgList) {
		pgIdAllList.add(program.getId());
	}
	request.setAttribute("pgList", pgList);
	request.setAttribute("pgIdList", pgIdList);
	request.setAttribute("pgIdAllList", pgIdAllList);
	Map<String, Object> map = new HashMap<String, Object>(); 
	Page page=new Page( pgAllList.size(),1);
	page.setPageSize(10);//默认每条10
	map.put("pgList", pgList);
	map.put("pgIdList", pgIdList);
	map.put("pgIdAllList", pgIdAllList);
	map.put("page",page);
	return map;
}
@RequestMapping("/doupdatefunction")
public String doupdateFunction(HttpServletRequest request,@RequestParam(value = "programlist")String[] data,@RequestParam  MultipartFile debugFile,Map<String, Object> map) throws Exception{
	String uploadPath=System.getProperty("catalina.home")+"\\bin\\"+"uploadDir\\";
	 File uploadfile=new File(uploadPath);
	 if  (!uploadfile .exists()  && !uploadfile .isDirectory())      
	 {         
		 uploadfile.mkdir();    
	 } 
	String userid=request.getParameter("userid");
	long userId=Long.valueOf(userid);
	String pid=request.getParameter("id");
	 long Id=Long.valueOf(pid);
	FunctionModule function=funService.getFunction(Id);
	 String name = request.getParameter("functionname");
	 String testtype = request.getParameter("typetest");
	 String typename=request.getParameter("typetest1");
	 long typeid=Long.valueOf(testtype);
		String Code=request.getParameter("testCode");
		long code=Long.valueOf(Code);
		String descripton=request.getParameter("descripton");
		String filePath=debugFile.getOriginalFilename();
		String debugfile=null;
	if(filePath!=""){
	  /*debugfile= request.getSession().getServletContext()  
             .getRealPath("/")  
             + FileOperateUtil.UPLOADDIR+filePath;  */
		debugfile=System.getProperty("catalina.home")+"\\bin\\"+ FileOperateUtil.UPLOADDIR+filePath;
		debugfile= debugfile.replaceAll("\\\\", "\\\\\\\\");
		function.setDebugFile(debugfile);
		//String uploadDir = request.getSession().getServletContext().getRealPath("/") +"uploadDir/";
		String uploadDir=System.getProperty("catalina.home")+"\\bin\\"+"uploadDir/";
		File file=new File(uploadDir,filePath);
		
		
			debugFile.transferTo(file);
	
		}
	else{
		debugfile=function.getDebugFile();
		function.setDebugFile(debugfile);
	}   
	function.setTypeName(typename);
		function.setName(name);
		function.setTypeid(typeid);
		function.setTestCode(code);
		function.setRemark(descripton);
		TestType testType=new TestType();
		testType.setTypeName(typename);
		function.setTestType(testType);
		Date date=new Date();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String update = df.format(date);
		function.setNowDate(update);
		funService.updateFunction(function, typeid, typename,code,  name, debugfile, descripton, update, Id);
		//向程序功能表中修改程序功能关系根据功能id修改程序id 删除对应关系
		programModuleService.deleteProgramModuleByFunId(Id);
		//FunctionModule fun=funService.getFunctionByMaxId();
		for (int i = 0; i < data.length; i++) {
			ProgramModule pm=new ProgramModule();
			pm.setMdId(Id);
			long pgId=Long.valueOf(data[i]);
			pm.setPdId(pgId);
			programModuleService.insertProgramModule(pm);
		}
		List<FunctionModule>AllFunList=funService.getAllFunList();
		//List<TestCode> testCodeList=testCodeService.getTestCodeList();
		List<FunctionModule>AllFunList1=funService.getFunctionListByCriteria(1, 10) ;
		 List<TestType> testTypeAllList=testTypeService.getTestTypeAllList();
		 request.setAttribute("testTypeAllList", testTypeAllList);
		Page page = new Page(AllFunList.size(), 1); 
		map.put("page", page);  
	    map.put("list", AllFunList1);
		request.setAttribute("AllFunList", AllFunList1);
		long id=Long.valueOf(userId);
		 Role role=roleService.getRoleByRoleId(id);
		  String remark=role.getRemark();
		  request.setAttribute("userType", remark);
		  request.setAttribute("userid", userId);
		
	return "/functionquery";

}
//userId�Ͳ����Ӧ
@RequestMapping("/protectFun/{userId}")
public String protectFun(HttpServletRequest request,@PathVariable long userId){
	List<FunctionModule>AllFunList=funService.getAllFunList();
	request.setAttribute("AllFunList", AllFunList);
	List<TestType> testTypeAllList=testTypeService.getTestTypeAllList();
	request.setAttribute("testTypeAllList", testTypeAllList);
	List<Program> pgList=pgService.getProgramAllList();
	request.setAttribute("pgList", pgList);
	request.setAttribute("userid", userId);
	return "/functionadd";
}
@RequestMapping("/protectFun")
public String protectFun(HttpServletRequest request){
	
	return "/loginerror";
}
@RequestMapping("downloadtext")
public  String  download(HttpServletRequest request,HttpServletResponse response) throws Exception{
	int download=0;
	String savePath = request.getParameter("savePath1");
	  String funname=request.getParameter("funname");
	  String suffix = savePath.substring(savePath.lastIndexOf(".") + 1);  
    String realName = funname+"手册下载."+suffix;  
    String contentType = "application/octet-stream";
    File dir = new File(savePath);
	download d=new download();
    if( dir.exists()){
  		d.download(realName, savePath, request, response);
    }
    else{

    	return "/error";
    }
    return "error";
}
@RequestMapping(value="/typetest")
//非常重要的@ResponseBody 
public @ResponseBody Map<String,Object>  getTestcode(HttpServletRequest request,HttpServletResponse response) throws IOException{
	
	String testTypeName=request.getParameter("typename");
	   response.setCharacterEncoding("UTF-8");
	   List<TestCode> testCodeList=testCodeService.getTestCodeListByTypeName(testTypeName);
	   List list=new ArrayList();
	   List<Long>list1=new ArrayList();
	  for (TestCode testCode : testCodeList) {
		  // String testname=testCode.getTestName();
		   long code=testCode.getCode();
		  // list.add(testname);
		   list1.add(code);
	   }
	 Collections.sort(list1);
      for (int i = 0; i < list1.size(); i++) {
		TestCode testcode=testCodeService.getTestCodeById(list1.get(i));
		list.add(testcode.getTestName());
	}
	  Map<String, Object> map = new HashMap<String, Object>(); 
	   map.put("list", list);
	   map.put("list1", list1);
	   return map;
}
@RequestMapping(value="/queryByCriteria", method = RequestMethod.POST)
public @ResponseBody Map<String,Object> getPageCount(HttpServletRequest request,HttpServletResponse response) throws IOException{
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
	   List<FunctionModule> funList=funService.getFunctionListByCriteria(page.getStartPos(),endPos);
	   int listsize=funList.size();
	   Map<String, Object> map = new HashMap<String, Object>();  
	   map.put("funlist",funList);
	   map.put("pageCount",pageCount);
	   map.put("page",page);
	   map.put("listsize",listsize);
	   return map;
}
@RequestMapping("querySomePgList")
public @ResponseBody Map<String,Object>  getSomePgList(HttpServletRequest request,HttpServletResponse response){
	String id=request.getParameter("funid");
	String pagesize=request.getParameter("pagesize");
	   int pageSize=Integer.valueOf(pagesize);
	   String pagenumber=request.getParameter("pagenumber");
	   int pageNumber=1;
	   if(pagenumber!=""){
		   pageNumber=Integer.valueOf(pagenumber);
	   }
		String pgName = request.getParameter("pgName");
		String startDate="";
		String endDate="";
		   String listcount=request.getParameter("totalcount");
		   if(listcount!=null){
		   int listCount=Integer.valueOf(listcount);
		   }
		List<Program>SomePgList=pgService.getSomeProgamList(startDate, endDate, pgName);
		Page page = new Page(SomePgList.size(), pageNumber); 
	 	   page.setPageSize(pageSize);
	 	   page.setPageNow(pageNumber);
	 	   int pageCount=page.getTotalPageCount();
	 	   int listSize=SomePgList.size();
	       int endpos=page.getStartPos()-1+page.getPageSize();;
	       int  endPos=(endpos<=listSize)?endpos:listSize;
	       System.out.println("此次查询list的总数"+listSize);
	         System.out.println("理论结点数"+endpos);
	         System.out.println("此次查询结点"+endPos);
	         System.out.println("-----------------");
	         System.out.println(pgName+"pgName");
		List<Program>SomepgList=pgService.getSomeProgramListByCriteria(startDate, endDate,pgName , page.getStartPos(), endPos);
		 int listsize=SomepgList.size();
		request.setAttribute("SomepgList", SomepgList);
		    request.setAttribute("page", page);
		    Map<String, Object> map = new HashMap<String, Object>(); 
		    map.put("page", page);  
		    map.put("somepglist", SomepgList);
		    map.put("listsize", listsize);
		    //
			
		    List pgIdList=new ArrayList();
			List pgIdAllList=new ArrayList();
		if(id!=null){
			long  Id=Long.valueOf(id);
			List<ProgramModule> pgList1=programModuleService.getProgramModuleListByMdId(Id);
			for (ProgramModule program : pgList1) {
				pgIdList.add(program.getPdId());
				request.setAttribute("pgIdList", pgIdList);
				map.put("pgIdList", pgIdList);
			}
		}
			for (Program program : SomepgList) {
				pgIdAllList.add(program.getId());
			}
			request.setAttribute("pgIdAllList", pgIdAllList);
			map.put("pgIdAllList", pgIdAllList);
			System.out.println(pgIdList+"特定功能id");
			System.out.println(pgIdAllList+"所有的id");
			System.out.println(SomepgList+"查询出的pg");
	return map;
}
/*@RequestMapping("/querySomePgListByCriteria")
public @ResponseBody Map<String,Object> getSomePgListByCriteria(HttpServletRequest request,HttpServletResponse response){
	String id=request.getParameter("funid");
	String pagesize=request.getParameter("pagesize");
	   int pageSize=Integer.valueOf(pagesize);
	   String pagenumber=request.getParameter("pagenumber");
	   int pageNumber=1;
	   if(pagenumber!=""){
		   pageNumber=Integer.valueOf(pagenumber);
	   }
		String pgName = request.getParameter("pgName");
		String startDate="";
		String endDate="";
		
		
		
		
		
		
		
		
		
	
	Map<String, Object> map = new HashMap<String, Object>();  
	  return map;
}*/
@RequestMapping(value="/querySomeListByCriteria", method = RequestMethod.POST)
public @ResponseBody Map<String,Object> getPageCountSome(HttpServletRequest request,HttpServletResponse response) throws IOException{
	   String startDate= request.getParameter("startDate");
	   String endDate= request.getParameter("endDate");
		String endDate1=null;
		if(endDate!=""){
		endDate1=endDate+" "+"23:59:59";
		}
	   String funName=request.getParameter("funname");
	   String typeName= request.getParameter("typename");
	  if(typeName.equals("请选择")){
		  typeName="";
	  }
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
       List<FunctionModule> funList2=funService.getSomeFunctionList(startDate, endDate1, funName, typeName);
       int listSize=funList2.size();
       int endpos=page.getStartPos()-1+page.getPageSize();
       int endPos=(endpos<=listSize)?endpos:listSize;
       System.out.println("此次查询list的总数"+listSize);
       System.out.println("理论结点数"+endpos);
       System.out.println("此次查询结点"+endPos);
       System.out.println("-----------------");
	   List<FunctionModule> funList1=funService.getSomeFunctionListByCriteria(startDate, endDate1, funName, typeName, page.getStartPos(), endPos);
	   int listsize=funList1.size();
	   Map<String, Object> map = new HashMap<String, Object>();  
	   map.put("funlist",funList1);
	   map.put("pageCount",pageCount);
	   map.put("page",page);
	   map.put("listsize",listsize);
	   return map;
}
@RequestMapping("/saveProgram")
public @ResponseBody Map<String,Object> saveProgram(HttpServletRequest request,HttpServletResponse response){
	String pgidList1=request.getParameter("pgIdList");
	String d[] = null;
	  List  pgIdList=new ArrayList();
	    List <Long> pgIdList1=new ArrayList();
	    List pgNameList=new ArrayList();
    if(pgidList1!="")
    	{
    	 d =pgidList1.split(",");
    	   for (int i = 0; i < d.length; i++) {
    	    	pgIdList.add(d[i]);
    	    	pgIdList1.add(Long.valueOf(d[i]));
    		}
    	}
    //获得动态的idlist
    System.out.println(pgIdList1.size()+"pgIdList1.size()");
for (int i = 0; i <pgIdList1.size(); i++) {
	  Program program=pgService.getProgramById( pgIdList1.get(i));
		if(program!=null){
			pgNameList.add(program.getPgName());
		}
		}
	  String done=request.getParameter("done");
	   String id=request.getParameter("pgid");
	   long pgId=0;
	   if(id!=null){
		   pgId=Long.valueOf(id);
	   }
	   if(done.equals("1")&&pgId!=0&&(!pgIdList1.contains(pgId))){
		   System.out.println("不存在则添加");
		   Program program=pgService.getProgramById( pgId);
		   pgIdList1.add(pgId);
		   pgNameList.add(program.getPgName());
	   }
	   if(done.equals("0")&&pgId!=0&&pgIdList1.contains(pgId)){
		   System.out.println("存在则删除");
		   Program program=pgService.getProgramById( pgId);
		   pgIdList1.remove(pgId);
		   pgNameList.remove(program.getPgName());
	   }
	   System.out.println(pgIdList1);
	   System.out.println(pgNameList);
    Map<String, Object> map = new HashMap<String, Object>(); 
    //list.remove(0);
    map.put("list", pgIdList1);
    map.put("pgNameList",  pgNameList);
   // System.out.println(list+"list");
	return map;
}
@RequestMapping("/showPgNameList")
public  @ResponseBody Map<String,Object> showPgNameList(HttpServletRequest request,HttpServletResponse response){
	Map<String, Object> map = new HashMap<String, Object>(); 
	String funId=request.getParameter("funid");
	List  pgNameList=new ArrayList();
	long funid=0;
	if(funId!=null){
		funid=Long.valueOf(funId); 
		Program program=pgService.getProgramById(funid);
		 pgNameList.add(program.getPgName());
	}
	map.put("pgNameList", pgNameList);
	
	return map;
}
@RequestMapping("/deleteFunctionById")
public @ResponseBody Map<String,Object>deleteFunctionById(HttpServletRequest request){
	Map<String, Object> map = new HashMap<String, Object>(); 
	String id=request.getParameter("id");
	if(id!=null){
		long funId=Long.valueOf(id);
		funService.deleteFunctionById(funId);
		versionrelationService.deleteVersionRelationByFunId(funId);//版本功能表中删除功能
		programModuleService.deleteProgramModuleByFunId(funId);//功能程序中删除功能
		}
	String pagesize=request.getParameter("pagesize");
	   int pageSize=Integer.valueOf(pagesize);
	   String pagenumber=request.getParameter("pagenumber");
	   int pageNumber=1;
	   if(pagenumber!=""){
		   pageNumber=Integer.valueOf(pagenumber);
	   }//页面信息
	List<FunctionModule>AllFunList=funService.getAllFunList();
	  Page page = new Page(AllFunList.size(), pageNumber); 
	  page.setPageSize(pageSize);
	   int endpos=page.getStartPos()-1+page.getPageSize();
	List<FunctionModule>AllFunList1=funService.getFunctionListByCriteria(page.getStartPos(), endpos) ;
	  map.put("page", page);  
      map.put("list", AllFunList1);
	return map;
}
@RequestMapping("/seePgEdition")
public @ResponseBody Map<String,Object>  seePgEdition(HttpServletRequest request){
	Map<String, Object> map = new HashMap<String, Object>(); 
	String id=request.getParameter("id");
	List<ProgramModule> pgModuleList=new ArrayList();
	List<Long> pgIdList=new ArrayList();
	List pgNameList=new ArrayList();
	List pgEditionList=new ArrayList();
	if(id!=null){
		//根据功能Id找到对应程序
		long funid=Long.valueOf(id);
		pgModuleList=programModuleService.getProgramModuleListByMdId(funid);
	for (ProgramModule  pgModule : pgModuleList) {
		if(pgModule!=null){
			pgIdList.add(pgModule.getPdId());
		}
	}
for (Long pgId : pgIdList) {
	//根据id寻找程序
	Program program=pgService.getProgramById(pgId);
	if(program!=null){
		pgNameList.add( program.getPgName());
		pgEditionList.add(program.getPgEdition());
	}
}
map.put("pgNameList", pgNameList);
map.put("pgEditionList", pgEditionList);
		
	}
	return map;
	
}
@RequestMapping("/exportFunctionList")
public @ResponseBody Map<String,Object> exportExcel(HttpSession session,HttpServletRequest request,HttpServletResponse response) throws Exception{  
	  Map<String, Object> map = new HashMap<String, Object>(); 
	  String startDate=request.getParameter("startDate");
	  String endDate=request.getParameter("endDate");
	  String functionName=request.getParameter("functionName");
	  String typeName=request.getParameter("typetest");
	  String  testName=request.getParameter("testname");
	  if(!endDate.equals("")){
			endDate=endDate+" "+"23:59:59";
			}
	  if(typeName.equals("请选择")){
		  typeName="";
	  }
	  if( testName.equals("请选择")){
		  testName="";
	  }
		List<FunctionModule> list=funService.getSomeFunctionList(startDate, endDate, functionName, testName);
      String[] title = new String[]{"id","name","typeName","debugFile","pgEdition","istDateFormat","edit","delete"};
      ExcelUtils<FunctionModule> util = new ExcelUtils<FunctionModule>();
      String uploadPath=System.getProperty("catalina.home")+"\\bin\\"+"uploadDir\\";
    	 File uploadfile=new File(uploadPath);
       	 if  (!uploadfile .exists()  && !uploadfile .isDirectory())      
       	 {         
       		 uploadfile.mkdir();    
       	 }   
       	 String filepath=System.getProperty("catalina.home")+"\\bin\\"+"uploadDir/"+"功能列表.xls";
         File file=new File(filepath);
         String fileName="功能列表.xls";  
			boolean isMSIE = HttpUtils.isMSBrowser(request);    
			   if (isMSIE) {    
					 //IE浏览器的乱码问题解决  
					        fileName = URLEncoder.encode(fileName, "UTF-8");    
					   } else {    
					 //万能乱码问题解决  
					        fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");    
					   }     
     	util.exportExceptionExcel(response, request,title, list,fileName);
   	  /* String realName = "功能列表.xls"; 
   	   String contentType = "application/octet-stream"; 
   	 	DownloadRecord dr=new DownloadRecord(realName, filepath, request);
   	   	download d=new download();
   	    if( uploadfile.exists()){
   	  		d.download(realName, filepath, request, response);
   	   	map.put("infor", "版本表导出成功");  
   	    }
   	    else{
   	   	map.put("infor", "版本表导出失败"); 
   	    }
*/

        return map;
 }
@RequestMapping("/ConfirmFunctionById")
public @ResponseBody Map<String,Object> ConfirmFunctionById(HttpServletRequest request){
	Map<String, Object> map = new HashMap<String, Object>(); 
	List<VersionRelation> VersionRelationList1=new ArrayList();
	List<Long> VersionIdList1=new ArrayList();
	List VersionNameList1=new ArrayList();
	List<Long> VersionIdList2=new ArrayList();
	Set 	VersionNameList2=new HashSet();
	String id=request.getParameter("id");
	if(id!=null){
		Long funId=Long.valueOf(id);
		List <VersionRelation> versionRelationList=versionrelationService.getversionrelationByFId(funId);
		for (VersionRelation versionRelation : versionRelationList) {
			if(versionRelation!=null){
				VersionRelationList1=versionrelationService.getversionrelationByVId(versionRelation.getVid());
			}
			System.out.println(VersionRelationList1.size());
			if(VersionRelationList1.size()==1){
				for (VersionRelation versionRelation1 : VersionRelationList1) {
					if(versionRelation1!=null){
						VersionIdList1.add(versionRelation1.getVid());
					}
				}
			}
			if(VersionRelationList1.size()>1){
				for (VersionRelation versionRelation2 : VersionRelationList1) {
					if(versionRelation2!=null){
						VersionIdList2.add(versionRelation2.getVid());
					}
				}
			}
		}
		if(VersionIdList1.size()>0){
			for (Long verId :VersionIdList1) {
				//FunctionModule fun=funService.getFunction(funId);
				InstallVersion version=installVersionService.getVersionById(verId);
				if(version!=null){
					VersionNameList1.add(version.getVerName());
				}
			}
			}
		if(VersionIdList2.size()>0){
			for (Long verId :VersionIdList2) {
				//FunctionModule fun=funService.getFunction(funId);
				InstallVersion version=installVersionService.getVersionById(verId);
				if(version!=null){
					VersionNameList2.add(version.getVerName());
				}
			}
			}
		map.put("VersionNameList1", VersionNameList1);
		map.put("VersionNameList2", VersionNameList2);
		map.put("versionRelationList", versionRelationList);
	}
	System.out.println(VersionNameList2);
	System.out.println(VersionNameList1);
	return map;
}
@RequestMapping("/progress")  
public void uploadFile(HttpServletRequest request,HttpServletResponse response,  
                       @RequestParam("file") CommonsMultipartFile file) throws IOException {  
     response.setContentType("text/html");  
     response.setCharacterEncoding("GBK");  
     PrintWriter out;  
     boolean flag = false;  
     if (file.getSize() > 0) {  
          //文件上传的位置可以自定义  
         flag = FileUploadUtil.uploadFile(request, file);  
     } 
     out = response.getWriter();  
     if (flag == true) {  
        out.print("1");  
     } else {  
        out.print("2");  
     }  
}  
@RequestMapping("/progress1")  
public void uploadFile1(HttpServletRequest request,HttpServletResponse response,  
                       @RequestParam CommonsMultipartFile file) throws IOException {  
     response.setContentType("text/html");  
     response.setCharacterEncoding("GBK");  
     PrintWriter out;  
     boolean flag = false;  
     System.out.println(file.getOriginalFilename());
     if (file.getSize() > 0) {  
          //文件上传的位置可以自定义  
         flag = FileUploadUtil.uploadFile(request, file);  
     } 
     out = response.getWriter();  
     if (flag == true) {  
        out.print("1");  
     } else {  
        out.print("2");  
     }  
}  
}