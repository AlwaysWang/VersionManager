package com.wt.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import page.Page;

import com.wt.bean.FunctionModule;
import com.wt.bean.News;
import com.wt.bean.Role;
import com.wt.serviceimp.NewsService;
import com.wt.serviceimp.RoleService;

@Controller
@RequestMapping("/news")
public class NewsController {
	@Autowired
	private NewsService newsService;
	@Autowired
	private RoleService roleService;
	@RequestMapping("/querynews")
	public String loginError(HttpServletRequest request){
		  return "loginerror";
	}
	@RequestMapping("/querynews/{userid}")
	public String getNewsList(HttpServletRequest request,Map<String, Object> map,@PathVariable long  userid){
		// long userId=Long.valueOf(userid);
		Role role=roleService.getRoleByRoleId(userid);
		  String remark=role.getRemark();
		List<News>newsList=newsService.getNewsList();
		List<News>newsList1=newsService.getNewsListByCriteria(1, 10);
	 request.setAttribute("newsList", newsList1);
	 Page page = new Page(newsList.size(), 1); 
		map.put("page", page);  
	    map.put("list",newsList1);
	    request.setAttribute("userType", remark);
	    request.setAttribute("userid", userid);
		return "/publicnews";
	}
	@RequestMapping("/protectnews/{userid}")
	public String addnews(HttpServletRequest request,@PathVariable long userid){
		System.out.println("hello");
		request.setAttribute("userid", userid);
		return "publicnewsadd";
	}
	@RequestMapping("/protectnews")
	public String addnews(HttpServletRequest request){
		return "loginerror";
	}
	
	@RequestMapping("/querynewsByDate")
	public @ResponseBody  Map<String,Object> getNewsListByDate(HttpServletRequest request,Model model){
		  String pagesize=request.getParameter("pagesize");
		   int pageSize=Integer.valueOf(pagesize);
		   String pagenumber=request.getParameter("pagenumber");
		   int pageNumber=1;
		   if(pagenumber!="")
		   {
		  pageNumber=Integer.valueOf(pagenumber);
		   }
		   String listcount=request.getParameter("listcount");
		   int listCount=Integer.valueOf(listcount);
		String startDate= request.getParameter("startDate");
		String endDate= request.getParameter("endDate");
		String newstitle=request.getParameter("newstitle");
		String endDate1=null;
		if(endDate!=""){
		endDate1=endDate+" "+"23:59:59";
		}
		List<News> newsList=newsService.getNewsListByDate(startDate, endDate1,newstitle);
		   Page page = new Page(newsList.size(), pageNumber); 
		   page.setPageSize(pageSize);
		   page.setPageNow(pageNumber);
		   int pageCount=page.getTotalPageCount();
		   int listSize=newsList.size();
			int endpos=page.getStartPos()-1+page.getPageSize();
	        int  endPos=(endpos<=listSize)?endpos:listSize;
	        System.out.println("此次查询list的总数"+newsList.size());
	        System.out.println("理论结点数"+endpos);
	        System.out.println("此次查询结点"+endPos);
	        System.out.println("-----------------");
		List<News> newsList1=newsService.getSomeNewsListByCriteria(startDate, endDate1,newstitle,page.getStartPos(), endPos);
		request.setAttribute("newsList", newsList1);
		    request.setAttribute("page", page);
		    Map<String, Object> map = new HashMap<String, Object>(); 
		    map.put("page", page);  
		    map.put("newslist", newsList1);
		   // map.put("listsize", listsize);
		return map;
	}

