<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
System.out.println(basePath);
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>   
<script type="text/javascript"  src="<%=basePath%>js/showdate.js"></script>
<script type="text/javascript" src="<%=basePath%>jquery/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>lhgcalendar/lhgcore.js"></script>
	<script type="text/javascript" src="<%=basePath%>lhgcalendar/lhgcalendar.js"></script>
	<script language="javascript" src="<%=basePath%>extjs/ext-base.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-all.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-lang-zh_CN.js"></script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>系统公告查询</title>
<script type="text/javascript">
function querySomeNews(){
	var form = document.forms[0];  
	  var startDate = document.getElementsByName("startDate")[0].value;
	 var endDate = document.getElementsByName("endDate")[0].value;
	 var begintime = document.getElementById("c2").value;
	 var endtime = document.getElementById("c1").value;
	 var r = new RegExp("^[1-2]\\d{3}-(0?[1-9]||1[0-2])-(0?[1-9]||[1-2][1-9]||3[0-1])$");
	 if(startDate.trim().length==0){
			document.getElementById("msg1").innerHTML = "<font color='red'> * 开始时间不能为空</font>";
			document.getElementsByName("startDate")[0].focus();
			document.getElementsByName("startDate")[0].style.borderColor="red";
			document.getElementsByName("startDate")[0].style.borderStyle="dotted";
			return false;
		}
	 if(!r.test(begintime)){
		 document.getElementById("msg1").innerHTML = "<font color='red'> 请输入正确的时间格式</font>";
			document.getElementsByName("startDate")[0].focus();
			document.getElementsByName("startDate")[0].style.borderColor="red";
			document.getElementsByName("startDate")[0].style.borderStyle="dotted";
			return false;
	 }
	 if(endDate.trim().length==0){
			document.getElementById("msg2").innerHTML = "<font color='red'> * 截止时间不能为空</font>";
			document.getElementsByName("endDate")[0].focus();
			document.getElementsByName("endDate")[0].style.borderColor="red";
			document.getElementsByName("endDate")[0].style.borderStyle="dotted";
			return false;
		}
	 if(!r.test(endtime)){
		 document.getElementById("msg2").innerHTML = "<font color='red'> 请输入正确的时间格式</font>";
			document.getElementsByName("endDate")[0].focus();
			document.getElementsByName("endDate")[0].style.borderColor="red";
			document.getElementsByName("endDate")[0].style.borderStyle="dotted";
			return false;
	 }
	 
	 form.action = "${pageContext.request.contextPath}/news/querynewsByDate"; 
	 form.method = "post";  
     form.submit();  
		}
		 function editNews(id){
	 var form = document.forms[0];  
	 form.action = "${pageContext.request.contextPath}/news/updatenews"; 
	 document.forms.myform.id.value = id;
	 form.method = "post";  
    form.submit();  
}


window.onload=function(){ 
	var userType=$("#usertype").val();
	if(userType=="普通用户"){
		$("#edit").hide();
		$("td[name='edit']").hide();
	}
	var array = new Array();  
	/*<c:forEach items="${requestScope.installAllList}" var="item" varStatus="status" >  
	    array.push("${item}");  //对象，加引号
	 
	    alert("${item.verCode}");   //传递过来的是字符串，加引号 
	    </c:forEach>  */ 
	   <c:if test="${empty requestScope.newsList}">
	    document.getElementById("down_center").innerHTML = "没有找到符合条件的公告信息";
	    </c:if>
	    var pagenumber=$("#pagenumber1").val();
	     $("#pageno").attr("value",1);
	    var pagesize=$("#pagesize").attr("value");
	//alert("pagesize"+pagesize);
	   var listcount=$("#totalcount").val();
	 //  alert("listcount"+listcount);
	   var pagenumber=$("#pagenumber1").val();
	  // alert("pagenumber"+pagenumber);
	     $.ajax({
	    	type:"post",
	        url: "${pageContext.request.contextPath}/news/querySomeByCriteria",
	        data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber},
	        //dataType:"text",
	        success:function(value){
	        		  pagecount=value.pageCount;
	        		  list=value.versionlist;
	        		  listsize=value.listsize;
	        		 // $("#totalcount").attr("value", listsize);
	        		  $("#totalpagecount").attr("value",pagecount);
	        		  $("#pagetotalcount").attr("value",pagecount);
	        		  $("#pagenumber").empty();
	        		  for(var i=1;i<=pagecount;i++){
	     	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
	     	    		
	     	    		  } 	
	        }
	    });  
	}

