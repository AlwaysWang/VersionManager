package com.wt.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.ibatis.annotations.Param;
import org.apache.tools.ant.types.CommandlineJava.SysProperties;
//import org.junit.runners.Parameterized.Parameters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import page.Page;

import com.itextpdf.text.log.SysoCounter;
import com.wt.bean.FunctionModule;
import com.wt.bean.InstallVersion;
import com.wt.bean.Module;
import com.wt.bean.News;
import com.wt.bean.Role;
import com.wt.bean.RoleModule;
import com.wt.bean.TestCode;
import com.wt.bean.TestType;
import com.wt.bean.UserInfo;
import com.wt.serviceimp.InstallVersionService;
import com.wt.serviceimp.ModuleService;
import com.wt.serviceimp.NewsService;
import com.wt.serviceimp.RoleService;
import com.wt.serviceimp.TestTypeService;
import com.wt.serviceimp.UserInfoService;
import com.wt.serviceimp.RoleModuleService;

@Controller
@RequestMapping("/user")
public class UserInfoController extends BaseController{
	@Autowired
	private InstallVersionService installVersionService;
	@Autowired
	private  TestTypeService testTypeService;
	@Autowired
	private UserInfoService userService;
	@Autowired
	private ModuleService moduleService;
	@Autowired
	private RoleService roleService; 
	@Autowired
	private RoleModuleService RoleModuleService;
	@Autowired
	private NewsService newsService;
	@RequestMapping("/login")
	public String login(HttpServletRequest request, HttpServletResponse response,
			ModelMap model) {
		
		return "/login";
	}
	@RequestMapping("/index")
	public String loginsueccess(HttpServletRequest request,Map<String, Object> map){
		UserInfo user=(UserInfo)request.getSession().getAttribute("loginUser");
		request.getSession().setAttribute("loginUser", user);
	if(user!=null){
 Role role=roleService.getRoleByRoleName(user.getLoginName());
 long userId=role.getRoleId();
 String remark=role.getRemark();
 List<TestType> testTypeAllList=testTypeService.getTestTypeAllList();
   request.getSession().setAttribute("testTypeAllList", testTypeAllList);
   List<InstallVersion>installAllList=installVersionService.getInstallVersionAllList();
	 Page page = new Page(installAllList.size(), 1); 
	 request.getSession().setAttribute("page", page);
	 List<InstallVersion>installAllList1=installVersionService.getInstallVersionListByCriteria(1,10);
	map.put("page", page);  
    map.put("list", installAllList1);
   for (InstallVersion installVersion : installAllList){
}
   request.getSession().setAttribute("installAllList", installAllList1);
   request.getSession().setAttribute("userType", remark);
   request.getSession().setAttribute("userid", userId);
   System.out.println(installAllList1);
	News news=newsService.getNewestNews();
    request.getSession().setAttribute("news", news);
	}
    	return "/home";
	}
   	@RequestMapping("/FindNews/{userid}")
       public String findNews1(HttpServletRequest request,@PathVariable("userid")long userId){
		News news=newsService.getNewestNews();
        request.getSession().setAttribute("news", news);
        return "/mainhome2";
   	}
	@RequestMapping("/FindNews")
    public String findNews(HttpServletRequest request){
		News news=newsService.getNewestNews();
		//List<News> newsList=newsService.getNewsListByMaxDate();
        request.getSession().setAttribute("news", news);
     return "/loginerror";
	}
	@RequestMapping("/index1")
	public String loginsueccess1(HttpServletRequest request,Map<String, Object> map){
		UserInfo user=(UserInfo)request.getSession().getAttribute("loginUser");
		request.getSession().setAttribute("loginUser", user);
	if(user!=null){
 Role role=roleService.getRoleByRoleName(user.getLoginName());
 long userId=role.getRoleId();
 String remark=role.getRemark();
 List<TestType> testTypeAllList=testTypeService.getTestTypeAllList();
   request.getSession().setAttribute("testTypeAllList", testTypeAllList);
   List<InstallVersion>installAllList=installVersionService.getInstallVersionAllList();
	 Page page = new Page(installAllList.size(), 1); 
	 request.getSession().setAttribute("page", page);
	 List<InstallVersion>installAllList1=installVersionService.getInstallVersionListByCriteria(1,10);
	map.put("page", page);  
    map.put("list", installAllList1);
   for (InstallVersion installVersion : installAllList){
}
   request.getSession().setAttribute("installAllList", installAllList1);
   request.getSession().setAttribute("userType", remark);
   request.getSession().setAttribute("userid", userId);
   System.out.println(installAllList1);
	News news=newsService.getNewestNews();
    request.getSession().setAttribute("news", news);
	}
    	return "/home1";
	}
	@RequestMapping("/index2")
	public String loginsueccess2(HttpServletRequest request){
		UserInfo user=(UserInfo)request.getSession().getAttribute("loginUser");
		request.getSession().setAttribute("loginUser", user);
		if(user!=null){
		List<News> newsList=newsService.getNewsListByMaxDate();
        request.setAttribute("newslist", newsList);
		}
			return "/home2";
	
		
	}
	@RequestMapping(value="/loginon", method = RequestMethod.POST)
	public String loginon(HttpServletRequest request, HttpServletResponse response,
			ModelMap model) {
			String userName= request.getParameter("userAccount");
			String userPass= request.getParameter("userPass");
		    UserInfo user=userService.getUserInfo(userName);
		  //  Role role=roleService.getRoleByRoleName(userName);
		    //System.out.println(role.getRemark());
		  //  String password=user.getLoginpass();
		   // String role=user.getUserName();
		     //System.out.println(user.getLoginName());
			if(user!=null){
				 String password=user.getLoginpass();
				 Role role=roleService.getRoleByRoleName(userName);
				 String userType = null;
				 if(role!=null){
				 userType=role.getRemark();
				
				// System.out.println(userType.equals("����Ա"));
				 
				if(password.equals(userPass)){
				    if(userType.equals("超级管理员")){
					outputString(response, "{success:true}");}
				    if(userType.equals("管理员")){
				    	
						outputString(response, "{success2:true}");}
					    
				    if(userType.equals("普通用户")){
						outputString(response, "{success1:true}");}
					    
				    
					Role roleUser=roleService.getRoleByRoleName(user.getLoginName());					
					request.getSession().setAttribute("roleUser", roleUser);
					request.getSession().setAttribute("loginUser", user);
				}
				else{
					outputString(response, "{success:false}");
				}
				 }
				else{
					outputString(response, "{success3:true}");
				}
				
			}
			else{
				outputString(response, "{success:false}");
			}
		
		return null;
	}
	@RequestMapping("/updatepassword")
	public String updatePassword(HttpServletRequest request,HttpServletResponse response){
		String loginName=request.getParameter("loginName");
		UserInfo user=userService.getUserByLoginName(loginName);
		String password=request.getParameter("password");
		String newpassword=request.getParameter("newpassword");
		String newpassword1=request.getParameter("newpassword1");
		//System.out.println("数据中查询的原密码"+user.getLoginpass());
		if(user==null){
			outputString(response, "{nouser:true}");
		}		
		if(user!=null){
			String pass=user.getLoginpass();
			//user.setLoginpass(newpassword);
			//输入密码错误
			if(!(pass.equals(password))){
				//System.out.println("密码错误");
				outputString(response, "{passwrong:true}");
			}
			//新旧密码相同
			if(newpassword.equals(pass)){
				outputString(response, "{passsame:true}");
			}
			//两次输入密码不一样
			if(!(newpassword.equals(newpassword1))){
				outputString(response, "{passsamewrong:true}");
			}
			//输入密码正确且两次输入密码一样且新旧密码 不同
			if(pass.equals(password)&&newpassword.equals(newpassword1)&&(!newpassword.equals(pass))){
				user.setLoginpass(newpassword);
				outputString(response, "{success:true}");
				request.getSession().setAttribute("loginUser", user);
			}
		}		
		
		return null;
	}
	@RequestMapping("/doupdatepassword")
	public String doupdatePassword(HttpServletRequest request,HttpServletResponse response){
		//	System.out.println("去修改密码了");
		UserInfo user=(UserInfo)request.getSession().getAttribute("loginUser");
		String loginPass=user.getLoginpass();
		String loginName=user.getLoginName();
		//System.out.println(loginPass);
		//System.out.println(loginName);
		userService.updatePass(user, loginPass, loginName);
		JSONArray json=JSONArray.fromObject(user);
		return "/passwordupdate";
	}
	@RequestMapping("/userinfoquery")
	public String getUserInfoList(HttpServletRequest request){
		    return "/loginerror";
	}
	@RequestMapping("/userinfoquery/{userId}")
	public String getUserInfoList(HttpServletRequest request,@PathVariable("userId")long userId){
		List<UserInfo> userinfoList=userService.getUserInfoList();
		List<UserInfo> userinfoList1=userService.getUserListByCriteria(1, 10);
	    request.setAttribute("userinfoList", userinfoList1);
	    int listsize=userinfoList.size();
		 Page page = new Page(userinfoList.size(), 1);
		    request.setAttribute("page", page);
		    Map<String, Object> map = new HashMap<String, Object>(); 
		    map.put("page", page);  
		    map.put("userinfoList",userinfoList1);
		    map.put("listsize", listsize);
	        request.setAttribute("userid", userId);
		    return "/userquery";
	}
	@RequestMapping("/userinfoprotect/{userId}")
	public String toaddUserInfo(HttpServletRequest request,@PathVariable("userId")long userId){
		request.setAttribute("userid", userId);
		return "/useradd";
	}
	@RequestMapping("/userinfoprotect")
	public String toaddUserInfo(HttpServletRequest request){
		return "/loginerror";
	}
	@RequestMapping("/updateUser/{userId}")
	public String updateUser(HttpServletRequest request,Model model,@PathVariable("userId")long userId){
		String Id=request.getParameter("id");
		Long id=Long.valueOf(Id);
		UserInfo user=userService.getUserById(id);
		model.addAttribute("user",user);
		request.setAttribute("userid", userId);
		return "userupdate";
	}
	@RequestMapping("/doupdate")
	public String protectUserInfo(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String Id=request.getParameter("userId");
		Long id=Long.valueOf(Id);
		UserInfo user=userService.getUserById(id);
		String userName=request.getParameter("userName");
		String loginName=request.getParameter("loginName");
		String loginPass=request.getParameter("loginPass");
		//System.out.println(userName);
		//System.out.println(loginName);
		//System.out.println(loginPass);
		user.setLoginName(loginName);
		user.setLoginpass(loginPass);
		user.setUserName(userName);
		userService.update(user, id, userName, loginName, loginPass);
		List<UserInfo> userinfoList=userService.getUserInfoList();
	    request.setAttribute("userinfoList", userinfoList);
	    JSONArray json=JSONArray.fromObject(user);
		   response.getWriter().write(json.toString());
		   response.getWriter().flush();
		return null;
	}
	@RequestMapping("/userinfoprotect/insertuserinfo")
	public String insertUserInfo(HttpServletRequest request,HttpServletResponse response,UserInfo user) throws IOException {
			String userName = request.getParameter("userName");
			String loginName= request.getParameter("loginName");
			String loginpass= request.getParameter("loginPass");
			user.setUserName(userName);
			user.setLoginName(loginName);
			user.setLoginpass(loginpass);
			userService.insertUserInfo(user);
			 JSONArray json=JSONArray.fromObject(user);
			   response.getWriter().write(json.toString());
			   response.getWriter().flush();
	//List<UserInfo> userinfoList=userService.getUserInfoList();
	//List<UserInfo> userinfoList1=userService.getUserListByCriteria(1, 2);
	  //int listsize=userinfoList.size();
	   //request.setAttribute("userinfoList", userinfoList1);
	   //Page page = new Page(userinfoList.size(), 1);
	    //request.setAttribute("page", page);
	    //Map<String, Object> map = new HashMap<String, Object>(); 
	   // map.put("page", page);  
	   // map.put("userinfoList",userinfoList1);
	   // map.put("listsize", listsize);
	   // System.out.println(page.getTotalCount());
			
		return null;
	}
	@RequestMapping("/querySomeUser")
	public @ResponseBody Map<String,Object> queryUser(HttpServletRequest request){
		   String pagesize=request.getParameter("pagesize");
		   int pageSize=Integer.valueOf(pagesize);
		   String pagenumber=request.getParameter("pagenumber");
		   int pageNumber=1;
		   if(pagenumber!=""){
			   pageNumber=Integer.valueOf(pagenumber);
		   }
		   String listcount=request.getParameter("listcount");
		   int listCount=Integer.valueOf(listcount);
		    String userName = request.getParameter("userName");
			List<UserInfo>userinfoList=userService.getUserInfoListByName(userName);
			Page page = new Page(userinfoList.size(), pageNumber); 
		 	   page.setPageSize(pageSize);
		 	   page.setPageNow(pageNumber);
		 	   int pageCount=page.getTotalPageCount();
		 	   int listSize=userinfoList.size();
		 	   int endpos=page.getStartPos()-1+page.getPageSize();
		       int endPos=(endpos<=listSize)?endpos:listSize; 
			List<UserInfo> userinfoList1=userService.getSomeUserListByCriteria(userName,page.getStartPos(), endPos);
			 System.out.println("此次查询list的总数"+listSize);
		        System.out.println("理论结点数"+endpos);
		        System.out.println("此次查询结点"+endPos);
		        System.out.println("-----------------");
			request.setAttribute("userinfoList", userinfoList1);
			 Map<String, Object> map = new HashMap<String, Object>(); 
			    map.put("page", page);  
			    map.put("userlist", userinfoList1);
			    
		return map;
	}
	@RequestMapping("/userright")
	public String userright(HttpServletRequest request){
	
		return "loginerror";
	}
	@RequestMapping("/userright/{userId}")
	public String userright(HttpServletRequest request,@PathVariable("userId")long userId){
	List<Role> userList=roleService.getRoleList();
	request.setAttribute("userList", userList);
    List<Module> moduleList=moduleService.getModuleList();
    request.setAttribute("moduleList", moduleList);
    List<UserInfo> userinfoList=userService.getUserInfoList();
    request.setAttribute("userinfoList", userinfoList);
		return "/userright";
	}
	@RequestMapping("/userright1")
	public String userright1(HttpServletRequest request){
	List<Role> userList=roleService.getRoleList();
	request.setAttribute("userList", userList);
    List<Module> moduleList=moduleService.getModuleList();
    request.setAttribute("moduleList", moduleList);
		return "/rightmanage";
	}
	//���û����蹦��Ȩ��
	@RequestMapping("/giveuserright")
	public String giveuserright(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String loginName=request.getParameter("loginname");
		String usertype=request.getParameter("usertype");
		String userId=request.getParameter("userid");
		//System.out.println(userId);
		//System.out.println(loginName);
		//System.out.println(usertype);
		Role role=new Role();
		role.setRoleName(loginName);
		role.setRemark(usertype);
		roleService.insertRole(role);
		JSONArray json=JSONArray.fromObject(role);
		 response.getWriter().write(json.toString());
		 response.getWriter().flush();
		return null;
	}
	/*@RequestMapping("/rightmanager")
	  @ResponseBody
	public String rightmanager(HttpServletRequest request,@RequestParam(value = "modulelist")String[] data){
		//System.out.println("����Ȩ�޹���");
		String userid=request.getParameter("userid");
		long userId=Long.valueOf(userid);
		String roleid=request.getParameter("roleid");
		//long roleId=Long.valueOf(roleid);
		String usertype=request.getParameter("usertype");
		String userName=request.getParameter("username");
		List moduleList=Arrays.asList(data);
		//���ɫ���в����µĽ�ɫ
		Role role=new Role();
		role.setRoleName(userName);
		role.setRemark(usertype);
		roleService.insertRole(role);
		//long newRoleId=role.getRoleId();
		Role newRole=roleService.getNewRole();
		long newRoleId=newRole.getRoleId();
		//System.out.println("�����id"+newRole.getRoleId());
		//������Ҫ�Ӳ��ҵ����µĲ������
		//���ɫ���������в����µĹ����ϵ
		for (int i = 0; i < data.length; i++) {
			RoleModule roleModule=new RoleModule();
			roleModule.setRoleId(newRoleId);
			roleModule.setMdId(data[i]);
			RoleModuleService.insertRoleModule(roleModule);
			//System.out.println(RoleModuleService.insertRoleModule(roleModule));	
		}
		
		
		return null;
		
	}*/
	//����û�����ù���ģ��
	@RequestMapping("/getModuleList")
	public List<Module> getModuleList(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String userType=request.getParameter("usertype");
		//List<Module> list=moduleService.getModuleListByUserType(userType);
		//System.out.println(list.size());
		 List moduleList=new ArrayList();
		 /*  for (Module module : list) {
			  String moduleId=module.getMdId();
			   moduleList.add(moduleId);
		   }*/
		// List list=new ArrayList();
		 int[]array1={1,3,5,7,9,11,12,13};
		 int []array2={1,3,5,7,9,11,13};
		 int []array3={2,4,6,8,10,13};
		if(userType.equals("超级管理员")){
			for (int i = 0; i < array1.length; i++) {
				moduleList.add(array1[i]);
			}
		}
		if(userType.equals("管理员")){
			for (int i = 0; i < array2.length; i++) {
				moduleList.add(array2[i]);
			}
		}
		if(userType.equals("普通用户")){
			for (int i = 0; i < array3.length; i++) {
				moduleList.add(array3[i]);
			}
		}
		
		   JSONArray json=JSONArray.fromObject(moduleList);
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
		   List<UserInfo> userList=userService.getUserListByCriteria(page.getStartPos(), endPos);
		   int listsize=userList.size();
		  
		   Map<String, Object> map = new HashMap<String, Object>();  
		   map.put("userlist",userList);
		   map.put("pageCount",pageCount);
		   map.put("page",page);
		   map.put("listsize",listsize);
		   return map;
	}
	@RequestMapping(value="/querySomeByCriteria", method = RequestMethod.POST)
	public @ResponseBody Map<String,Object> getSomePageCount(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String userName=request.getParameter("username");
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
		   List<UserInfo>userinfoList=userService.getUserInfoListByName(userName);
		   int listSize=userinfoList.size();
	 	   int endpos=page.getStartPos()-1+page.getPageSize();
	       int endPos=(endpos<=listSize)?endpos:listSize; 
	 	   List<UserInfo>userList1=userService.getUserInfoListByName(userName);
		   List<UserInfo> userList2=userService.getSomeUserListByCriteria(userName, page.getStartPos(), endPos);
		   System.out.println("此次查询list的总数"+listSize);
	        System.out.println("理论结点数"+endpos);
	        System.out.println("此次查询结点"+endPos);
	        System.out.println("-----------------");
		   int listsize=userList1.size();
		   Map<String, Object> map = new HashMap<String, Object>();  
		   map.put("userlist",userList2);
		   map.put("pageCount",pageCount);
		   map.put("page",page);
		   map.put("listsize",listsize);
		   return map;
	}
	@RequestMapping(value="/queryUserInfoByLoginName", method = RequestMethod.POST)
	public String queryUserInfoByLoginName(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String loginName=request.getParameter("loginName");
		UserInfo user=userService.getUserByLoginName(loginName);
		//System.out.println(user);
		 JSONArray json=JSONArray.fromObject(user);
		   response.getWriter().write(json.toString());
		   response.getWriter().flush();
		return null;
	}
	@RequestMapping(value="/queryRoleByRoleName", method = RequestMethod.POST)
	public String queryRoleByRoleName(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String roleName=request.getParameter("loginname");
		Role role=roleService.getRoleByRoleName(roleName);
		 JSONArray json=JSONArray.fromObject(role);
		   response.getWriter().write(json.toString());
		   response.getWriter().flush();
		return null;
	}
	@RequestMapping("passwordupdate/{userId}")
	public String topasswordupdate(HttpServletRequest request,@PathVariable long userId){
		return "passwordupdate";
	}
	@RequestMapping("passwordupdate")
	public String topasswordupdate(HttpServletRequest request){
		return "loginerror";
	}
	@RequestMapping("exit/{userId}")
	public String exit(HttpServletRequest request,@PathVariable long userId){
		return "login";
	}
	@RequestMapping("exit")
	public String exit(HttpServletRequest request){
		return "loginerror";
	}
	
}