	@RequestMapping("/updatenews")
	public String updateNews(HttpServletRequest request,Model model){
		String userId=request.getParameter("userid");
		System.out.println(userId);
		long  userid=Long.valueOf(userId);
		String Id=request.getParameter("id");
		long id=Long.valueOf(Id);
		News news=newsService.getNewsById(id);
		model.addAttribute("news",news);
		//Role roleUser=roleService.getRoleByRoleName(user.getLoginName());					
		//request.getSession().setAttribute("roleUser", roleUser);
		request.setAttribute("userid", userid);
		return "/publicnewsupdate";
	}
	@RequestMapping("/doupdatenews")
	public String doupdateNews(HttpServletRequest request) throws ParseException{
		String Id=request.getParameter("id");
		long id=Long.valueOf(Id);
		News news=newsService.getNewsById(id);
		String newsTitle=request.getParameter("newstitle");
		//String newsdate=request.getParameter("newsdate");
		//DateFormat fmt =new SimpleDateFormat("yyyy-MM-dd");
		//Date newsDate = fmt.parse(newsdate); 
		String newsContent=request.getParameter("newscontent");
	    news.setContent(newsContent);
	   // news.setIstDate(newsDate);
	    news.setTitle(newsTitle);
		Date date=new Date();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String update = df.format(date);
        news.setNowDate(update);
	    newsService.updateNews(news, id, newsTitle, update, newsContent);
	    List<News>newsList=newsService.getNewsList();
		 request.setAttribute("newsList", newsList);
		
		return "/publicnews";
	}
	@RequestMapping("/insertnews")
	public String insertNews(HttpServletRequest request,HttpServletResponse response,News news) throws  IOException, ParseException{
		

		String newsTitle=request.getParameter("newstitle");
	//	String newsdate=request.getParameter("newsdate");
		//DateFormat fmt =new SimpleDateFormat("yyyy-MM-dd");
	//	Date newsDate = fmt.parse(newsdate);
		String newsContent=request.getParameter("newscontent");
		 news.setContent(newsContent);
		   // news.setIstDate(newsDate);
		    news.setTitle(newsTitle);
		   newsService.insertNews(news);
			 JSONArray json=JSONArray.fromObject(news);
			   response.getWriter().write(json.toString());
			   response.getWriter().flush();
		return null;
	}
	@RequestMapping(value="/querySomeByCriteria", method = RequestMethod.POST)
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
		   List<News> newsList=newsService.getNewsListByCriteria(page.getStartPos(), endPos);
		   int listsize=newsList.size();
		  
		   Map<String, Object> map = new HashMap<String, Object>();  
		   map.put("newslist",newsList);
		   map.put("pageCount",pageCount);
		   map.put("page",page);
		   map.put("listsize",listsize);
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
			String newstitle=request.getParameter("newstitle");
			//String funName=request.getParameter("funname");
			//String typeName= request.getParameter("typename");
		   String pagesize=request.getParameter("pagesize");
		   int pageSize=Integer.valueOf(pagesize);
		   String pagenumber=request.getParameter("pagenumber");
		   int pageNumber=Integer.valueOf(pagenumber);
		   String listcount=request.getParameter("listcount");
	       List<News> newsList1=newsService.getNewsListByDate(startDate, endDate1,newstitle);
	       Page page = new Page(newsList1.size(), pageNumber); 
		   page.setPageSize(pageSize);
		   page.setPageNow(pageNumber);
		   int pageCount=page.getTotalPageCount();
	       int endpos=page.getStartPos()-1+page.getPageSize();;
	       int endPos=(endpos<=newsList1.size())?endpos:newsList1.size();
	        System.out.println("此次查询list的总数"+newsList1.size());
	        System.out.println("理论结点数"+endpos);
	        System.out.println("此次查询结点"+endPos);
	        System.out.println("-----------------");
	       List<News> newsList2=newsService.getSomeNewsListByCriteria(startDate, endDate1,newstitle, page.getStartPos(), endPos);
		   int listsize=newsList1.size();
		   Map<String, Object> map = new HashMap<String, Object>();  
		   map.put("newslist",newsList2);
		   map.put("pageCount",pageCount);
		   map.put("page",page);
		   //map.put("listsize",listsize);
		   return map;
	}
	@RequestMapping("/deleteNewsById")
	public @ResponseBody Map<String,Object> deleteNewsById(HttpServletRequest request){
		   Map<String, Object> map = new HashMap<String, Object>();
			  String pagesize=request.getParameter("pagesize");
			   int pageSize=Integer.valueOf(pagesize);
			   String pagenumber=request.getParameter("pagenumber");
			   int pageNumber=1;
			   if(pagenumber!=""){
				   pageNumber=Integer.valueOf(pagenumber);
			   }//前台页面信息
		   String id=request.getParameter("id");
		   if(id!=null){
			   Long newsId=Long.valueOf(id);
			   System.out.println(newsId);
			   newsService.deleteNewsById(newsId);
			   List<News>newsList=newsService.getNewsList();
			   Page page=new Page(newsList.size(),pageNumber);
			   page.setPageSize(pageSize);
			   int endpos=page.getStartPos()-1+page.getPageSize();
				List<News>newsList1=newsService.getNewsListByCriteria(1, endpos);
			    request.setAttribute("newsList", newsList1);
				map.put("page", page);  
			    map.put("list",newsList1);
		   }
		   return map;
	}
}