function getFunByCriteria(){
	var userType=$("#usertype").val();
	 var startDate = document.getElementsByName("startDate")[0].value;
	 var endDate = document.getElementsByName("endDate")[0].value;
	  var newstitle=document.getElementById("newstitle").value;
		$("#pageno").attr("value",1);
		var pagesize=$("#pagesize").attr("value");
		var listcount=$("#totalcount").val();
		var listsize=$("#listsize").val();
		var pagenumber=$("#pagenumber1").val();
	 var form = document.forms[0]; 
			$.ajax({
				type:"post",
			    url: "${pageContext.request.contextPath}/news/querySomeListByCriteria",
			    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,newstitle:newstitle},
			    success:function(value){
			    		  pagecount=value.pageCount;
			    		  list=value.newslist;
			    		  $("#totalpagecount").attr("value",pagecount);
			    		  $("#pagetotalcount").attr("value",pagecount);
			    		  //alert(value.page.totalCount);
			    		  $("#pagenumber").empty();
			    		  for(var i=1;i<=pagecount;i++){
			 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
			 	    		  } 	
			    	
			    		  if(list.length>0){
			    			  if(userType=="普通用户"){
			    			  $("#newstable").html("<tr><th>公告标题</th><th>公告内容</th><th>公告时间</th></tr>");
				    		  for(var i=0;i<list.length;i++){
				    			  $("#newstable").append("<tr><td>"+list[i].title+
				    					              "</td><td>"+list[i].content+
				    					              "</td><td>"+list[i].istDateFormat+
				    					              "</a></td></tr>"
				    					              );
				    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
				    					  
				    		  }
				    		    	 $("td").css("text-align","center");
			    			  }
			    			  else{
			    				  $("#newstable").html("<tr><th>公告标题</th><th>公告内容</th><th>公告时间</th><th>修改</th><th>删除</th></tr>");
					    		  for(var i=0;i<list.length;i++){
					    			  $("#newstable").append("<tr><td>"+list[i].title+
					    					              "</td><td>"+list[i].content+
					    					              "</td><td>"+list[i].istDateFormat+
					    					              "</a></td><td><a href='javascript:editNews("+list[i].id+")'>"+"修改"+
					    					               "</a></td><td><a href='javascript:deleteNews("+list[i].id+")'>"+"删除"+
					    					              "</a></td></tr>"
					    					              );
					    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
					    					  
					    		  }
					    		    	 $("td").css("text-align","center");
			    			  }
	    		    		 }
			    		  if(list.length==0){
					    		 $("#down_center").html("没有找到符合条件的公告信息");
					    	
					    		 }
			    }	
			});	
		}
