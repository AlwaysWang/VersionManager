package com.wt.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.io.FileUtils;
import org.apache.ibatis.annotations.Param;
import org.apache.tools.ant.types.CommandlineJava.SysProperties;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
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
import org.springframework.web.servlet.ModelAndView;

import page.ExcelUtils;
import page.HttpUtils;
import page.Page;

import com.wt.bean.FunctionModule;
import com.wt.bean.InstallVersion;
import com.wt.bean.Program;
import com.wt.bean.ProgramModule;
import com.wt.bean.Role;
import com.wt.bean.TestCode;
import com.wt.bean.TestType;
import com.wt.bean.UserInfo;
import com.wt.bean.VersionRelation;
import com.wt.serviceimp.FunctionService;
import com.wt.serviceimp.InstallVersionService;
import com.wt.serviceimp.ProgramModuleService;
import com.wt.serviceimp.ProgramService;
import com.wt.serviceimp.RoleService;
import com.wt.serviceimp.TestCodeService;
import com.wt.serviceimp.TestTypeService;
import com.wt.serviceimp.UserInfoService;
import com.wt.serviceimp.VersionRelationService;

import fileoperateutil.DownloadRecord;
import fileoperateutil.FileConbine;
import fileoperateutil.FileOperateUtil;
import fileoperateutil.ZipCompressor;
import fileoperateutil.download;

