<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
     <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
System.out.println(basePath);
%>
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
<title>Insert title here</title>
<script type="text/javascript">
function userquery(){
	 var form = document.forms[0];
	  var userName= document.getElementsByName("userName")[0].value;  
	  if(userName.trim().length==0){
		document.getElementById("msg1").innerHTML = "<font color='red'> 用户名称不能为空</font>";
		document.getElementsByName("userName")[0].focus();
		document.getElementsByName("userName")[0].style.borderColor="red";
		document.getElementsByName("userName")[0].style.borderStyle="dotted";
		return false;
	}
	 form.action = "${pageContext.request.contextPath}/user/querySomeUser"; 
	 form.method = "post";  
     form.submit();  
     }
     function editUser(id){
	 var form = document.forms[0];  
	 form.action = "${pageContext.request.contextPath}/user/updateUser/${userid}"; 
	 document.forms.myform.id.value = id;
	 form.method = "post";  
    form.submit();  
}
     
     window.onload=function(){ 
	var array = new Array();  
	    <c:if test="${empty requestScope.userinfoList}">
	    //document.getElementById("down_center").innerHTML = "没有找到符合条件的用户";
	    </c:if>
	    var pagenumber=$("#pagenumber1").val();
	     $("#pageno").attr("value",1);
	    var pagesize=$("#pagesize").attr("value");
	
	   var listcount=$("#totalcount").val();
	   var pagenumber=$("#pagenumber1").val();
	     $.ajax({
	    	type:"post",
	        url: "${pageContext.request.contextPath}/user/queryByCriteria",
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
 		$("#pageno").attr("value",1);
 		var pagesize=$("#pagesize").attr("value");
 		var listcount=$("#totalcount").val();
 		var listsize=$("#listsize").val();
 		var pagenumber=$("#pagenumber1").val();
 			 var form = document.forms[0];
 			  var userName= document.getElementsByName("userName")[0].value; 
 			$.ajax({
 				type:"post",
 			    url: "${pageContext.request.contextPath}/user/querySomeByCriteria",
 			    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,username:userName},
 			    success:function(value){
 			    		  pagecount=value.pageCount;
 			    		  list=value.userlist;
 			    		  listsize=value.listsize;
 			    		  $("#totalpagecount").attr("value",pagecount);
 			    		  $("#pagetotalcount").attr("value",pagecount);
 			    		  $("#pagenumber").empty();
 			    		  for(var i=1;i<=pagecount;i++){
 			 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
 			 	    		
 			 	    		  } 	
 			    		  if(list.length>0){
 			    			 $("#usertable").html("<tr><th>用户名称</th><th>用户帐号</th><th>用户密码</th><th>修改</th></tr>");
 		 		    		  for(var i=0;i<list.length;i++){
 		 		    			  $("#usertable").append("<tr><td>"+list[i].userName+
 		 		    					              "</td><td>"+list[i].loginName+
 		 		    					              "</td><td>"+list[i].loginpass+
 		 		    					              "</a></td><td><a href='javascript:editUser("+list[i].id+")'>"+"修改"+
 		 		    					              "</a></td></tr>"
 		 		    					              );
 		 		    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
 		 		    					  
 		 		    		  }
 		 		    		    	 $("td").css("text-align","center");
 	    		    		 }
 			    		  if(list.length==0){
 					    		 $("#down_center").html("没有找到符合条件的用户");
 					    	
 					    		 }     
 			    }	
 			});	
 		}
 	
     function firstpage(){
    	 //alert("已到第一页");
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
	 			  var userName= document.getElementsByName("userName")[0].value; 
	 			$.ajax({
	 				type:"post",
	 			    url: "${pageContext.request.contextPath}/user/querySomeByCriteria",
	 			    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,username:userName},
	 			    success:function(value){
	 			    		  pagecount=value.pageCount;
	 			    		  list=value.userlist;
	 			    		  listsize=value.listsize;
	 			    		  $("#totalpagecount").attr("value",pagecount);
	 			    		  $("#pagetotalcount").attr("value",pagecount);
	 			    		  $("#pagenumber").empty();
	 			    		  for(var i=1;i<=pagecount;i++){
	 			 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
	 			 	    		
	 			 	    		  } 	
	 			    		  //alert(list.length);
	 			    		  
	 			    		  if(list.length>0){
	 			    			 $("#usertable").html("<tr><th>用户名称</th><th>用户帐号</th><th>用户密码</th><th>修改</th></tr>");
	 		 		    		  for(var i=0;i<list.length;i++){
	 		 		    			  $("#usertable").append("<tr><td>"+list[i].userName+
	 		 		    					              "</td><td>"+list[i].loginName+
	 		 		    					              "</td><td>"+list[i].loginpass+
	 		 		    					              "</a></td><td><a href='javascript:editUser("+list[i].id+")'>"+"修改"+
	 		 		    					              "</a></td></tr>"
	 		 		    					              );
	 		 		    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
	 		 		    					  
	 		 		    		  }
	 		 		    		    	 $("td").css("text-align","center");
	 	    		    		 }
	 			    		  if(list.length==0){
	 					    		 $("#down_center").html("没有找到符合条件的用户");
	 			    		  }
	 					    		   
	 			    }	
	 			});	
	 		}
     function forwardpage(){
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
	 			  var userName= document.getElementsByName("userName")[0].value; 
	 			$.ajax({
	 				type:"post",
	 			    url: "${pageContext.request.contextPath}/user/querySomeByCriteria",
	 			    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,username:userName},
	 			    success:function(value){
	 			    		  pagecount=value.pageCount;
	 			    		  list=value.userlist;
	 			    		  listsize=value.listsize;
	 			    		  $("#totalpagecount").attr("value",pagecount);
	 			    		  $("#pagetotalcount").attr("value",pagecount);
	 			    		  $("#pagenumber").empty();
	 			    		  for(var i=1;i<=pagecount;i++){
	 			 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
	 			 	    		
	 			 	    		  } 	
	 			    		  //alert(list.length);
	 			    		  
	 			    		  if(list.length>0){
	 			    			 $("#usertable").html("<tr><th>用户名称</th><th>用户帐号</th><th>用户密码</th><th>修改</th></tr>");
	 		 		    		  for(var i=0;i<list.length;i++){
	 		 		    			  $("#usertable").append("<tr><td>"+list[i].userName+
	 		 		    					              "</td><td>"+list[i].loginName+
	 		 		    					              "</td><td>"+list[i].loginpass+
	 		 		    					              "</a></td><td><a href='javascript:editUser("+list[i].id+")'>"+"修改"+
	 		 		    					              "</a></td></tr>"
	 		 		    					              );
	 		 		    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
	 		 		    					  
	 		 		    		  }
	 		 		    		    	 $("td").css("text-align","center");
	 	    		    		 }
	 			    		  if(list.length==0){
	 					    		 $("#down_center").html("没有找到符合条件的用户");
	 			    		  }
	 			    }	
	 			});	
	 		}
     function nextpage(){
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
	 			  var userName= document.getElementsByName("userName")[0].value; 
	 			$.ajax({
	 				type:"post",
	 			    url: "${pageContext.request.contextPath}/user/querySomeByCriteria",
	 			    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,username:userName},
	 			    success:function(value){
	 			    		  pagecount=value.pageCount;
	 			    		  list=value.userlist;
	 			    		  listsize=value.listsize;
	 			    		  $("#totalpagecount").attr("value",pagecount);
	 			    		  $("#pagetotalcount").attr("value",pagecount);
	 			    		  $("#pagenumber").empty();
	 			    		  for(var i=1;i<=pagecount;i++){
	 			 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
	 			 	    		
	 			 	    		  } 	
	 			    		  //alert(list.length);
	 			    		  
	 			    		  if(list.length>0){
	 			    			 $("#usertable").html("<tr><th>用户名称</th><th>用户帐号</th><th>用户密码</th><th>修改</th></tr>");
	 		 		    		  for(var i=0;i<list.length;i++){
	 		 		    			  $("#usertable").append("<tr><td>"+list[i].userName+
	 		 		    					              "</td><td>"+list[i].loginName+
	 		 		    					              "</td><td>"+list[i].loginpass+
	 		 		    					              "</a></td><td><a href='javascript:editUser("+list[i].id+")'>"+"修改"+
	 		 		    					              "</a></td></tr>"
	 		 		    					              );
	 		 		    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
	 		 		    					  
	 		 		    		  }
	 		 		    		    	 $("td").css("text-align","center");
	 	    		    		 }
	 			    		  if(list.length==0){
	 					    		 $("#down_center").html("没有找到符合条件的用户");
	 					    	
	 					    		 }
	 			    }	
	 			});	
	 		}
     function lastpage(){
    	// alert("已到最后一页");
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
	 			  var userName= document.getElementsByName("userName")[0].value; 
	 			$.ajax({
	 				type:"post",
	 			    url: "${pageContext.request.contextPath}/user/querySomeByCriteria",
	 			    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,username:userName},
	 			    success:function(value){
	 			    		  pagecount=value.pageCount;
	 			    		  list=value.userlist;
	 			    		  listsize=value.listsize;
	 			    		  $("#totalpagecount").attr("value",pagecount);
	 			    		  $("#pagetotalcount").attr("value",pagecount);
	 			    		  $("#pagenumber").empty();
	 			    		  for(var i=1;i<=pagecount;i++){
	 			 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
	 			 	    		
	 			 	    		  } 	
	 			    		  //alert(list.length);
	 			    		  
	 			    		  if(list.length>0){
	 			    			 $("#usertable").html("<tr><th>用户名称</th><th>用户帐号</th><th>用户密码</th><th>修改</th></tr>");
	 		 		    		  for(var i=0;i<list.length;i++){
	 		 		    			  $("#usertable").append("<tr><td>"+list[i].userName+
	 		 		    					              "</td><td>"+list[i].loginName+
	 		 		    					              "</td><td>"+list[i].loginpass+
	 		 		    					              "</a></td><td><a href='javascript:editUser("+list[i].id+")'>"+"修改"+
	 		 		    					              "</a></td></tr>"
	 		 		    					              );
	 		 		    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
	 		 		    					  
	 		 		    		  }
	 		 		    		    	 $("td").css("text-align","center");
	 	    		    		 }
	 			    		  if(list.length==0){
	 					    		 $("#down_center").html("没有找到符合条件的用户");
	 					    	
	 					    		 }
	 			    }	
	 			});	
	 		}
     function toSelectedPage(){
			var pagenumber=$("#pagenumber").attr("value");
			var totalpagecount=$("#pagetotalcount").val();
			var pagesize=$("#pagesize").attr("value");
			var listcount=$("#totalcount").val();
			var listsize=$("#listsize").val();
			$("#pageno").attr("value",pagenumber);
	 			 var form = document.forms[0];
	 			  var userName= document.getElementsByName("userName")[0].value; 
	 			$.ajax({
	 				type:"post",
	 			    url: "${pageContext.request.contextPath}/user/querySomeByCriteria",
	 			    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,username:userName},
	 			    success:function(value){
	 			    		  pagecount=value.pageCount;
	 			    		  list=value.userlist;
	 			    		  listsize=value.listsize;
	 			    		  $("#totalpagecount").attr("value",pagecount);
	 			    		  $("#pagetotalcount").attr("value",pagecount);
	 			    		 /* $("#pagenumber").empty();
	 			    		  for(var i=1;i<=pagecount;i++){
	 			 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
	 			 	    		
	 			 	    		  } 	*/
	 			    		  //alert(list.length);
	 			    		  
	 			    		  if(list.length>0){
	 			    			 $("#usertable").html("<tr><th>用户名称</th><th>用户帐号</th><th>用户密码</th><th>修改</th></tr>");
	 		 		    		  for(var i=0;i<list.length;i++){
	 		 		    			  $("#usertable").append("<tr><td>"+list[i].userName+
	 		 		    					              "</td><td>"+list[i].loginName+
	 		 		    					              "</td><td>"+list[i].loginpass+
	 		 		    					              "</a></td><td><a href='javascript:editUser("+list[i].id+")'>"+"修改"+
	 		 		    					              "</a></td></tr>"
	 		 		    					              );
	 		 		    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
	 		 		    					  
	 		 		    		  }
	 		 		    		    	 $("td").css("text-align","center");
	 	    		    		 }
	 			    		  if(list.length==0){
	 					    		 $("#down_center").html("没有找到符合条件的用户");
	 					    	
	 			    		  }    		 
	 			    }	
	 			});	
	 		}
     function querySomeVersion1(){
    	 var totalpagecount=$("#pagetotalcount").val();
    		var pagesize=$("#pagesize").attr("value");
    		var pageno=1;
    		$("#pageno").attr("value",1);
    		var pagenumber=$("#pagenumber").attr("value");
    		var listcount=$("#totalcount").val();
    		var listsize=$("#listsize").val();
    	var userType=$("#usertype").val();
    	 var form = document.forms[0];
		  var userName= document.getElementsByName("userName")[0].value; 
		  $.ajax({
				type:"post",
			    url: "${pageContext.request.contextPath}/user/querySomeUser",
			    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,userName:userName},
			    success:function(value){
			    	 $("#usertable").empty();
		    		  list=value.userlist;
		    		  page=value.page; 
		    		 // listsize=value.listsize;
		    		  $("#totalcount").val(value.page.totalCount);
		    		  $("#pagetotalcount").val(value.page.totalPageCount);
		    		  $("#pagesize").val();
		    		  $("#pageno").attr("value",1);
		    		  var pagesize=$("#pagesize").attr("value");
		    		  var listcount=$("#totalcount").val();
		    		  var pagenumber=$("#pagenumber1").val();
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
			    			 
			    		 // <td><a href="javascript:download('${version.id}')">操作说明</a></td>
			    			  $("#usertable").html("<tr><th>用户名称</th><th>用户帐号</th><th>用户密码</th><th>修改</th></tr>");
 		 		    		  for(var i=0;i<list.length;i++){
 		 		    			  $("#usertable").append("<tr><td>"+list[i].userName+
 		 		    					              "</td><td>"+list[i].loginName+
 		 		    					              "</td><td>"+list[i].loginpass+
 		 		    					              "</a></td><td><a href='javascript:editUser("+list[i].id+")'>"+"修改"+
 		 		    					              "</a></td></tr>"
 		 		    					              );
 		 		    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
 		 		    					  
 		 		    		  }
 		 		    		    	 $("td").css("text-align","center");
	    		    		 }
			    		  if(list.length==0){
					    		 $("#down_center").html("没有找到符合条件的用户");
					    		 $("#pageutil").hide();
					    		 }
			    		  }
			});	  
     } 