function firstpage(){
	//alert("已到第一页");
	var userType=$("#usertype").val();
	 var startDate = document.getElementsByName("startDate")[0].value;
	 var endDate = document.getElementsByName("endDate")[0].value;
	  var newstitle=document.getElementById("newstitle").value;
	var listcount=$("#totalcount").val();
	var listsize=$("#listsize").val();
	var opt=$("#pagesize").find("option:selected").text();
	var opt1=$("#pageno").find("option:selected").text();

	if(isNaN(opt)){
		alert("请先选择");
		return;
	}
	if(isNaN(opt1)){
		alert("请先选择");
		return;
	}

	var totalpagecount=$("#pagetotalcount").val();
	var pagesize=$("#pagesize").attr("value");
	var pageno=1;
	if(pageno==0){
	alert("已到第一页");
	return;
	}

	$("#pageno").attr("value",1);
	var pagenumber=$("#pageno").val();
		 var form = document.forms[0]; 
		$.ajax({
			type:"post",
		    url: "${pageContext.request.contextPath}/news/querySomeListByCriteria",
		    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,newstitle:newstitle},
		    success:function(value){
		    		  pagecount=value.pageCount;
		    		  list=value.newslist;
		    		  $("#totalpagecount").attr("value",pagecount);
		    		  $("#pagetotalcount").attr("value",pagecount);
		    		  $("#pagenumber").empty();
		    		  for(var i=1;i<=pagecount;i++){
		 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
		 	    		  } 	
		    		  if(list.length>0){
		    			  if(userType=="普通用户"){
		    			  $("#newstable").html("<tr><th>公告标题</th><th>公告内容</th><th>公告时间</th></tr>");
			    		  for(var i=0;i<list.length;i++){
			    			  $("#newstable").append("<tr><td>"+list[i].title+
			    					              "</td><td>"+list[i].content+
			    					              "</td><td>"+list[i].istDateFormat+
			    					              "</a></td></tr>"
			    					              );
			    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
			    					  
			    		  }
			    		    	 $("td").css("text-align","center");
		    			  }
		    			  else{
		    				  $("#newstable").html("<tr><th>公告标题</th><th>公告内容</th><th>公告时间</th><th>修改</th><th>删除</th>s</tr>");
				    		  for(var i=0;i<list.length;i++){
				    			  $("#newstable").append("<tr><td>"+list[i].title+
				    					              "</td><td>"+list[i].content+
				    					              "</td><td>"+list[i].istDateFormat+
				    					              "</a></td><td><a href='javascript:editNews("+list[i].id+")'>"+"修改"+
				    					              "</a></td><td><a href='javascript:deleteNews("+list[i].id+")'>"+"删除"+
				    					              "</a></td></tr>"
				    					              );
				    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
				    					  
				    		  }
				    		    	 $("td").css("text-align","center");
		    			  }
    		    		 }
		    		  if(list.length==0){
				    		 $("#down_center").html("没有找到符合条件的公告信息");
				    	
				    		 }   
		    }	
		});	
	}
function forwardpage(){
	var userType=$("#usertype").val();
	 var startDate = document.getElementsByName("startDate")[0].value;
	 var endDate = document.getElementsByName("endDate")[0].value;
	  var newstitle=document.getElementById("newstitle").value;
	var listcount=$("#totalcount").val();
	var listsize=$("#listsize").val();
	var opt=$("#pagesize").find("option:selected").text();
	var opt1=$("#pageno").find("option:selected").text();
	if(isNaN(opt)){
		alert("请先选择");
		return;
	}
	if(isNaN(opt1)){
		alert("请先选择");
		return;
	}
	var totalpagecount=$("#pagetotalcount").val();
	var pagesize=$("#pagesize").attr("value");
	var pageNo=$("#pageno").val();
	var pageno=pageNo*1-1;
	if(pageno==0){
	alert("已到第一页");
	return;
	}
	$("#pageno").attr("value",pageno);
	var pagenumber=$("#pageno").val();
		 var form = document.forms[0]; 
		$.ajax({
			type:"post",
		    url: "${pageContext.request.contextPath}/news/querySomeListByCriteria",
		    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,newstitle:newstitle},
		    success:function(value){
		    		  pagecount=value.pageCount;
		    		  list=value.newslist;
		    		  $("#totalpagecount").attr("value",pagecount);
		    		  $("#pagetotalcount").attr("value",pagecount);
		    		  $("#pagenumber").empty();
		    		  for(var i=1;i<=pagecount;i++){
		 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
		 	    		  } 	
		    		  if(list.length>0){
		    			  if(userType=="普通用户"){
		    			  $("#newstable").html("<tr><th>公告标题</th><th>公告内容</th><th>公告时间</th></tr>");
			    		  for(var i=0;i<list.length;i++){
			    			  $("#newstable").append("<tr><td>"+list[i].title+
			    					              "</td><td>"+list[i].content+
			    					              "</td><td>"+list[i].istDateFormat+
			    					              "</a></td></tr>"
			    					              );
			    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
			    					  
			    		  }
			    		    	 $("td").css("text-align","center");
		    			  }
		    			  else{
		    				  $("#newstable").html("<tr><th>公告标题</th><th>公告内容</th><th>公告时间</th><th>修改</th><th>删除</th></tr>");
				    		  for(var i=0;i<list.length;i++){
				    			  $("#newstable").append("<tr><td>"+list[i].title+
				    					              "</td><td>"+list[i].content+
				    					              "</td><td>"+list[i].istDateFormat+
				    					              "</a></td><td><a href='javascript:editNews("+list[i].id+")'>"+"修改"+
				    					              "</a></td><td><a href='javascript:deleteNews("+list[i].id+")'>"+"删除"+
				    					              "</a></td></tr>"
				    					              );
				    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
				    					  
				    		  }
				    		    	 $("td").css("text-align","center");
		    			  }
    		    		 }
		    		  if(list.length==0){
				    		 $("#down_center").html("没有找到符合条件的公告信息");
				    	
				    		 } 
		    }	
		});	
	}