@Controller
@RequestMapping("/installVersion")
public class InstallVersionController extends BaseController{
	@Autowired
	private InstallVersionService installVersionService;
	@Autowired
	private  TestTypeService testTypeService;
	@Autowired
	private TestCodeService testCodeService;
	@Autowired
	private UserInfoService userService;
	@Autowired
	private FunctionService funService;
	@Autowired
	private RoleService roleService;
	@Autowired
	private VersionRelationService versionrelationService;
	@Autowired
	private ProgramModuleService programModuleService;
	@Autowired
	private ProgramService pgService;
	  @RequestMapping("/queryInsatllVersion/")
	  public String loginError(HttpServletRequest request){
		  return "loginerror";
	  }
   @RequestMapping("/queryInsatllVersion/{userId}")
   public String getInstallAllList(HttpServletRequest request,Map<String, Object> map,Model model,@PathVariable("userId")long userId){
	 Role role=roleService.getRoleByRoleId(userId);
	  String remark=role.getRemark();
	 List<TestType> testTypeAllList=testTypeService.getTestTypeAllList();
	   request.setAttribute("testTypeAllList", testTypeAllList);
	   List<InstallVersion>installAllList=installVersionService.getInstallVersionAllList();
		 Page page = new Page(installAllList.size(), 1); 
		 List<InstallVersion>installAllList1=installVersionService.getInstallVersionListByCriteria(1,10);
		map.put("page", page);  
	    map.put("list", installAllList1);
	   for (InstallVersion installVersion : installAllList){
	}
	   request.setAttribute("installAllList", installAllList1);
	   request.setAttribute("userType", remark);
	   request.setAttribute("userid", userId);
	   String file=request.getSession().getServletContext()  
       .getRealPath("/") ;
	   String file1=System.getProperty("catalina.home")+"\\bin\\"+"uploadDir/"; 
	   return "/versionquery";
   }
   //添加版本
@RequestMapping("/insertInversion")
   public String insertInstallVersion(HttpServletRequest request,@RequestParam  MultipartFile file1,Map<String, Object> map,@RequestParam(value = "funList")String[] data) throws Exception{
	String uploadPath=System.getProperty("catalina.home")+"\\bin\\"+"uploadDir\\";
	 File uploadfile=new File(uploadPath);
	 if  (!uploadfile .exists()  && !uploadfile .isDirectory())      
	 {         
		 uploadfile.mkdir();    
	 }   
	String verCode =request.getParameter("verCode");
	String versionName = request.getParameter("versionname");
	String description=request.getParameter("description");
	 //根据功能id去功能程序表中寻找对应的程序
	List pgIdList=new ArrayList();
	List<String> list=new ArrayList();
	int length=0;
	String outFile=System.getProperty("catalina.home")+"\\bin\\"+"uploadDir/"+verCode+"所有功能程序.zip"; 
	//操作说明存入数据库
	String outFile1=outFile.replaceAll("\\\\", "\\\\\\\\");
	//表示文件路径
	String outFile2=outFile.replaceAll("\\\\", "/");
	String filePath=file1.getOriginalFilename();
	/*String debugfile= request.getSession().getServletContext()  
            .getRealPath("/")  
            + FileOperateUtil.UPLOADDIR+filePath;  */
	String debugfile=System.getProperty("catalina.home")+"\\bin\\"+"uploadDir/"+filePath;
	debugfile= debugfile.replaceAll("\\\\", "\\\\\\\\");
	InstallVersion version=new InstallVersion();
	version.setVerCode(verCode);
	version.setVerName(versionName);
	version.setRemark(description);
	version.setOperName(debugfile);
	version.setSavePath(outFile1);
	//通过程序list获得对应程序路径
	//你好
    for (int i = 0; i < data.length; i++) {
		long mdId=Long.valueOf(data[i]);
		 List<ProgramModule> programModule=programModuleService.getProgramModuleListByMdId(mdId);
		  for (ProgramModule pm : programModule) {
			  Program program=pgService.getProgramById(pm.getPdId());
			if(program!=null){
			  list.add(program.getStoragePath());
			  list.add(program.getProgdisc());
			
		}
		  }
	}
    for (int i = 0; i < data.length; i++) {
		long mdId=Long.valueOf(data[i]);
		FunctionModule fun=funService.getFunction(mdId);
		if(fun!=null){
		list.add(fun.getDebugFile());
		}
	}
    List listTemp = new ArrayList();  
    for(int i=0;i<list.size();i++){  
        if(!listTemp.contains(list.get(i))){  
            listTemp.add(list.get(i));  
        }  
    }  
    String []filePaths=(String[])listTemp.toArray(new String[0]);
    File srcfile[]=new File[filePaths.length];
    for (int i = 0; i < filePaths.length; i++) {
		File file=new File(filePaths[i]);
		srcfile[i]=file;
	}
   // System.out.println("上传的压缩包"+filePaths);
  //获得对应程序并上传
    ZipCompressor zip=new ZipCompressor(outFile2);
     zip.compress(filePaths); 
     for (int i = 0; i < filePaths.length; i++) {
	}
    installVersionService.insertInstallVersion(version);
    //String uploadDir = request.getSession().getServletContext().getRealPath("/") +"uploadDir/";
    String uploadDir= System.getProperty("catalina.home")+"\\bin\\"+"uploadDir/"; 
	File file=new File(uploadDir,filePath);
	file1.transferTo(file);
	//向版本表中寻找刚添加的version，获取id
    	InstallVersion newversion=installVersionService.getVersionByMaxId();
    	//向功能版本表中添加关联关系
    	for (int i = 0; i < data.length; i++) {
    			String  mdid=data[i];
    			long mdId=Long.valueOf(mdid);
    			long vId=newversion.getId();
    			VersionRelation versionrelation=new VersionRelation();
    			versionrelation.setMdid(mdId);
    			versionrelation.setVid(vId);
    			versionrelationService.insertVersionRelationDao(versionrelation);
    		}
    	//返回list页面的准备
    	 List<TestType> testTypeAllList=testTypeService.getTestTypeAllList();
  	   request.setAttribute("testTypeAllList", testTypeAllList);
  	   List<InstallVersion>installAllList=installVersionService.getInstallVersionAllList();
  		 Page page = new Page(installAllList.size(), 1); 
  		 List<InstallVersion>installAllList1=installVersionService.getInstallVersionListByCriteria(1,10);
  		map.put("page", page);  
  	    map.put("list", installAllList1);
  	   request.setAttribute("installAllList", installAllList1);
   return "/versionquery";
   }
   @RequestMapping(value="/querySomeVersionByQuery", method = RequestMethod.POST)
   public @ResponseBody Map<String,Object>  querySomeVersionByQuery(HttpServletRequest request) throws IOException{
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
		String typeName=request.getParameter("typetest");
		String testCode=request.getParameter("testcode");
		if(typeName.endsWith("请选择")){
			typeName="";
		}
		if(testCode.endsWith("请选择")){
			testCode="";
		}
		List<InstallVersion> installAllList=new ArrayList();
		List<InstallVersion> installAllList1=new ArrayList();
    	installAllList=installVersionService.getSomeInstallVersionList(startDate, endDate1, typeName, testCode);
    	int listSize=installAllList.size();
    	Page page = new Page(installAllList.size(), pageNumber); 
 	   page.setPageSize(pageSize);
 	   page.setPageNow(pageNumber);
 	   int pageCount=page.getTotalPageCount();
         int endpos=page.getStartPos()-1+page.getPageSize();
         int endPos=10;
        //endPos=(endpos<=listSize)?endpos:listSize;
         endPos=endpos;
    	installAllList1=installVersionService.getSomeInstallVersionListByCriteria(startDate, endDate1, typeName,  testCode,  page.getStartPos(), endPos);
		int listsize=installAllList.size();
	    request.setAttribute("page", page);
	    Map<String, Object> map = new HashMap<String, Object>(); 
	    map.put("page", page);  
	    map.put("list", installAllList1);
	    map.put("listsize", listsize);
	   return map;
   }
   @RequestMapping("/updateVersion")
	   public String updateVersion(HttpServletRequest request,Model model){
	    long userId=1;
		String id=request.getParameter("id");
		long Id=Long.valueOf(id);
		InstallVersion version=installVersionService.getVersionById(Id);
		model.addAttribute("version",version);
		List<InstallVersion>installAllList=installVersionService.getInstallVersionAllList();
		request.setAttribute("installAllList", installAllList);
		List<FunctionModule>funList=funService.getAllFunList();
		   request.setAttribute("funList", funList);
		   List<VersionRelation> vrList=versionrelationService.getversionrelationByVId(Id);
		   List funIdList=new ArrayList();
		   for (VersionRelation vr : vrList) {
			funIdList.add(vr.getMdid());
		}
		   request.setAttribute("funIdList", funIdList);
		   request.setAttribute("userid", userId);
		   request.setAttribute("versionId", Id);
		   return "/versionupdate";
	   }
   @RequestMapping("doupdateInversion")
   public String doupdate(HttpServletRequest request,@RequestParam  MultipartFile file1,Map<String, Object> map,@RequestParam(value = "funList")String[] data,@RequestParam(value = "funIdList")String[] data1) throws Exception{
	   
	   String uploadPath=System.getProperty("catalina.home")+"\\bin\\"+"uploadDir\\";
		 File uploadfile=new File(uploadPath);
		 if  (!uploadfile .exists()  && !uploadfile .isDirectory())      
		 {         
			 uploadfile.mkdir();    
		 } 
	   String ischange=request.getParameter("isChange");
	   String id= request.getParameter("id");
	   long Id=Long.valueOf(id);
	   InstallVersion version=installVersionService.getVersionById(Id);
	 //对应功能没有改变
	   List funIdList=new ArrayList();
	   String verCode =request.getParameter("verCode");
		String versionName = request.getParameter("versionname");
		String description=request.getParameter("description");
		version.setVerCode(verCode);
		version.setRemark(versionName);
		String filePath=file1.getOriginalFilename();
		String debugfile=null;
		if(filePath!=""){
			 /* debugfile= request.getSession().getServletContext()  
		             .getRealPath("/")  
		             + FileOperateUtil.UPLOADDIR+filePath;  */
			debugfile=System.getProperty("catalina.home")+"\\bin\\"+"uploadDir/"+filePath; 
				debugfile= debugfile.replaceAll("\\\\", "\\\\\\\\");
				version.setOperName(debugfile);
				debugfile=version.getOperName();
				//String uploadDir = request.getSession().getServletContext().getRealPath("/") +"uploadDir/";
				String uploadDir= System.getProperty("catalina.home")+"\\bin\\"+"uploadDir/"; 
				File file=new File(uploadDir,filePath);
				file1.transferTo(file);
				}
		else{
			debugfile=version.getOperName();
			version.setOperName(debugfile);
		}
		//版本对应功能改变或者功能对应程序改变
		     String savePath=null;
			 List list=new ArrayList();
			 /*String outFile=request.getSession().getServletContext()  
			            .getRealPath("/")+ FileOperateUtil.UPLOADDIR+verCode+".zip"; */
			 String outFile=System.getProperty("catalina.home")+"\\bin\\"+"uploadDir/"+verCode+"所有功能程序.zip"; 
			//存入数据库
				String outFile1=outFile.replaceAll("\\\\", "\\\\\\\\");
				//表示文件路径
				String outFile2=outFile.replaceAll("\\\\", "/");
				version.setSavePath(outFile1);
				savePath=version.getSavePath();
			    for (int i = 0; i < data.length; i++) {
					long mdId=Long.valueOf(data[i]);
					 List<ProgramModule> programModule=programModuleService.getProgramModuleListByMdId(mdId);
					  for (ProgramModule pm : programModule) {
						  Program program=pgService.getProgramById(pm.getPdId());
						if(program!=null){
						  list.add(program.getStoragePath());
						  list.add(program.getProgdisc());
						
					}
					  }
				}
			    for (int i = 0; i < data.length; i++) {
					long mdId=Long.valueOf(data[i]);
					FunctionModule fun=funService.getFunction(mdId);
					if(fun!=null){
				   list.add(fun.getDebugFile());
					}
				}
			    List listTemp = new ArrayList();  
			    for(int i=0;i<list.size();i++){  
			        if(!listTemp.contains(list.get(i))){  
			            listTemp.add(list.get(i));  
			        }  
			    }  
			    
			    
			    
			    String []filePaths=(String[])listTemp.toArray(new String[0]);
			    File srcfile[]=new File[filePaths.length];
			    for (int i = 0; i < filePaths.length; i++) {
					File file=new File(filePaths[i]);
					srcfile[i]=file;
				}
			    //获得对应程序并形成压缩文件上传
			     ZipCompressor zip=new ZipCompressor(outFile2);
			     zip.compress(filePaths); 
		installVersionService.updateVersion(version, verCode,versionName,description,debugfile,savePath,Id);
		versionrelationService.deleteVersionRelationByVId(Id);
		 for (int i = 0; i < data.length; i++) {
 			String  mdid=data[i];
 			long mdId=Long.valueOf(mdid);
 			VersionRelation versionrelation=new VersionRelation();
 			versionrelation.setMdid(mdId);
 			versionrelation.setVid(Id);
 			versionrelationService.insertVersionRelationDao(versionrelation);	
 		}
		List<InstallVersion>installAllList=installVersionService.getInstallVersionAllList();
	   request.setAttribute("installAllList", installAllList);
	   List<InstallVersion>installAllList1=installVersionService.getInstallVersionListByCriteria(1,10);
		 List<TestType> testTypeAllList=testTypeService.getTestTypeAllList();
		   request.setAttribute("testTypeAllList", testTypeAllList);
	    Page page = new Page(installAllList.size(), 1); 
	   map.put("page", page);  
       map.put("list", installAllList1);
	   request.setAttribute("installAllList", installAllList1);
	   return "/versionquery";
   }
   //下载操作说明
   @RequestMapping("downloadtext")
   public String download(HttpServletRequest request,HttpServletResponse response) throws Exception{
	   String savePath = request.getParameter("savePath1");
      String verCode=request.getParameter("verCode");
	        String suffix = savePath.substring(savePath.lastIndexOf(".") + 1); 
	        System.out.println(suffix+"suffix");
	        String realName = verCode+"操作说明."+suffix;
       String contentType = "application/octet-stream"; 
   	download d=new download();
   	DownloadRecord dr=new DownloadRecord(realName, savePath, request);
    File dir = new File(savePath);
    if( dir.exists()){
  		d.download(realName, savePath, request, response);
    }
    else{
    	
    	return "/error";
    }
  	 	
	   return "/error";
   }
 //下载程序
   @RequestMapping("downloadProgram")
   public String downloadProgram(HttpServletRequest request,HttpServletResponse response) throws Exception{
	   String storagePath = request.getParameter("storagePath1");
	   String verCode=request.getParameter("verCode");
	    String suffix = storagePath.substring(storagePath.lastIndexOf(".") + 1);  
	   String realName = verCode+"所有程序.zip"; 
	   String contentType = "application/octet-stream"; 
	 	DownloadRecord dr=new DownloadRecord(realName, storagePath, request);
	   	download d=new download();
	    File dir = new File(storagePath);
	    if( dir.exists()){
	  		d.download(realName, storagePath, request, response);
	    }
	    else{

	    	return "/error";
	    }
   return "/error";
   }
   //�����ҳ��
   @RequestMapping("protectInsatllVersion/{userId}")
   public String protectVersion(HttpServletRequest request,@PathVariable long userId){
	   List<InstallVersion>installAllList=installVersionService.getInstallVersionAllList();
	   request.setAttribute("installAllList", installAllList);
	   List<FunctionModule>funList=funService.getAllFunList();
	   request.setAttribute("funList", funList);
	   request.setAttribute("userid", userId);
	   return "/versionadd";
   }
   @RequestMapping("protectInsatllVersion")
   public String protectVersion(HttpServletRequest request){
	   return "/loginerror";
   }
   @RequestMapping(value="/typetest")
   public   @ResponseBody Map<String,Object> getTestcode(HttpServletRequest request,HttpServletResponse response) throws IOException{
	   String testTypeName=request.getParameter("typename");
	   response.setCharacterEncoding("UTF-8");
	   List<TestCode> testCodeList=testCodeService.getTestCodeListByTypeName(testTypeName);
	   List list=new ArrayList();
	   List list1=new ArrayList();
	   for (TestCode testCode : testCodeList) {
		   String testname=testCode.getTestName();
		   list.add(testname);
	   }
	   for(TestCode testcode:testCodeList){
		   long code=testcode.getCode();
		   list1.add(code);
	   } 
	   Map<String, Object> map = new HashMap<String, Object>(); 
	   map.put("list", list);
	   map.put("list1", list1);
	   JSONArray json=JSONArray.fromObject(list);
	   response.getWriter().flush();
	   return map;
   }