</script>
<style type="text/css">
a{text-decoration: none;}
table.usertable {
position:absolute;
 font-family: verdana,arial,sans-serif;
 font-size:11px;
 color:#333333;
 border-width: 1px;
 border-color: #999999;
 border-collapse: collapse;
 left:150px;
width:1080px;
}
div.pageutil{
position:relative;
left:480px;
width:1100px;
}
div.title{
position:relative;
 left:160px;
width:1100px;
}
table.searchCondition{
position:relative;
left:150px;
width:480px;
}
table.usertable th {
 background:#b5cfd2 url('cell-blue.jpg');
 border-width: 1px;
 padding: 8px;
 border-style: solid;
 border-color: #999999;
}
table.usertable td {
 background:#dcddc0 url('cell-grey.jpg');
 border-width: 1px;
 padding: 8px;
 border-style: solid;
 border-color: #999999;
}
a{text-decoration: none;}
#th{
color:red;}

#down_center{
position:relative;
 left:160px;
width:1100px;
top:40px;

}
</style>
</head>
<body style="overflow:-Scroll;overflow-x:hidden">
<div class="title"><h1>用户查询</h1></div>
<form name="myform">
<input   type="hidden" name="id" value="">
<input type="hidden" name="listsize"  id="listsize" value="${page.totalCount}" id="listsize">
<input type="hidden" name="pagenumber1" value="${page.pageNow}" id="pagenumber1">
<input type="hidden" name="pagetotalcount"  id="pagetotalcount" value=""> 
<table class="searchCondition">
<tr>
<td>用户名称</td>
<td><input type="text" name="userName" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg1').innerHTML=''"/>
<div style="display: inline" id="msg1"></div></td>
<td><input type="button" value="查询" class="button" onclick="querySomeVersion1()">
</td>
<tr>
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
<table boder="1" cellpadding="10" id="usertable" class="usertable">
<tr>
<th>用户名称</th>
<th>用户账号</th>
<th>用户密码</th>
<th>修改</th>
</tr>
<c:forEach items="${requestScope.userinfoList}" var="user" varStatus="vs">
<tr>
<td style="text-align: center;">${user.userName}</td>
<td style="text-align: center;">${user.loginName} </td>
<td type="password" style="text-align: center;">${user.loginpass}</td>
  <td style="text-align: center;"><a href="javascript:editUser('${user.id}')" >修改</a></td>
</form>
</tr>
</c:forEach>
<div id="down_center"></div>	
</body>
</html>