function nextpage(){
	var userType=$("#usertype").val();
	 var startDate = document.getElementsByName("startDate")[0].value;
	 var endDate = document.getElementsByName("endDate")[0].value;
	  var newstitle=document.getElementById("newstitle").value;
	var listcount=$("#totalcount").val();
	var listsize=$("#listsize").val();
	var opt=$("#pagesize").find("option:selected").text();
	var opt1=$("#pageno").find("option:selected").text();
	if(isNaN(opt)){
		alert("请先选择");
		return;
	}
	if(isNaN(opt1)){
		alert("请先选择");
		return;
	}
	var totalpagecount=$("#totalpagecount").val();
	var pagesize=$("#pagesize").attr("value");
	var pageNo=$("#pageno").val();
	var pageno=pageNo*1+1;
	if(totalpagecount<pageno){
	alert("已到最后一页");
	return;
	}
	$("#pageno").attr("value",pageno);
	var pagenumber=$("#pageno").val();	
		 var form = document.forms[0]; 
		$.ajax({
			type:"post",
		    url: "${pageContext.request.contextPath}/news/querySomeListByCriteria",
		    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,newstitle:newstitle},
		    success:function(value){
		    		  pagecount=value.pageCount;
		    		  list=value.newslist;
		    		  $("#totalpagecount").attr("value",pagecount);
		    		  $("#pagetotalcount").attr("value",pagecount);
		    		  $("#pagenumber").empty();
		    		  for(var i=1;i<=pagecount;i++){
		 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
		 	    		  } 	
		    		  if(list.length>0){
		    			  if(userType=="普通用户"){
		    			  $("#newstable").html("<tr><th>公告标题</th><th>公告内容</th><th>公告时间</th></tr>");
			    		  for(var i=0;i<list.length;i++){
			    			  $("#newstable").append("<tr><td>"+list[i].title+
			    					              "</td><td>"+list[i].content+
			    					              "</td><td>"+list[i].istDateFormat+
			    					              "</a></td></tr>"
			    					              );
			    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
			    					  
			    		  }
			    		    	 $("td").css("text-align","center");
		    			  }
		    			  else{
		    				  $("#newstable").html("<tr><th>公告标题</th><th>公告内容</th><th>公告时间</th><th>修改</th><th>删除</th></tr>");
				    		  for(var i=0;i<list.length;i++){
				    			  $("#newstable").append("<tr><td>"+list[i].title+
				    					              "</td><td>"+list[i].content+
				    					              "</td><td>"+list[i].istDateFormat+
				    					              "</a></td><td><a href='javascript:editNews("+list[i].id+")'>"+"修改"+
				    					              "</a></td><td><a href='javascript:deleteNews("+list[i].id+")'>"+"删除"+
				    					              "</a></td></tr>"
				    					              );
				    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
				    					  
				    		  }
				    		    	 $("td").css("text-align","center");
		    			  }
    		    		 }
		    		  if(list.length==0){
				    		 $("#down_center").html("没有找到符合条件的公告信息");
		    		  }		
		    }	
		});	
	}

	function lastpage(){
		//alert("已到最后一页");
		var userType=$("#usertype").val();
		 var startDate = document.getElementsByName("startDate")[0].value;
		 var endDate = document.getElementsByName("endDate")[0].value;
		  var newstitle=document.getElementById("newstitle").value;
		var opt=$("#pagesize").find("option:selected").text();
		var opt1=$("#pageno").find("option:selected").text();
		if(isNaN(opt)){
			alert("请先选择");
			return;
		}
		if(isNaN(opt1)){
			alert("请先选择");
			return;
		}
		var totalpagecount=$("#pagetotalcount").val();
		var pagesize=$("#pagesize").attr("value");
		var pageno=1;
		$("#pageno").attr("value",totalpagecount);
		var pagenumber=$("#pageno").val();
		var listcount=$("#totalcount").val();
		var listsize=$("#listsize").val();	
	    var form = document.forms[0]; 
			$.ajax({
				type:"post",
			    url: "${pageContext.request.contextPath}/news/querySomeListByCriteria",
			    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,newstitle:newstitle},
			    success:function(value){
			    		  pagecount=value.pageCount;
			    		  list=value.newslist;
			    		  $("#totalpagecount").attr("value",pagecount);
			    		  $("#pagetotalcount").attr("value",pagecount);
			    		  $("#pagenumber").empty();
			    		  for(var i=1;i<=pagecount;i++){
			 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
			 	    		  } 	
			    		  if(list.length>0){
			    			  if(userType=="普通用户"){
			    			  $("#newstable").html("<tr><th>公告标题</th><th>公告内容</th><th>公告时间</th></tr>");
				    		  for(var i=0;i<list.length;i++){
				    			  $("#newstable").append("<tr><td>"+list[i].title+
				    					              "</td><td>"+list[i].content+
				    					              "</td><td>"+list[i].istDateFormat+
				    					              "</a></td></tr>"
				    					              );
				    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
				    					  
				    		  }
				    		    	 $("td").css("text-align","center");
			    			  }
			    			  else{
			    				  $("#newstable").html("<tr><th>公告标题</th><th>公告内容</th><th>公告时间</th><th>修改</th><th>删除</th></tr>");
					    		  for(var i=0;i<list.length;i++){
					    			  $("#newstable").append("<tr><td>"+list[i].title+
					    					              "</td><td>"+list[i].content+
					    					              "</td><td>"+list[i].istDateFormat+
					    					              "</a></td><td><a href='javascript:editNews("+list[i].id+")'>"+"修改"+
					    					              "</a></td><td><a href='javascript:deleteNews("+list[i].id+")'>"+"删除"+
					    					              "</a></td></tr>"
					    					              );
					    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
					    					  
					    		  }
					    		    	 $("td").css("text-align","center");
			    			  }
	    		    		 }
			    		  if(list.length==0){
					    		 $("#down_center").html("没有找到符合条件的公告信息");
					    		 } 
			    }	
			});	
		}		
	function toSelectedPage(){
		var userType=$("#usertype").val();
		 var startDate = document.getElementsByName("startDate")[0].value;
		 var endDate = document.getElementsByName("endDate")[0].value;
		  var newstitle=document.getElementById("newstitle").value;
		var pagenumber=$("#pagenumber").attr("value");
		var totalpagecount=$("#pagetotalcount").val();
		var pagesize=$("#pagesize").attr("value");
		var listcount=$("#totalcount").val();
		var listsize=$("#listsize").val();
		$("#pageno").attr("value",pagenumber);
	 var form = document.forms[0]; 
			$.ajax({
				type:"post",
			    url: "${pageContext.request.contextPath}/news/querySomeListByCriteria",
			    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,newstitle:newstitle},
			    success:function(value){
			    		  pagecount=value.pageCount;
			    		  list=value.newslist;
			    		  $("#totalpagecount").attr("value",pagecount);
			    		  $("#pagetotalcount").attr("value",pagecount);
			    		/*  $("#pagenumber").empty();
			    		  for(var i=1;i<=pagecount;i++){
			 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
			 	    		  } 	*/
			    		  if(list.length>0){
			    			  if(userType=="普通用户"){
			    			  $("#newstable").html("<tr><th>公告标题</th><th>公告内容</th><th>公告时间</th><th>修改</th></tr>");
				    		  for(var i=0;i<list.length;i++){
				    			  $("#newstable").append("<tr><td>"+list[i].title+
				    					              "</td><td>"+list[i].content+
				    					              "</td><td>"+list[i].istDateFormat+
				    					              "</a></td></tr>"
				    					              );
				    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
				    					  
				    		  }
				    		    	 $("td").css("text-align","center");
			    			  }
			    			  else{
			    				  $("#newstable").html("<tr><th>公告标题</th><th>公告内容</th><th>公告时间</th><th>修改</th><th>删除</th></tr>");
					    		  for(var i=0;i<list.length;i++){
					    			  $("#newstable").append("<tr><td>"+list[i].title+
					    					              "</td><td>"+list[i].content+
					    					              "</td><td>"+list[i].istDateFormat+
					    					              "</a></td><td><a href='javascript:editNews("+list[i].id+")'>"+"修改"+
					    					              "</a></td><td><a href='javascript:deleteNews("+list[i].id+")'>"+"删除"+
					    					              "</a></td></tr>"
					    					              );
					    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
					    					  
					    		  }
					    		    	 $("td").css("text-align","center");
			    			  }
	    		    		 }
			    		  if(list.length==0){
					    		 $("#down_center").html("没有找到符合条件的公告信息");
					    	
					    		 }
			    		 
			    	
			       
			    }	
			});	
		}			
	function querySomeVersion1(){
		//var totalpagecount=$("#pagetotalcount").val();
		//alert(totalpagecount);
		var pagesize=$("#pagesize").attr("value");
		var pageno=1;
		$("#pageno").attr("value",1);
		var pagenumber=1;
		var listcount=$("#totalcount").val();
		var listsize=$("#listsize").val();
	var userType=$("#usertype").val();
   	 var form = document.forms[0];
   	 var startDate = document.getElementsByName("startDate")[0].value;
	 var endDate = document.getElementsByName("endDate")[0].value;
		 var begintime = document.getElementById("c2").value;
		 var endtime = document.getElementById("c1").value;
		 var newstitle=document.getElementById("newstitle").value;
		 var r = new RegExp("^[1-2]\\d{3}-(0?[1-9]||1[0-2])-(0?[1-9]||[1-2][1-9]||3[0-1])$");
		if(startDate.trim().length!=0){
			 if(checkDate(begintime)==false){
			  $("#pageutil").hide();
				 document.getElementById("msg1").innerHTML = "<font color='red'> 请输入正确的时间格式</font>";
				  $("#newstable").empty();
					return false;
			 }
			  if(checkDate(begintime)==true){
				 document.getElementById("msg1").innerHTML = "";
			 }
			 }
				 if(endDate.trim().length!=0){
				  if(checkDate(endtime)==false){
				   $("#pageutil").hide();
					 document.getElementById("msg2").innerHTML = "<font color='red'> 请输入正确的时间格式</font>";
					  $("#newstable").empty();
						return false;
				 }
				 if(checkDate(endtime)==true){
					 document.getElementById("msg2").innerHTML = "";
						
				 }	
				}
				 if(endDate.trim().length!=0&&startDate.trim().length!=0){
					 if(startDate>endDate){
						 document.getElementById("msg2").innerHTML = "<font color='red'>开始时间不能早于结束时间</font>";
					 }
				 }
		  $.ajax({
				type:"post",
			    url: "${pageContext.request.contextPath}/news/querynewsByDate",
			    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,newstitle:newstitle},
			    success:function(value){
			    	 $("#newstable").empty();
		    		  list=value.newslist;
		    		  page=value.page; 
		    		  $("#totalcount").val(value.page.totalCount);
		    		  $("#pagetotalcount").val(value.page.totalPageCount);
		    		  $("#pagesize").val();
		    		  $("#pageno").attr("value",1);
		    		  var pagesize=$("#pagesize").attr("value");
		    		  var listcount=$("#totalcount").val();
		    		  var pagenumber=$("#pagenumber1").val();
		    		  //alert(value.page.totalCount);
		    		 // alert(value.page.totalPageCount);
		    		
		    		  if(parseInt(listcount)%parseInt(pagesize)==0){
		    		   
		    			  $("#totalpagecount").attr("value",listcount/pagesize);
		    		  }
		    		  if(parseInt(listcount)<=parseInt(pagesize)){
		    			
		    			  $("#totalpagecount").attr("value","1");
		    		  }
		    		  if(parseInt(listcount)%parseInt(pagesize)!=0){
		    	
		    			  $("#totalpagecount").attr("value",parseInt(listcount/pagesize)+1);
		    		  }
		
		    		  $("#pagenumber").empty();
			    		  for(var i=1;i<=$("#totalpagecount").val();i++){
			 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
			 	    		
			    		  }
			    		  if(list.length>0){
			    			  $("#pageutil").show();
			    			  $("#down_center").empty();
			    			 // $("#newstable").empty();
			    			 if(userType=="普通用户"){
			    		 // <td><a href="javascript:download('${version.id}')">操作说明</a></td>
			    			//  $("#usertable").html("<tr><td>用户名称</td><td>用户帐号</td><td>用户密码</td><td>修改</td></tr>");
			    			  $("#newstable").html("<tr><th>公告标题</th><th>公告内容</th><th>公告时间</th></tr>");
				    		  for(var i=0;i<list.length;i++){
				    			  $("#newstable").append("<tr><td>"+list[i].title+
				    					              "</td><td>"+list[i].content+
				    					              "</td><td>"+list[i].istDateFormat+
				    					              "</a></td></tr>"
				    					              );
				    					  
				    		  }
				    		    	 $("td").css("text-align","center");
			    			 }
			    			 else{
			    				  $("#newstable").html("<tr><th>公告标题</th><th>公告内容</th><th>公告时间</th><th>修改</th><th>删除</th></tr>");
					    		  for(var i=0;i<list.length;i++){
					    			  $("#newstable").append("<tr><td>"+list[i].title+
					    					              "</td><td>"+list[i].content+
					    					              "</td><td>"+list[i].istDateFormat+
					    					              "</a></td><td><a href='javascript:editNews("+list[i].id+")'>"+"修改"+
					    					              "</a></td><td><a href='javascript:deleteNews("+list[i].id+")'>"+"删除"+
					    					              "</a></td></tr>"
					    					              );
					    					  
					    		  }
					    		    	 $("td").css("text-align","center");
			    			 }
		 		    					  
		 		    		  }
	    		    		
			    		  if(list.length==0){
					    		 $("#down_center").html("没有找到符合条件的公告信息");
					    		 $("#pageutil").hide();
					    	
					    		 }
			    		 
			    		  }
			       
			   
			});		
	  
    } 
	