   @RequestMapping(value="/querySomeListByCriteria", method = RequestMethod.POST)
   public @ResponseBody Map<String,Object> getPageCountSome(HttpServletRequest request,HttpServletResponse response) throws IOException{
	   String startDate= request.getParameter("startDate");
		String endDate= request.getParameter("endDate");
		String endDate1=null;
		if(endDate!=""){
		endDate1=endDate+" "+"23:59:59";
		}
		String typeName=request.getParameter("typetest");
		String testCode=request.getParameter("testcode");
		if(typeName.equals("请选择")){
			typeName="";
		}
		if(testCode.equals("请选择")){
			testCode="";
		}
	   String pagesize=request.getParameter("pagesize");
	   int pageSize=Integer.valueOf(pagesize);
	   String pagenumber=request.getParameter("pagenumber");
	   int pageNumber=Integer.valueOf(pagenumber);
	   String listcount=request.getParameter("listcount");
	 //对象list数量
	    int  VersionCount=Integer.valueOf(listcount);
	    //查询list数量
	  //int listCount=installVersionService.getListCount();
	   Page page = new Page(VersionCount, pageNumber); 
	   page.setPageSize(pageSize);
	   page.setPageNow(pageNumber);
	   int pageCount=page.getTotalPageCount();
        List<InstallVersion> installAllList=new ArrayList();
		List<InstallVersion> installAllList1=new ArrayList();
    	installAllList=installVersionService.getSomeInstallVersionList(startDate, endDate1, typeName, testCode);
    	int listSize=installAllList.size();
    	System.out.println("此次查询list的总数"+listSize);
    	int endpos=page.getStartPos()-1+page.getPageSize();
      //  int  endPos=(endpos<=listSize)?endpos:listSize;
    	int endPos=endpos;
        // System.out.println("此次查询list的总数"+listSize);
        System.out.println("理论结点数"+endpos);
        System.out.println("此次查询结点"+endPos);
        System.out.println("-----------------");
    	installAllList1=installVersionService.getSomeInstallVersionListByCriteria(startDate, endDate1, typeName,  testCode, page.getStartPos(), endPos);
	   int listsize=installAllList1.size();
	   Map<String, Object> map = new HashMap<String, Object>();  
	   map.put("versionlist",installAllList1);
	   map.put("pageCount",pageCount);
	   map.put("page",page);
	   map.put("listsize",listsize);
	   return map;
   }  
   @RequestMapping("/showFunList")
   public @ResponseBody Map<String,Object> showFunList(HttpServletRequest request){
	 //需要获得所有的功能列表以及    功能Id集合    给定id版本对应的功能列表id号集合
	   String funId=request.getParameter("versionId");
	   long Id=0;
	   if(funId!=null){
		   Id=Long.valueOf(funId);
	   }
	   Map<String, Object> map = new HashMap<String, Object>(); 
	 //根据Id号获得对应的功能列表
	   //InstallVersion version=installVersionService.getVersionById(Id);
	   List<VersionRelation> VersionRelationList=versionrelationService.getversionrelationByVId(Id);
	   List<FunctionModule> AllFunList1=funService.getAllFunList();
	   Page page=new Page(AllFunList1.size(),1);
	   page.setPageSize(10);
	   List<FunctionModule> AllFunList=funService.getFunctionListByCriteria(1,10);//默认为10
	   List AllFunIdList=new ArrayList();
	   List FunIdList=new ArrayList();
	   for (VersionRelation VersionRelation :VersionRelationList) {
		   FunIdList.add(VersionRelation.getMdid());
	}
	   for (FunctionModule FunctionModule : AllFunList) {
		   AllFunIdList.add(FunctionModule.getId());
	}
	   map.put("AllFunList", AllFunList);
	   map.put("FunIdList", FunIdList);
	   map.put("AllFunIdList",AllFunIdList);
	   map.put("page",page);
	   return map;
	   
   }
   @RequestMapping("/showtesttype")
   public @ResponseBody Map<String,Object> showtesttype(HttpServletRequest request,HttpServletResponse response){
	   Map<String, Object> map = new HashMap<String, Object>(); 
	   List testTypeIdList=new ArrayList();
	   List testTypeNameList=new ArrayList();
	  List<TestType> testTypeList=testTypeService.getTestTypeAllList();

	for (TestType testType : testTypeList) {
		testTypeIdList.add(testType.getTypeId());
		testTypeNameList.add(testType.getTypeName());
	}
	   map.put("testTypeIdList", testTypeIdList);
	   map.put("testTypeNameList", testTypeNameList);
	   
	   return map;
   }
  @RequestMapping("/querySomeFunListBycriteria")
  public  @ResponseBody Map<String,Object> getFunList(HttpServletRequest request,HttpServletResponse response){
	  Map<String, Object> map = new HashMap<String, Object>(); 
	  List FunIdList=new ArrayList();
	  String pagesize=request.getParameter("pagesize");
	   int pageSize=Integer.valueOf(pagesize);
	   String pagenumber=request.getParameter("pagenumber");
	   int pageNumber=1;
	   if(pagenumber!=""){
		   pageNumber=Integer.valueOf(pagenumber);
	   }//前台页面信息
	   String versionId=request.getParameter("versionId");//版本id
	   String startDate="";
	   String endDate="";
	   String funname = request.getParameter("funname");
	   String testcode=request.getParameter("testcode");
	  if(testcode.equals("请选择")){
		  testcode="";
	  }
	   
	   //查询条件
	  
	   List<FunctionModule> funList2=funService.getSomeFunctionList(startDate, endDate, funname , testcode);//此次请求全部的version
	   Page page=new Page(funList2.size(),pageNumber);
	   page.setPageSize(pageSize);
	   int listSize=funList2.size();
       int endpos=page.getStartPos()-1+page.getPageSize();
     //  int endPos=(endpos<=listSize)?endpos:listSize;
       int endPos=endpos;
       System.out.println("页面的size"+pageSize);
       System.out.println("此次查询list的总数"+listSize);
       System.out.println("理论结点数"+endpos);
       System.out.println("此次查询结点"+endPos);
       System.out.println("-----------------");
	   List<FunctionModule> funList1=funService.getSomeFunctionListByCriteria(startDate, endDate,funname, testcode, page.getStartPos(), endPos);
	 //分页之后的versionlist
	  //向页面需要传递的值   版本对应功能Idlist  分页之后的功能Idlist   分页之后的功能名称list  和page四个值
	  System.out.println(versionId+"versionId");
	   if(versionId!=null){
	   long versionid=Long.valueOf(versionId);
	   List<VersionRelation> VersionRelationList=versionrelationService.getversionrelationByVId( versionid);
	   for (VersionRelation versionRelation : VersionRelationList) {
		   FunIdList.add(versionRelation.getMdid());
	}
	
	   }
	   map.put(" FunIdList",  FunIdList);
	  map.put("funlist", funList1);
	  map.put("page", page);
	  return map;
	  
	  
  }
  @RequestMapping("/saveFunction")
  public @ResponseBody Map<String,Object> saveFunList(HttpServletRequest request){
	  Map<String, Object> map = new HashMap<String, Object>(); 
	  //获得一个funidlist动态变化，向页面传递namelist和idlist
	  String funidList1=request.getParameter("funIdList");
		String d[] = null;
		  List  funIdList=new ArrayList();
		    List <Long> funIdList1=new ArrayList();
		    List funNameList=new ArrayList();
	    if(funidList1!="")
	    	{
	    	 d =funidList1.split(",");
	    	   for (int i = 0; i < d.length; i++) {
	    		   funIdList.add(d[i]);
	    		   funIdList1.add(Long.valueOf(d[i]));
	    		}
	    	}
	    //获得动态的idlist
	    System.out.println(funIdList1.size()+"pgIdList1.size()");
	for (int i = 0; i <funIdList1.size(); i++) {
		FunctionModule function=funService.getFunction(funIdList1.get(i));
		if(function!=null){
			funNameList.add(function.getName());
		}
	}
		  String done=request.getParameter("done");
		   String id=request.getParameter("funid");
		   long funId=0;
		   if(id!=null){
			   funId=Long.valueOf(id);
		   }
		   if(done.equals("1")&&funId!=0&&(!funIdList1.contains(funId))){
			   System.out.println("不存在则添加");
				FunctionModule function=funService.getFunction(funId);
			   //Program program=pgService.getProgramById( pgId);
				funIdList1.add(funId);
				funNameList.add(function.getName());
		   }
		   System.out.println(funId);
		   System.out.println(funIdList1);
		   if(done.equals("0")&&funId!=0&&funIdList1.contains(funId)){
			   System.out.println("存在则删除");
			   FunctionModule function=funService.getFunction( funId);
			   funIdList1.remove(funId);
			   funNameList.remove(function.getName());
		   }
		   System.out.println(funIdList1);
		   System.out.println(funNameList);
	    map.put("list", funIdList1);
	    map.put("funNameList",  funNameList);
		return map;
  }
@RequestMapping("/deleteVersionById")
public @ResponseBody Map<String,Object> deleteVersionById(HttpServletRequest request){
	//public String  deleteVersionById(HttpServletRequest request){
	  Map<String, Object> map = new HashMap<String, Object>(); 
	  
	  String pagesize=request.getParameter("pagesize");
	   int pageSize=Integer.valueOf(pagesize);
	   String pagenumber=request.getParameter("pagenumber");
	   int pageNumber=1;
	   if(pagenumber!=""){
		   pageNumber=Integer.valueOf(pagenumber);
	   }
	  String vid=request.getParameter("id");
	  System.out.println(vid);
	  if(vid!=null){
		  long VId=Long.valueOf(vid);
		  installVersionService.deleteInstallVersionById(VId);
		  versionrelationService.deleteVersionRelationByVId(VId);
	  }
	  List<TestType> testTypeAllList=testTypeService.getTestTypeAllList();
	   request.setAttribute("testTypeAllList", testTypeAllList);
	   List<InstallVersion>installAllList=installVersionService.getInstallVersionAllList();
		 Page page = new Page(installAllList.size(), pageNumber); 
		  page.setPageSize(pageSize);
		   int endpos=page.getStartPos()-1+page.getPageSize();
		 List<InstallVersion>installAllList1=installVersionService.getInstallVersionListByCriteria(page.getStartPos(), endpos);
		map.put("page", page);  
	    map.put("list", installAllList1);
	   request.setAttribute("installAllList", installAllList1);
	  return map;
	
}
  @RequestMapping("/exportVersionList")
  public @ResponseBody Map<String,Object> exportExcel(HttpSession session,HttpServletRequest request,HttpServletResponse response) throws Exception{  
	  Map<String, Object> map = new HashMap<String, Object>(); 
	  String startDate=request.getParameter("startDate");
	  String endDate=request.getParameter("endDate");
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
	  List<InstallVersion> list= installVersionService.getSomeInstallVersionList(startDate, endDate, typeName, testName);
        String[] title = new String[]{"verCode","verName","remark","pgdownload","istDateFormat","edit","delete"};
        ExcelUtils<InstallVersion> util = new ExcelUtils<InstallVersion>();
    	String uploadPath=System.getProperty("catalina.home")+"\\bin\\"+"uploadDir\\";
   	 File uploadfile=new File(uploadPath);
   	 if  (!uploadfile .exists()  && !uploadfile .isDirectory())      
   	 {         
   		 uploadfile.mkdir();    
   	 }   
   	 String filepath=System.getProperty("catalina.home")+"\\bin\\"+"uploadDir/"+"版本列表.xlsx";
        //File file=new File(filepath);
        response.setContentType("application/octet-stream");  
        String fileName="版本列表.xls";  
			boolean isMSIE = HttpUtils.isMSBrowser(request);    
			   if (isMSIE) {    
					 //IE浏览器的乱码问题解决  
					        fileName = URLEncoder.encode(fileName, "UTF-8");    
					   } else {    
					 //万能乱码问题解决  
					        fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");    
					   }     
        //response.setHeader("Content-disposition", "attachment;filename=\"" + "版本列表.xlsx" + "\"");  
    	util.exportExceptionExcel(response,request,title, list,fileName);
  	   String realName = "版本列表.xlsx"; 
  	   String contentType = "application/octet-stream"; 
  	 	/*DownloadRecord dr=new DownloadRecord(realName, filepath, request);
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

  
}