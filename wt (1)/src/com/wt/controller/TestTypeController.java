package com.wt.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import page.Page;

import com.wt.bean.FunctionModule;
import com.wt.bean.Role;
import com.wt.bean.TestCode;
import com.wt.bean.TestType;
import com.wt.serviceimp.RoleService;
import com.wt.serviceimp.TestCodeService;
import com.wt.serviceimp.TestTypeService;
@Controller
@RequestMapping("/testtype")
public class TestTypeController {
	@Autowired
private  TestTypeService testTypeService;
	@Autowired
	private RoleService roleService;
	@Autowired
	private TestCodeService testCodeService;
	@RequestMapping("/querytesttype")
	public String loginError(HttpServletRequest request){
		  return "loginerror";
	}
@RequestMapping("/querytesttype/{userId}")
 public String queryTestType(HttpServletRequest request,Map<String, Object> map,@PathVariable("userId")long userId){
	 Role role=roleService.getRoleByRoleId(userId);
	  String remark=role.getRemark();
	 List<TestType> testTypeAllList1=testTypeService.getTestTypeAllList();
	 List<TestType> testTypeAllList=testTypeService.getTestTypeByCriteria(1, 10);
	 Page page = new Page( testTypeAllList1.size(), 1);
	 request.setAttribute("testTypeAllList", testTypeAllList);
	 request.setAttribute("testTypeAllList1", testTypeAllList1);
	 map.put("page", page);  
	 request.setAttribute("userType", remark);
	 request.setAttribute("userid", userId);
	 map.put("list", testTypeAllList);
	 return "/testtypequery";
 }
@RequestMapping("/protecttesttype/{userId}")
public String toaddTestType(HttpServletRequest request,@PathVariable("userId")long userId){
	request.setAttribute("userid", userId);
	return "testtypeadd";
}
@RequestMapping("/protecttestcode/{userId}")
public String toaddTestCode(HttpServletRequest request,@PathVariable("userId")long userId){
	request.setAttribute("userid", userId);
	 List<TestType> testTypeAllList=testTypeService.getTestTypeAllList();
	 request.setAttribute("testtypeList", testTypeAllList);
	 System.out.println(testTypeAllList.size());
	return "testcodeadd";
}
@RequestMapping("/protecttesttype")
public String toaddTestType(HttpServletRequest request){
	return "loginerror";
}
@RequestMapping("/protecttestcode")
public String toaddTestCode(HttpServletRequest request){
	return "loginerror";
}
@RequestMapping("/queryByName")
public@ResponseBody Map<String,Object> TestTypeList(HttpServletRequest request){
	String pagesize=request.getParameter("pagesize");
	   int pageSize=Integer.valueOf(pagesize);
	   String pagenumber=request.getParameter("pagenumber");
	   int pageNumber=1;
	   if(pagenumber!=""){
		   pageNumber=Integer.valueOf(pagenumber);
	   }
	   String listcount=request.getParameter("listcount");
	   int listCount=Integer.valueOf(listcount);
	    String testTypeName = request.getParameter("typetest");
		String startDate= request.getParameter("startDate");
		String endDate= request.getParameter("endDate");
		String endDate1=null;
		if(endDate!=""){
		endDate1=endDate+" "+"23:59:59";
		}
		
		 List<TestType>testTypeAllList=testTypeService.getSomeTestType(testTypeName, startDate, endDate1);
		 int listSize=testTypeAllList.size();
		 Page page = new Page(testTypeAllList.size(), pageNumber); 
	 	   page.setPageSize(pageSize);
	 	   page.setPageNow(pageNumber);
	 	   int pageCount=page.getTotalPageCount();
	 	   int endpos=page.getStartPos()-1+page.getPageSize();
	       int  endPos=(endpos<=listSize)?endpos:listSize;
	       System.out.println("此次查询list的总数"+listSize);
	        System.out.println("理论结点数"+endpos);
	        System.out.println("此次查询结点"+endPos);
	        System.out.println("-----------------");
		List<TestType> testTypeList=testTypeService.getSomeTestTypeByCriteria(testTypeName, startDate, endDate1, page.getStartPos(), endPos);
		int listsize=testTypeAllList.size();
		 //Page page = new Page(testTypeAllList.size(), 1);
		    request.setAttribute("page", page);
		    Map<String, Object> map = new HashMap<String, Object>(); 
		    map.put("page", page);  
		    map.put("typelist", testTypeList);
		    map.put("listsize", listsize);
	 request.setAttribute("testTypeAllList", testTypeList);
	 return map;
}
@RequestMapping("/inserttesttype")
public String insertTestType(HttpServletRequest request,HttpServletResponse response,TestType testType) throws IOException{
	
		String typeName = request.getParameter("testTypeName");
		String remark = request.getParameter("testTypeRemark");
		testType.setTypeName(typeName);
		testType.setRemark(remark);
		testTypeService.insertTestType(testType);
		 JSONArray json=JSONArray.fromObject(testType);
		   response.getWriter().write(json.toString());
		   response.getWriter().flush();
	 return null;
}
@RequestMapping("/inserttestcode")
public String inserttestcode(HttpServletRequest request,HttpServletResponse response) throws IOException{
	String typeId=request.getParameter("typeid");
	String testname=request.getParameter("testname");
	String remark=request.getParameter("remark");
	long typeid=0;
	if(typeId!=null){
		typeid=Long.valueOf(typeId);
	}
	TestCode testCode=new TestCode();
	testCode.setRemark(remark);
	testCode.setTestName(testname);
	testCode.setTypeId(typeid);
	System.out.println(typeId+testname+remark);
	testCodeService.insertTestCode(testCode);
	JSONArray json=JSONArray.fromObject(testCode);
	   response.getWriter().write(json.toString());
	   response.getWriter().flush();
	
	return null;
}
@RequestMapping("/updatetesttype")
public String updateTestType(HttpServletRequest request,TestType testtype,Model model){
	String testId=request.getParameter("typeId");
	String userId=request.getParameter("userid");
	long userid=Long.valueOf(userId);
	long typeId= Long.parseLong(testId);
	TestType testType=testTypeService.getTestType(typeId);
	model.addAttribute("testType",testType);
    request.setAttribute("userid", userid);
	return "/testtypeupdate";
}
@RequestMapping("/doupdatetesttype")
public String doupdateTestType(HttpServletRequest request,HttpServletResponse response,TestType testType) throws IOException{
		String typeid = request.getParameter("testTypeId");
		String typeName = request.getParameter("testTypeName");
		String remark = request.getParameter("testTypeRemark");
		Date date=new Date();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String update = df.format(date);
		long typeId= Long.parseLong(typeid);
		testType=testTypeService.getTestType(typeId);
		testType.setTypeName(typeName);
		testType.setRemark(remark);
		testType.setTypeId(typeId);
		testType.setNowDate(update);
		testTypeService.updateTestType(testType, typeId, typeName, remark,update);
		 JSONArray json=JSONArray.fromObject(testType);
		 response.getWriter().write(json.toString());
		 response.getWriter().flush();
	return null;
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
   //  System.out.println("endPos"+endPos);
	   List<TestType> testTypeList=testTypeService.getTestTypeByCriteria(page.getStartPos(), endPos);
	   int listsize=testTypeList.size();
	   Map<String, Object> map = new HashMap<String, Object>();  
	   map.put("testtypelist",testTypeList);
	   map.put("pageCount",pageCount);
	   map.put("page",page);
	   map.put("listsize",listsize);
	   return map;
}
@RequestMapping(value="/querySomeByCriteria", method = RequestMethod.POST)
public @ResponseBody Map<String,Object> getSomePageCount(HttpServletRequest request,HttpServletResponse response) throws IOException{
	
	String pagesize=request.getParameter("pagesize");
	   int pageSize=Integer.valueOf(pagesize);
	   String pagenumber=request.getParameter("pagenumber");
	   int pageNumber=Integer.valueOf(pagenumber);
	   String listcount=request.getParameter("listcount");
	   int listCount=Integer.valueOf(listcount);
     String testTypeName = request.getParameter("typetest");
		String startDate= request.getParameter("startDate");
		String endDate= request.getParameter("endDate");
		String endDate1=null;
		if(endDate!=""){
		endDate1=endDate+" "+"23:59:59";
		}
		List<TestType> typeList1=testTypeService.getSomeTestType(testTypeName, startDate, endDate1);
		int listSize=typeList1.size();
		  Page page = new Page(typeList1.size(), pageNumber); 
		   page.setPageSize(pageSize);
		   page.setPageNow(pageNumber);
		   int pageCount=page.getTotalPageCount();
	     int endpos=page.getStartPos()-1+page.getPageSize();
	     int endPos=(endpos<=listSize)?endpos:listSize;
	     System.out.println("此次查询list的总数"+listSize);
	        System.out.println("理论结点数"+endpos);
	        System.out.println("此次查询结点"+endPos);
	        System.out.println("-----------------");
		List<TestType> typeList2=testTypeService.getSomeTestTypeByCriteria(testTypeName, startDate, endDate1, page.getStartPos(), endPos);
		int listsize=typeList2.size();
		   Map<String, Object> map = new HashMap<String, Object>();  
		   map.put("typelist",typeList2);
		   map.put("pageCount",pageCount);
		   map.put("page",page);
		   map.put("listsize",listsize);
	   return map;
}
@RequestMapping("/deleteTestTypeById")
public @ResponseBody Map<String,Object> deleteTestTypeById(HttpServletRequest request){
	//public String  deleteVersionById(HttpServletRequest request){
	  Map<String, Object> map = new HashMap<String, Object>(); 
	  
	  String pagesize=request.getParameter("pagesize");
	   int pageSize=Integer.valueOf(pagesize);
	   String pagenumber=request.getParameter("pagenumber");
	   int pageNumber=1;
	   if(pagenumber!=""){
		   pageNumber=Integer.valueOf(pagenumber);
	   }
	  String  id=request.getParameter("id");
	  if(id!=null){
		 long  testTypeId=Long.valueOf(id);
		 testTypeService.deleteTestTypeById(testTypeId);
	  }
	  List<TestType> testTypeAllList1=testTypeService.getTestTypeAllList();
	  Page page = new Page( testTypeAllList1.size(),pageNumber);
	  page.setPageSize(pageSize);
	   int endpos=page.getStartPos()-1+page.getPageSize();
		List<TestType> testTypeAllList=testTypeService.getTestTypeByCriteria(page.getStartPos(), endpos);
		 map.put("page", page);  
		 map.put("list", testTypeAllList);

return map;
}
}