function checkDate(d){
	   var ds=d.match(/\d+/g),ts=['getFullYear','getMonth','getDate'];
	     var d=new Date(d.replace(/-/g,'/')),i=3;
	     ds[1]--;
	     while(i--)if( ds[i]*1!=d[ts[i]]()) return false;
	     return true;
	    }
	   
	   
	   
	   
		function deleteNews(id){
		var pagesize=$("#pagesize").attr("value");
		var pageno=1;
		$("#pageno").attr("value",1);
		var pagenumber=1;//页面信息
		var r=confirm("确定删除吗？");
        if(r==true){
        $.ajax({
	    type:"post",
        url: "${pageContext.request.contextPath}/news/deleteNewsById",
        data:{pagesize:pagesize,pagenumber:pagenumber,id:id},
       success:function(value){
                      pagecount=value.page.totalPageCount;
		    	      list=value.list;
		    		  listsize=value.listsize;
		    		  $("#totalcount").attr("value",value.page.totalCount);
		    		  $("#totalpagecount").attr("value",pagecount);
		    		  $("#pagetotalcount").attr("value",pagecount);
		    		  $("#pagenumber").empty();
		    		  $("#c1").val("");
		    		  $("#c2").val("");
		    		  $("#newstitle").val("");
		    	 for(var i=1;i<=pagecount;i++){
		 	    		 $("#pagenumber").append("<option value=\""+i+"\">"+i+"</ooption>");
		 	    		  } 	
		    		  $("#newstable").html("<tr><th>公告标题</th><th>公告内容</th><th>公告时间</th><th>修改</th><th>删除</th></tr>");
					    		  for(var i=0;i<list.length;i++){
					    			  $("#newstable").append("<tr><td>"+list[i].title+
					    					              "</td><td>"+list[i].content+
					    					              "</td><td>"+list[i].istDateFormat+
					    					              "</a></td><td><a href='javascript:editNews("+list[i].id+")'>"+"修改"+
					    					             "</a></td><td><a href='javascript:deleteNews("+list[i].id+")'>"+"删除"+
					    					              "</a></td></tr>"
					    					              );
					    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
					    					  
					    		  }
					    		    	 $("td").css("text-align","center");
			    			  }
 
 
  
   
   });
		}
		
		}   	
</script>
<style type="text/css">
a{text-decoration: none;}
table.newstable {
position:absolute;
 font-family: verdana,arial,sans-serif;
 font-size:11px;
 color:#333333;
 border-width: 1px;
 border-color: #999999;
 border-collapse: collapse;
 left:140px;
width:1100px;
}
div.pageutil{
position:relative;
 left:490px;
}
div.title{
position:relative;
 left:160px;
width:1100px;
}
table.searchCondition{
position:relative;
left:150px;
width:1100px;
}
table.newstable th {
 background:#b5cfd2 url('cell-blue.jpg');
 border-width: 1px;
 padding: 8px;
 border-style: solid;
 border-color: #999999;
}
table.newstable td {
 background:#dcddc0 url('cell-grey.jpg');
 border-width: 1px;
 padding: 8px;
 border-style: solid;
 border-color: #999999;
}
a{
text-decoration: none;
}
#th{
color:red;
}

#down_center{
position:relative;
 top:40px;
 left:160px;
width:1100px;

}
</style>
</head>
<body style="overflow:-Scroll;overflow-x:hidden">
<div class="title"><h1>系统公告查询</h1></div>
<form name="myform">
<input   type="hidden" name="id" value=""> 
<input type="hidden" name="listsize"  id="listsize" value="${page.totalCount}" id="listsize">
<input type="hidden" name="pagenumber1" value="${page.pageNow}" id="pagenumber1">
<input type="hidden" name="pagetotalcount"  id="pagetotalcount" value=""> 
<input type="hidden" name="usertype" id="usertype" value="${userType}">
<input type="hidden" name="userid" id="userid" value="${userid}">
<table boder="1" cellpadding="10" class="searchCondition">
<tr>
<td >开始时间
	<input type="text" id="c2"  onclick="J.calendar.get({dir:'right'});" name="startDate"/ onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg1').innerHTML=''"/>&nbsp;
<div style="display: inline" id="msg1"></div></td>
<td>截至时间
 <input type="text" id="c1"  onclick="J.calendar.get();" name="endDate" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg2').innerHTML=''"/>
<div style="display: inline" id="msg2"></div></td>
<td>公告标题<input type="text" id="newstitle" name="newstitle">
<div style="display: inline" id="msg3"></div></td>
<td>
<input type="button" value="查询" onclick="querySomeVersion1()">
</td>
</tr>
</table>
</br>
<div id="pageutil" class="pageutil">
   <td>共有<input class="blue" id="totalcount" type="button" value="${page.totalCount}">条记录</td>
    <td>每页显示<select id="pagesize"  onchange="getFunByCriteria()">
      <option selected="selected">10</option>
    <option>20</option>
    <option>50</option>
    <option>100</option>
    </select>条
     共有 <input class="blue" id="totalpagecount" type="button">页 
    当前显示第 <input class="blue" id="pageno" type="button" value=1>
     页    跳转  <select id="pagenumber" onchange="toSelectedPage()">
    </select>
      页
    </td>
     <!-- 首页按钮，跳转到首页 -->
    <td>
    <c:if test="${page.pageNow <= 1 }"></c:if>
  
    <a href="javascript:firstpage()">首页</a>
   
   
      <a href="javascript:forwardpage()">上一页</a>
  
   

   
    <a href="javascript:nextpage()">下一页</a>
     
   
  
     <a href="javascript:lastpage()">末页</a>
 </td>
 </div>
 <table id="newstable" class="newstable"> 
<tr>
<th>公告标题</th>
<th>公告内容</th>
<th>公告时间</th>
<th id="edit">修改</th>
<th id="delete">删除</th>
</tr>
<c:forEach items="${requestScope.newsList}" var="news" varStatus="vs">
<tr>
<td style="text-align: center;">${news.title}</td>
<td style="text-align: center;">${news.content}</td>
<td style="text-align: center;">${news.istDateFormat}</td>
<td name="edit" style="text-align: center;"><a href="javascript:editNews('${ news.id}')" >修改</a></td>
<td name="delete" style="text-align: center;"><a href="javascript:deleteNews('${ news.id}')" >删除</a></td>
</tr>

</c:forEach>
</table>
</form>
<div id="down_center"></div>		
</body>
</html>