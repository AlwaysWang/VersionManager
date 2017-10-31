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
<title>Insert title here</title>
<style type="text/css">
a{text-decoration: none;}
#down_center{
position:relative;
 left:160px;
width:1100px;
top:45px;
}
</style>
<script type="text/javascript">
function querySomeFunction(){
	 var form = document.forms[0];  
	 var startDate = document.getElementsByName("startDate")[0].value;
	 var endDate = document.getElementsByName("endDate")[0].value;
	 var functionName= document.getElementsByName("functionName")[0].value;
	 var testcode= document.getElementsByName("testcode")[0].value;
	 var begintime = document.getElementById("c2").value;
	 var endtime = document.getElementById("c1").value;
	 var r = new RegExp("^[1-2]\\d{3}-(0?[1-9]||1[0-2])-(0?[1-9]||[1-2][1-9]||3[0-1])$");
	 if(startDate.trim().length==0){
			document.getElementById("msg1").innerHTML = "<font color='red'> 开始时间不能为空</font>";
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
			document.getElementById("msg2").innerHTML = "<font color='red'> 截止时间不能为空</font>";
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
		 if(functionName.trim().length==0){
			document.getElementById("msg3").innerHTML = "<font color='red'> 功能名称不能为空</font>";
			document.getElementsByName("functionName")[0].focus();
			document.getElementsByName("functionName")[0].style.borderColor="red";
			document.getElementsByName("functionName")[0].style.borderStyle="dotted";
			return false;
		}
		 if(testcode==0){
				document.getElementById("msg4").innerHTML = "<font color='red'> * 测试类别不能为空</font>"
				return false;
			}
		
	 form.action = "${pageContext.request.contextPath}/function/querysomefunction"; 
	 form.method = "post";  
    form.submit(); 
}
function editfunction(id){
	 var form = document.forms[1];  
	 form.action = "${pageContext.request.contextPath}/function/updatefunction"; 
	 document.forms.myform.id.value=id;
	 form.method ="post";  
    form.submit();  
}
function download(savepath,name){ 
	 document.forms.myform1.savePath1.value = savepath;
	 document.forms.myform1.funname.value = name;
	var form = document.forms[0];  
	 form.action = "${pageContext.request.contextPath}/function/downloadtext";
	form.method = "post";  
	 form.submit();  

	 
	 
	 
	
}
window.onload=function(){ 

if(!!window.ActiveXObject || "ActiveXObject" in window){
$("#uploadFile").css("width","130px");
$("#uploadFile").css("margin-right","100px");
}
	var array = new Array();  
	<c:forEach items="${requestScope.installAllList}" var="item" varStatus="status" >  
	    array.push("${item}");  //对象，加引号
	 
	    alert("${item.verCode}");   //传递过来的是字符串，加引号 
	    </c:forEach>  
	  <c:if test="${empty requestScope.AllFunList}">
	  document.getElementById("down_center").innerHTML = "没有找到符合条件的功能";
	  $("#pageutil").hide();
	  $("#funtable").empty();
	    </c:if> 
	  var opts=document.getElementById('testcode').options;
	    var obj=new Object(),index=0;
	    while(index<opts.length){
	    	if(opts[index].text in obj) opts[index]=null;
	    	else{
	    		obj[opts[index].text]=opts[index].text;
	    		index++;
	    	}
	    }
	    obj=null;
	    
	    
	    var userType=$("#usertype").val();
	    if(userType=="普通用户"){
	    	$("#edit").hide();
	    	$("#delete").hide();
	    	$("td[name='edit']").hide();
	    	$("td[name='delete']").hide();
	    }

	    var pagenumber=$("#pagenumber1").val();
	     $("#pageno").attr("value",1);
	    var pagesize=$("#pagesize").attr("value");
	   var listcount=$("#totalcount").val();
	   var pagenumber=$("#pagenumber1").val();
	

	     $.ajax({
	    	type:"post",
	        url: "${pageContext.request.contextPath}/function/queryByCriteria",
	        data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,},
	        success:function(value){
	        		  pagecount=value.pageCount;
	        		  list=value.versionlist;
	        		  listsize=value.listsize;
	        		  $("#totalpagecount").attr("value",pagecount);
	        		  $("#pagetotalcount").attr("value",pagecount);
	        		  $("#pagenumber").empty();
	        		  for(var i=1;i<=pagecount;i++){
	     	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
	     	    		
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

	   function getFunByCriteria(){
		   var userType=$("#usertype").val();
	    		$("#pageno").attr("value",1);
	    		var pagesize=$("#pagesize").attr("value");
	    		var listcount=$("#totalcount").val();
	    		var listsize=$("#listsize").val();
	    		var pagenumber=$("#pagenumber1").val();
	    		var startDate = document.getElementsByName("startDate")[0].value;
	    		var endDate = document.getElementsByName("endDate")[0].value;
	    		var typeName= document.getElementsByName("typetest")[0].value;
	    		var testname=document.getElementsByName("testcode")[0].value;
	    		var testCode=$("#testcode").find("option:selected").text();
	    			$.ajax({
	    				type:"post",
	    			    url: "${pageContext.request.contextPath}/function/querySomeListByCriteria",
	    			    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,typetest:typeName,typename:testCode},
	    			    //dataType:"text",
	    			    success:function(value){
	    			    		  pagecount=value.pageCount;
	    			    		  list=value.funlist;
	    			    		  listsize=value.listsize;
	    			    
	    			    		  $("#totalpagecount").attr("value",pagecount);
	    			    		  $("#pagetotalcount").attr("value",pagecount);
	    			    		  $("#pagenumber").empty();
	    			    		  for(var i=1;i<=pagecount;i++){
	    			 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
	    			 	    		
	    			 	    		  } 	
	    			    		  //alert(list.length);
	    			    		  
	    			    		  if(list.length>0){
	    			    		   $("#funtable").empty();
	    			    			 $("#down_center").hide();
	    			    		if(userType=="普通用户"){
	    			    			  $("#funtable").html("<tr><th>功能ID</th><th>功能名称</th><th>测试类别</th><th>调试手册下载</th><th>功能创建时间</th></tr>");
	    	    		    		  for(var i=0;i<list.length;i++){
	    	    		    		
	    	    		    			 //list[i].savePath.replace(/\\/g, "/");
	    	    		    			  //alert(list[i].savePath.replace(/\\/g, "/"));
	    	    		    			  $("#funtable").append("<tr><td>"+list[i].id+
	    	    		    					             "</td><td>"+list[i].name+
	    	    		    					              "</td><td>"+list[i].testType.typeName+
	    	    		    					              "</a></td><td><a href='javascript:download(\""+list[i].debugFile+"\",\""+list[i].name+"\")'>"+"调试手册下载"+
	    	    		    					              "</td><td>"+list[i].istDateFormat+
	    	    		    					              "</a></td></tr>"
	    	    		    					              );
	    	    		    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
	    	    		    					  
	    	    		    		  }
	    	    		    		  		  	 $("td").css("text-align","center");}
	    			    		else{
	    			    			 $("#funtable").html("<tr><th>功能ID</th><th>功能名称</th><th>测试类别</th><th>调试手册下载</th><th>功能创建时间</th><th>修改</th><th>删除</th></tr>");
	    	    		    		  for(var i=0;i<list.length;i++){
	    	    		    		
	    	    		    			 //list[i].savePath.replace(/\\/g, "/");
	    	    		    			  //alert(list[i].savePath.replace(/\\/g, "/"));
	    	    		    			  $("#funtable").append("<tr><td>"+list[i].id+
	    	    		    					             "</td><td>"+list[i].name+
	    	    		    					              "</td><td>"+list[i].testType.typeName+
	    	    		    					              "</a></td><td><a href='javascript:download(\""+list[i].debugFile+"\",\""+list[i].name+"\")'>"+"调试手册下载"+
	    	    		    					              "</td><td>"+list[i].istDateFormat+
	    	    		    					              "</a></td><td><a href='javascript:editfunction("+list[i].id+")'>"+"修改"+
	    	    		    					                  "</a></td><td><a href='javascript:deletefunction("+list[i].id+")'>"+"删除"+
	    	    		    					              "</a></td></tr>"
	    	    		    					              );
	    	    		    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
	    	    		    					  
	    	    		    		  }
	    	    		    		  		  	 $("td").css("text-align","center");
	    			    		}
	    	    		    		 }
	    			    		  if(list.length==0){
	    					    		 $("#down_center").html("没有找到符合条件的版本");
	    					    		 }    
	    			    }	
	    			});	
	    		}
	    		function firstpage(){
	    			 var userType=$("#usertype").val();
	    			var listcount=$("#totalcount").val();
	    			var listsize=$("#listsize").val();
	    			var opt=$("#pagesize").find("option:selected").text();
	    			var opt1=$("#pageno").find("option:selected").text();
	    			var startDate = document.getElementsByName("startDate")[0].value;
	    			 var endDate = document.getElementsByName("endDate")[0].value;
	    			 //var typeName= document.getElementsByName("typetest")[0].value;
	    			 var functionName= document.getElementsByName("functionName")[0].value;
		    		// var testcode= document.getElementsByName("testcode")[0].value;
		    		 var testcode=$("#testcode").find("option:selected").text();
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
	    		/*	if(pageno==1){
	    			alert("已到第一页");
	    
	    			}*/
	    		
	    			$("#pageno").attr("value",1);
	    			var pagenumber=$("#pageno").val();
	    			$.ajax({
	    			type:"post",
	    		    url: "${pageContext.request.contextPath}/function/querySomeListByCriteria",
	    		    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,funname:functionName,typename:testcode},
	    		    //dataType:"text",
	    		    success:function(value){
	    		    	
	    		    		  pagecount=value.pageCount;
	    		    		  list=value.funlist;
	    		    		  $("#totalpagecount").attr("value",pagecount);
	    		    		  $("#pagenumber").empty();
	    		    		  for(var i=1;i<=pagecount;i++){
	    		 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
	    		 	    		
	    		 	    		  }
	    		    		  if(list.length>0){
	    			    		   $("#funtable").empty();
	    			    		if(userType=="普通用户"){
	    			    			  $("#funtable").html("<tr><th>功能ID</th><th>功能名称</th><th>测试类别</th><th>调试手册下载</th><th>功能创建时间</th></tr>");
	    	    		    		  for(var i=0;i<list.length;i++){
	    	    		    		
	    	    		    			 //list[i].savePath.replace(/\\/g, "/");
	    	    		    			  //alert(list[i].savePath.replace(/\\/g, "/"));
	    	    		    			  $("#funtable").append("<tr><td>"+list[i].id+
	    	    		    					             "</td><td>"+list[i].name+
	    	    		    					              "</td><td>"+list[i].testType.typeName+
	    	    		    					              "</a></td><td><a href='javascript:download(\""+list[i].debugFile+"\",\""+list[i].name+"\")'>"+"调试手册下载"+
	    	    		    					              "</td><td>"+list[i].istDateFormat+
	    	    		    					              "</a></td></tr>"
	    	    		    					              );
	    	    		    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
	    	    		    					  
	    	    		    		  }
	    	    		    		  		  	 $("td").css("text-align","center");}
	    			    		else{
	    			    			 $("#funtable").html("<tr><th>功能ID</th><th>功能名称</th><th>测试类别</th><th>调试手册下载</th><th>功能创建时间</th><th>修改</th><th>删除</th></tr>");
	    	    		    		  for(var i=0;i<list.length;i++){
	    	    		    		
	    	    		    			 //list[i].savePath.replace(/\\/g, "/");
	    	    		    			  //alert(list[i].savePath.replace(/\\/g, "/"));
	    	    		    			  $("#funtable").append("<tr><td>"+list[i].id+
	    	    		    					             "</td><td>"+list[i].name+
	    	    		    					              "</td><td>"+list[i].testType.typeName+
	    	    		    					              "</a></td><td><a href='javascript:download(\""+list[i].debugFile+"\",\""+list[i].name+"\")'>"+"调试手册下载"+
	    	    		    					              "</td><td>"+list[i].istDateFormat+
	    	    		    					              "</a></td><td><a href='javascript:editfunction("+list[i].id+")'>"+"修改"+
	    	    		    					              "</a></td><td><a href='javascript:deletefunction("+list[i].id+")'>"+"删除"+
	    	    		    					              "</a></td></tr>"
	    	    		    					              );
	    	    		    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
	    	    		    					  
	    	    		    		  }
	    	    		    		  		  	 $("td").css("text-align","center");
	    			    		}
	    		    		  }}	 
	    		
	    		});
	    		}		
	    		function forwardpage(){
	    			 var userType=$("#usertype").val();
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
	    			var startDate = document.getElementsByName("startDate")[0].value;
	    			 var endDate = document.getElementsByName("endDate")[0].value;
	    			 //var typeName= document.getElementsByName("typetest")[0].value;
	    			 var functionName= document.getElementsByName("functionName")[0].value;
		    		// var testcode= document.getElementsByName("testcode")[0].value;
	    		var testCode=$("#testcode").find("option:selected").text();
	    			$.ajax({
	    				type:"post",
	    			    url: "${pageContext.request.contextPath}/function/querySomeListByCriteria",
	    			    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,funname:functionName,typename:testCode},
	    			    success:function(value){
	    			    		  pagecount=value.pageCount;
	    			    		  list=value.funlist;
	    			    		  listsize=value.listsize;
	    			    		  $("#totalpagecount").attr("value",pagecount);
	    			    		  $("#pagetotalcount").attr("value",pagecount);
	    			    		  $("#pagenumber").empty();
	    			    		  //alert(pagecount);
	    			    		  for(var i=1;i<=pagecount;i++){
	    			 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
	    			    		  }
	    			 	    		 if(list.length>0){
	  	    			    		   $("#funtable").empty();
	  	    			    		if(userType=="普通用户"){
	  	    			    			  $("#funtable").html("<tr><th>功能ID</th><th>功能名称</th><th>测试类别</th><th>调试手册下载</th><th>功能创建时间</th></tr>");
	  	    	    		    		  for(var i=0;i<list.length;i++){
	  	    	    		    		
	  	    	    		    			 //list[i].savePath.replace(/\\/g, "/");
	  	    	    		    			  //alert(list[i].savePath.replace(/\\/g, "/"));
	  	    	    		    			  $("#funtable").append("<tr><td>"+list[i].id+
	  	    	    		    					             "</td><td>"+list[i].name+
	  	    	    		    					              "</td><td>"+list[i].testType.typeName+
	  	    	    		    					              "</a></td><td><a href='javascript:download(\""+list[i].debugFile+"\",\""+list[i].name+"\")'>"+"调试手册下载"+
	  	    	    		    					            "</td><td>"+list[i].istDateFormat+
	  	    	    		    					              "</a></td></tr>"
	  	    	    		    					              );
	  	    	    		    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
	  	    	    		    					  
	  	    	    		    		  }
	  	    	    		    		  		  	 $("td").css("text-align","center");
	  	    	    		    		  		  	 }
	  	    			    		else{
	  	    			    			 $("#funtable").html("<tr><th>功能ID</th><th>功能名称</th><th>测试类别</th><th>调试手册下载</th><th>功能创建时间</th><th>修改</th><th>删除</th></tr>");
	  	    	    		    		  for(var i=0;i<list.length;i++){
	  	    	    		    		
	  	    	    		    			 //list[i].savePath.replace(/\\/g, "/");
	  	    	    		    			  //alert(list[i].savePath.replace(/\\/g, "/"));
	  	    	    		    			  $("#funtable").append("<tr><td>"+list[i].id+
	  	    	    		    					             "</td><td>"+list[i].name+
	  	    	    		    					              "</td><td>"+list[i].testType.typeName+
	  	    	    		    					              "</a></td><td><a href='javascript:download(\""+list[i].debugFile+"\",\""+list[i].name+"\")'>"+"调试手册下载"+
	  	    	    		    					            "</td><td>"+list[i].istDateFormat+
	  	    	    		    					              "</a></td><td><a href='javascript:editfunction("+list[i].id+")'>"+"修改"+
	  	    	    		    					              "</a></td><td><a href='javascript:deletefunction("+list[i].id+")'>"+"删除"+
	  	    	    		    					              "</a></td></tr>"
	  	    	    		    					              );
	  	    	    		    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
	  	    	    		    					  
	  	    	    		    		  }
	  	    	    		    		  		  	 $("td").css("text-align","center");
	  	    			    		}
	  	    	    		    		 }
	    			    		  if(list.length==0){
	    					    		 $("#down_center").html("没有找到符合条件的版本");
	    					    	
	    			    		  } 
	    			    	}
	    			});		
	    		
	    		}  		
	    		function nextpage(){
	    			 var userType=$("#usertype").val();
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
	    			var startDate = document.getElementsByName("startDate")[0].value;
	    			 var endDate = document.getElementsByName("endDate")[0].value;
	    			 var functionName= document.getElementsByName("functionName")[0].value;
		    		// var testcode= document.getElementsByName("testcode")[0].value;
		    		 var testcode=$("#testcode").find("option:selected").text();
	    			$.ajax({
	    				type:"post",
	    			    url: "${pageContext.request.contextPath}/function/querySomeListByCriteria",
	    			    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,funname:functionName,typename:testcode},
	    			    //dataType:"text",
	    			    success:function(value){
	    			    		  pagecount=value.pageCount;
	    			    		  list=value.funlist;
	    			    		  listsize=value.listsize;
	    			    		  $("#totalpagecount").attr("value",pagecount);
	    			    		  $("#pagetotalcount").attr("value",pagecount);
	    			    		  $("#pagenumber").empty();
	    			    		  for(var i=1;i<=pagecount;i++){
	    			 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
	    			 	    		
	    			 	    		  } 	
	    			    		  //alert(list.length);
	    			    		  

	    			 	    		 if(list.length>0){
	    			 	    			 
	  	    			    		   $("#funtable").empty();
	  	    			    		if(userType=="普通用户"){
	  	    			    			  $("#funtable").html("<tr><th>功能ID</th><th>功能名称</th><th>测试类别</th><th>调试手册下载</th><th>功能创建时间</th></tr>");
	  	    	    		    		  for(var i=0;i<list.length;i++){
	  	    	    		    		
	  	    	    		    			 //list[i].savePath.replace(/\\/g, "/");
	  	    	    		    			  //alert(list[i].savePath.replace(/\\/g, "/"));
	  	    	    		    			  $("#funtable").append("<tr><td>"+list[i].id+
	  	    	    		    					             "</td><td>"+list[i].name+
	  	    	    		    					              "</td><td>"+list[i].testType.typeName+
	  	    	    		    					              "</a></td><td><a href='javascript:download(\""+list[i].debugFile+"\",\""+list[i].name+"\")'>"+"调试手册下载"+
	  	    	    		    					            "</td><td>"+list[i].istDateFormat+
	  	    	    		    					              "</a></td></tr>"
	  	    	    		    					              );
	  	    	    		    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
	  	    	    		    					  
	  	    	    		    		  }
	  	    	    		    		  		  	 $("td").css("text-align","center");
	  	    	    		    		  		  	 }
	  	    			    		else{
	  	    			    			 $("#funtable").html("<tr><th>功能ID</th><th>功能名称</th><th>测试类别</th><th>调试手册下载</th><th>功能创建时间</th><th>修改</th><th>删除</th></tr>");
	  	    	    		    		  for(var i=0;i<list.length;i++){
	  	    	    		    		
	  	    	    		    			 //list[i].savePath.replace(/\\/g, "/");
	  	    	    		    			  //alert(list[i].savePath.replace(/\\/g, "/"));
	  	    	    		    			  $("#funtable").append("<tr><td>"+list[i].id+
	  	    	    		    					             "</td><td>"+list[i].name+
	  	    	    		    					              "</td><td>"+list[i].testType.typeName+
	  	    	    		    					              "</a></td><td><a href='javascript:download(\""+list[i].debugFile+"\",\""+list[i].name+"\")'>"+"调试手册下载"+
	  	    	    		    					            "</td><td>"+list[i].istDateFormat+
	  	    	    		    					              "</a></td><td><a href='javascript:editfunction("+list[i].id+")'>"+"修改"+
	  	    	    		    					              "</a></td><td><a href='javascript:deletefunction("+list[i].id+")'>"+"删除"+
	  	    	    		    					              "</a></td></tr>"
	  	    	    		    					              );
	  	    	    		    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
	  	    	    		    					  
	  	    	    		    		  }
	  	    	    		    		  		  	 $("td").css("text-align","center");
	  	    			    		}
	  	    	    		    		 }
	    			    		 
	    			    	
	    			       
	    			    }	
	    			});		
	    		
	    		}  		
	    		function lastpage(){
	    			 var userType=$("#usertype").val();
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
	    	    var startDate = document.getElementsByName("startDate")[0].value;
	    	    var endDate = document.getElementsByName("endDate")[0].value;
	    	    var functionName= document.getElementsByName("functionName")[0].value;
	    		// var testcode= document.getElementsByName("testcode")[0].value;
	    		 var testcode=$("#testcode").find("option:selected").text();
	    			$.ajax({
	    				type:"post",
	    			    url: "${pageContext.request.contextPath}/function/querySomeListByCriteria",
	    			    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,funname:functionName,typename:testcode},
	    			    success:function(value){
	    			    		  pagecount=value.pageCount;
	    			    		  list=value.funlist;
	    			    		  listsize=value.listsize;
	    			    		  $("#totalpagecount").attr("value",pagecount);
	    			    		  $("#pagetotalcount").attr("value",pagecount);
	    			    		  $("#pagenumber").empty();
	    			    		  for(var i=1;i<=pagecount;i++){
	    			 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
	    			 	    		
	    			 	    		  } 	
	    			    	
	    			    		  

	    			 	    		 if(list.length>0){
	  	    			    		   $("#funtable").empty();
	  	    			    		if(userType=="普通用户"){
	  	    			    			  $("#funtable").html("<tr><th>功能ID</th><th>功能名称</th><th>测试类别</th><th>调试手册下载</th><th>功能创建时间</th></tr>");
	  	    	    		    		  for(var i=0;i<list.length;i++){
	  	    	    		    		
	  	    	    		    			 //list[i].savePath.replace(/\\/g, "/");
	  	    	    		    			  //alert(list[i].savePath.replace(/\\/g, "/"));
	  	    	    		    			  $("#funtable").append("<tr><td>"+list[i].id+
	  	    	    		    					             "</td><td>"+list[i].name+
	  	    	    		    					              "</td><td>"+list[i].testType.typeName+
	  	    	    		    					              "</a></td><td><a href='javascript:download(\""+list[i].debugFile+"\",\""+list[i].name+"\")'>"+"调试手册下载"+
	  	    	    		    					            "</td><td>"+list[i].istDateFormat+
	  	    	    		    					              "</a></td></tr>"
	  	    	    		    					              );
	  	    	    		    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
	  	    	    		    					  
	  	    	    		    		  }
	  	    	    		    		  		  	 $("td").css("text-align","center");}
	  	    			    		else{
	  	    			    			 $("#funtable").html("<tr><th>功能ID</th><th>功能名称</th><th>测试类别</th><th>调试手册下载</th><th>功能创建时间</th><th>修改</th><th>删除</th></tr>");
	  	    	    		    		  for(var i=0;i<list.length;i++){
	  	    	    		    		
	  	    	    		    			 //list[i].savePath.replace(/\\/g, "/");
	  	    	    		    			  //alert(list[i].savePath.replace(/\\/g, "/"));
	  	    	    		    			  $("#funtable").append("<tr><td>"+list[i].id+
	  	    	    		    					             "</td><td>"+list[i].name+
	  	    	    		    					              "</td><td>"+list[i].testType.typeName+
	  	    	    		    					              "</a></td><td><a href='javascript:download(\""+list[i].debugFile+"\",\""+list[i].name+"\")'>"+"调试手册下载"+
	  	    	    		    					            "</td><td>"+list[i].istDateFormat+
	  	    	    		    					              "</a></td><td><a href='javascript:editfunction("+list[i].id+")'>"+"修改"+
	  	    	    		    					              "</a></td><td><a href='javascript:deletefunction("+list[i].id+")'>"+"删除"+
	  	    	    		    					              "</a></td></tr>"
	  	    	    		    					              );
	  	    	    		    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
	  	    	    		    					  
	  	    	    		    		  }
	  	    	    		    		  		  	 $("td").css("text-align","center");
	  	    			    		}
	  	    	    		    		 }
	    			    		
	    			    		 
	    			    	
	    			       
	    			    }	
	    			});		
	    		
	    		}  		
	    		function toSelectedPage(){
	    			 var userType=$("#usertype").val();
	    			var pagenumber=$("#pagenumber").attr("value");
	    			var totalpagecount=$("#pagetotalcount").val();
	    			var pagesize=$("#pagesize").attr("value");
	    			var listcount=$("#totalcount").val();
	    			var listsize=$("#listsize").val();
	    			$("#pageno").attr("value",pagenumber);
		    			var startDate = document.getElementsByName("startDate")[0].value;
		    			 var endDate = document.getElementsByName("endDate")[0].value;
		    			  var functionName= document.getElementsByName("functionName")[0].value;
		 	    		 //var testcode= document.getElementsByName("testcode")[0].value;
		 	    		  var testcode=$("#testcode").find("option:selected").text();
		    			$.ajax({
		    				type:"post",
		    			    url: "${pageContext.request.contextPath}/function/querySomeListByCriteria",
		    			    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,funname:functionName,typename:testcode},
		    			    //dataType:"text",
		    			    success:function(value){
		    			    		  pagecount=value.pageCount;
		    			    		  list=value.funlist;
		    			    		  listsize=value.listsize;
		    			    		  $("#totalpagecount").attr("value",pagecount);
		    			    		  $("#pagetotalcount").attr("value",pagecount);

		    			 	    		 if(list.length>0){
		  	    			    		   $("#funtable").empty();
		  	    			    		if(userType=="普通用户"){
		  	    			    			  $("#funtable").html("<tr><th>功能ID</th><th>功能名称</th><th>测试类别</th><th>调试手册下载</th><th>功能创建时间</th></tr>");
		  	    	    		    		  for(var i=0;i<list.length;i++){
		  	    	    		    		
		  	    	    		    			 //list[i].savePath.replace(/\\/g, "/");
		  	    	    		    			  //alert(list[i].savePath.replace(/\\/g, "/"));
		  	    	    		    			  $("#funtable").append("<tr><td>"+list[i].id+
		  	    	    		    					             "</td><td>"+list[i].name+
		  	    	    		    					              "</td><td>"+list[i].testType.typeName+
		  	    	    		    					              "</a></td><td><a href='javascript:download(\""+list[i].debugFile+"\",\""+list[i].name+"\")'>"+"调试手册下载"+
		  	    	    		    					            "</td><td>"+list[i].istDateFormat+
		  	    	    		    					              "</a></td></tr>"
		  	    	    		    					              );
		  	    	    		    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
		  	    	    		    					  
		  	    	    		    		  }
		  	    	    		    		  		  	 $("td").css("text-align","center");
		  	    	    		    		  		  	 }
		  	    			    		else{
		  	    			    			 $("#funtable").html("<tr><th>功能ID</th><th>功能名称</th><th>测试类别</th><th>调试手册下载</th><th>功能创建时间</th><th>修改</th><th>删除</th></tr>");
		  	    	    		    		  for(var i=0;i<list.length;i++){
		  	    	    		    		
		  	    	    		    			 //list[i].savePath.replace(/\\/g, "/");
		  	    	    		    			  //alert(list[i].savePath.replace(/\\/g, "/"));
		  	    	    		    			  $("#funtable").append("<tr><td>"+list[i].id+
		  	    	    		    					             "</td><td>"+list[i].name+
		  	    	    		    					              "</td><td>"+list[i].testType.typeName+
		  	    	    		    					              "</a></td><td><a href='javascript:download(\""+list[i].debugFile+"\",\""+list[i].name+"\")'>"+"调试手册下载"+
		  	    	    		    					            "</td><td>"+list[i].istDateFormat+
		  	    	    		    					              "</a></td><td><a href='javascript:editfunction("+list[i].id+")'>"+"修改"+
		  	    	    		    					              "</a></td><td><a href='javascript:deletefunction("+list[i].id+")'>"+"删除"+
		  	    	    		    					              "</a></td></tr>"
		  	    	    		    					              );
		  	    	    		    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
		  	    	    		    					  
		  	    	    		    		  }
		  	    	    		    		  		  	 $("td").css("text-align","center");
		  	    			    		}
		  	    	    		    		 }
		    			    		  if(list.length==0){
		    					    		 $("#down_center").html("没有找到符合条件的版本");
		    			    		  }
		    					    		
		    			    }	
		    			});		
		    		
		    		}  		
	    	function querySomeVersion1(){
	    		 var userType=$("#usertype").val();
	    			var totalpagecount=$("#pagetotalcount").val();
	    			var pagesize=$("#pagesize").attr("value");
	    			var pageno=1;
	    			$("#pageno").attr("value",1);
	    			//var pagenumber=$("#pagenumber").attr("value");
	    			var pagenumber=1;
	    			var listcount=$("#totalcount").val();
	    			var listsize=$("#listsize").val();
	    		 var form = document.forms[0]; 
	    		 var startDate = document.getElementsByName("startDate")[0].value;
	    		 var endDate = document.getElementsByName("endDate")[0].value;
	    		 var functionName= document.getElementsByName("functionName")[0].value;
	    		 //var testcode= document.getElementsByName("testcode")[0].value;
	    		  var  typename = document.getElementById("typetest").value;
	    		 var testcode=$("#testcode").find("option:selected").text();
	    		 var begintime = document.getElementById("startDate").value;
	    		 var endtime = document.getElementById("endDate").value;
		if(startDate.trim().length!=0){
	 if(checkDate(begintime)==false){
	  $("#pageutil").hide();
		 document.getElementById("msg1").innerHTML = "<font color='red'> 请输入正确的时间格式</font>";
		  $("#funtable").empty();
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
			  $("#funtable").empty();
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
		 if(typename!="请选择"&&testcode==""){
		  document.getElementById("msg5").innerHTML = "<font color='red'>该测试类别没有测试类型</font>";
		 }
		 if(typename!="请选择"&&testcode!=""){
		 document.getElementById("msg5").innerHTML = "";
		 }
		 
	    		 $.ajax({
	    				type:"post",
	    			    url: "${pageContext.request.contextPath}/function/querysomefunction",
	    			    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,funname:functionName,typename:testcode},
	    			    success:function(value){
	    			    	//alert(value.page.totalPageCount);
	    			    	 $("#funtable").empty();
				    		  list=value.funlist;
				    		  page=value.page; 
				    		  listsize=value.listsize;
				    		  $("#totalcount").val(value.page.totalCount);
				    		  $("#pagetotalcount").val(value.page.totalPageCount);
				    		  $("#pagesize").val();
				    		  $("#pageno").attr("value",1);
				    		  var pagesize=$("#pagesize").attr("value");
				    		  var listcount=$("#totalcount").val();
				    		  var pagenumber=$("#pagenumber1").val();
				    		 // alert(listcount+"listcount");
				    		 // alert(pagesize+"pagesize");
				    		  if(parseInt(listcount)%parseInt(pagesize)==0){
				    		
				    			  $("#totalpagecount").attr("value",listcount/pagesize);
				    		  }
				    		  if(parseInt(listcount)<=parseInt(pagesize)){
				    			 
				    			  $("#totalpagecount").attr("value","1");
				    		  }
				    		  if(parseInt(listcount)%parseInt(pagesize)!=0){
				    		
				    			  $("#totalpagecount").attr("value",parseInt(listcount/pagesize)+1);
				    		  }
				    		// alert( $("#totalpagecount").val());
				    		 
				    		  $("#pagenumber").empty();
					    		  for(var i=1;i<=$("#totalpagecount").val();i++){
					 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
					 	    		
					    		  }
	    			    		  if(list.length>0){
	    			    			  $("#pageutil").show();
	    			    			  $("#down_center").empty();
	    			    			 if(userType=="普通用户"){
	    			    		 // <td><a href="javascript:download('${version.id}')">操作说明</a></td>
	    			    			  $("#funtable").html("<tr><th>功能ID</th><th>功能名称</th><th>测试类别</th><th>调试手册下载</th><th>功能创建时间</th></tr>");
	    	    		    		  for(var i=0;i<list.length;i++){
	    	    		    		
	    	    		    			 //list[i].savePath.replace(/\\/g, "/");
	    	    		    			  //alert(list[i].savePath.replace(/\\/g, "/"));
	    	    		    			  $("#funtable").append("<tr><td>"+list[i].id+
	    	    		    					             "</td><td>"+list[i].name+
	    	    		    					              "</td><td>"+list[i].testType.typeName+
	    	    		    					              "</a></td><td><a href='javascript:download(\""+list[i].debugFile+"\",\""+list[i].name+"\")'>"+"调试手册下载"+
	    	    		    					              "</td><td>"+list[i].istDateFormat+
	    	    		    					              "</a></td></tr>"
	    	    		    					              );	  
	    	    		    		  }
	    	    		    		  		  	 $("td").css("text-align","center");
	    	    		    		 }
	    			    			 else{
	    			    				 $("#funtable").html("<tr><th>功能ID</th><th>功能名称</th><th>测试类别</th><th>调试手册下载</th><th>功能创建时间</th><th>修改</th><th>删除</th></tr>");
		    	    		    		  for(var i=0;i<list.length;i++){
		    	    		    		
		    	    		    			 //list[i].savePath.replace(/\\/g, "/");
		    	    		    			  //alert(list[i].savePath.replace(/\\/g, "/"));
		    	    		    			  $("#funtable").append("<tr><td>"+list[i].id+
		    	    		    					             "</td><td>"+list[i].name+
		    	    		    					              "</td><td>"+list[i].testType.typeName+
		    	    		    					              "</a></td><td><a href='javascript:download(\""+list[i].debugFile+"\",\""+list[i].name+"\")'>"+"调试手册下载"+
		    	    		    					              "</td><td>"+list[i].istDateFormat+
		    	    		    					              "</a></td><td><a href='javascript:editfunction("+list[i].id+")'>"+"修改"+
		    	    		    					              "</a></td><td><a href='javascript:deletefunction("+list[i].id+")'>"+"删除"+
		    	    		    					              "</a></td></tr>"
		    	    		    					              );	  
		    	    		    		  }
		    	    		    		  		  	 $("td").css("text-align","center");
	    			    			 }
	    			    		  }
	    			    		  if(list.length==0){
	    			    			  $("#pageutil").hide();
	    					    	  $("#down_center").html("没有找到符合条件的功能");
	    					    		 }
					    		  }
	    			});		 
	    	}	
	    	function selectChecked(){
	    	 document.getElementById("msg5").innerHTML = "";
	    		var typename=$("#typetest").attr("value");
	    		  var obj = document.getElementById("testcode");
	    		  $("#testcode").empty();
	    		$.ajax({
	    		   type: "POST",
	    		   url: "${pageContext.request.contextPath}/function/typetest",
	    		   data: "typename="+typename+"",
	    		  //dateType:"json",
	    		   success: function(value){
	    			  // alert(value);
	    			   msg=value.list;
	             msg1=value.list1;
	    		   //var msg=eval("("+value+")");
	    		   //alert(msg);
	    		  for(var i=0;i<msg.length;i++){
	    		  obj.options[i]= new Option(msg[i],msg1[i]);
	    		
	    		  }
	    		  //selectCheckedTwo();
	    		  } 
	    		});
	    		}
	   function deletefunction(id){
		var infor;
	var length;
		var infor1;
	var length1;
	   var pagesize=$("#pagesize").attr("value");
		var pageno=1;
		 var r;
		var pagenumber=1;//页面信息
	$.ajax({
	type:"post",
	 async:false,
 data:{id:id},
   url: "${pageContext.request.contextPath}/function/ConfirmFunctionById",
   success:function(value){
   versionRelationList=value.versionRelationList;
   if(versionRelationList.length>0){
  infor=value.VersionNameList1;
  length=value.VersionNameList1.length;
   infor1=value.VersionNameList2;
  length1=value.VersionNameList2.length;
  }
  if(length>0&& length1>0){
  r=confirm(infor1+"这"+length1+"个版本"+"与该功能对应，"+"\n"+infor+"这"+length+"个版本"+"与该功能唯一对应"+"\n"+"若该功能删除,请及时为"+infor+"这"+length+"个版本添加对应功能，否则版本将失效");
  }
  if(length>0&& length1==0){
  r=confirm(infor+"这"+length+"个版本"+"与该功能唯一对应，"+"\n"+"若该功能删除,请及时为"+infor+"这"+length+"个版本添加对应功能，否则功能将失效");
  }
  if(length==0&& length1>0){
  r=confirm(infor1+"这"+length1+"个版本"+"与该功能对应，"+"\n"+"确认删除此功能吗");
  }
   if(versionRelationList.length==0){
  r=confirm("没有版本对应该程序，"+"\n"+"确认删除此功能吗");
  }
   }
   });
        if(r==true){
     $.ajax({
	type:"post",
   url: "${pageContext.request.contextPath}/function/deleteFunctionById",
   data:{pagesize:pagesize,pagenumber:pagenumber,id:id},
    async:false,
   success:function(value){
   pagecount=value.page.totalPageCount;
		    	      list=value.list;
		    		  listsize=value.listsize;
		    		  $("#totalcount").attr("value",value.page.totalCount);
		    		  $("#totalpagecount").attr("value",pagecount);
		    		  $("#pagetotalcount").attr("value",pagecount);
		    		  $("#pagenumber").empty();
		    		  $("#startDate").val("");
		    		  $("#endDate").val("");
		    		  $("#functionName").val("");
		    		   $("#typetest option[value='请选择']").attr("selected", true);
		    		   $("#testcode").empty();
		    		    for(var i=1;i<=pagecount;i++){
		 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
		 	    		  } 	
		 	    		  if(list.length>0){
		 		 $("#funtable").html("<tr><th>功能ID</th><th>功能名称</th><th>测试类别</th><th>调试手册下载</th><th>功能创建时间</th><th>修改</th><th>删除</th></tr>");
		    	    		    		  for(var i=0;i<list.length;i++){
		    	    		    			  $("#funtable").append("<tr><td>"+list[i].id+
		    	    		    					             "</td><td>"+list[i].name+
		    	    		    					              "</td><td>"+list[i].testType.typeName+
		    	    		    					              "</a></td><td><a href='javascript:download(\""+list[i].debugFile+"\",\""+list[i].name+"\")'>"+"调试手册下载"+
		    	    		    					              "</td><td>"+list[i].istDateFormat+
		    	    		    					              "</a></td><td><a href='javascript:editfunction("+list[i].id+")'>"+"修改"+
		    	    		    					              "</a></td><td><a href='javascript:deletefunction("+list[i].id+")'>"+"删除"+
		    	    		    					              "</a></td></tr>"
		    	    		    					              );	  
		    	    		    		  }
		    	    		    		  		  	 $("td").css("text-align","center");
		    		   }
		    		   else{
		    		     $("#funtable").empty();
		    		   $("#pageutil").hide();
	    			  $("#down_center").html("功能已全部删除");
		    		   
		    		   }
		    		   
		    		   
		    		   
		    		   }
	   });
	   }	
	    		}
	    	function seePgEdition(id){
	           $.ajax({
	type:"post",
   url: "${pageContext.request.contextPath}/function/seePgEdition",
   data:{id:id},
   success:function(value){
   pgEditionList=value.pgEditionList;
   pgNameList=value.pgNameList;
   length=pgNameList.length;
   var pgEdition="对应程序："+"   "+"版本信息"+"\n";
  if(length>0){
  for(var i=0;i<length;i++){
  pgEdition+=pgNameList[i]+":"+"          "+pgEditionList[i]+"\n";
  }
   alert( pgEdition);
   }
   else{
   alert("该版本没有对应程序");
   }
   }
   
 } );
	    	}
	    	function  FunctionExcle(){
	var form = document.forms[0]; 
	document.forms.myform1.testname.value=$("#testcode").find("option:selected").text();
	 form.action = "${pageContext.request.contextPath}/function/exportFunctionList";
	 form.method = "post";  
	 form.submit(); 
	    	}
	    	function FilePath(target){
	var path=document.getElementById("uploadFile");
	var filepath=$("#uploadFile").val();
   $("#filepath").attr("value",getPath( path));
  var isIE = /msie/i.test(navigator.userAgent) && !window.opera;  
     var fileSize = 0;         
     if (isIE && !target.files) {     
       var filePath = target.value;     
       var fileSystem = new ActiveXObject("Scripting.FileSystemObject");        
       var file = fileSystem.GetFile (filePath);     
       fileSize = file.Size;    
     } else {    
      fileSize = target.files[0].size;     
      }   
      var size = fileSize / 1024;    
      if(size>500000){  
     	alert("文件大小不能超过500");
       target.value="";
       return
      }
      else{
      }
      var name=target.value;
      var fileName = name.substring(name.lastIndexOf(".")+1).toLowerCase();
      if(fileName !="xls" && fileName !="xlsx"){
     	alert("只支持xls,xlsx格式文件");
          target.value="";
          return
      }
      else{
      }
	}
function getPath(obj) {     
  if(obj)  {
          if (window.navigator.userAgent.indexOf("MSIE")>=1)    
         {      
           obj.select();         
         return document.selection.createRange().text;          
         }   
 
          else if(window.navigator.userAgent.indexOf("Firefox")>=1)       
             {        
              if(obj.files)       
                 {         
                   return obj.files.item(0).getAsDataURL();    
                       }      
                        return obj.value;    
                           }   
                      
                          return obj.value;     
                           }      
                           }  
</script>
<style type="text/css">
table.funtable {
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
left:360px;
width:1085px;
}
div.title{
position:relative;
 left:160px;
width:1100px;
}
table.searchCondition{
position:relative;
left:150px;
width:1060px;
}
table.funtable th {
 background:#b5cfd2 url('cell-blue.jpg');
 border-width: 1px;
 padding: 8px;
 border-style: solid;
 border-color: #999999;
}
table.funtable td {
 background:#dcddc0 url('cell-grey.jpg');
 border-width: 1px;
 padding: 8px;
 border-style: solid;
 border-color: #999999;
}
a{text-decoration: none;}
#th{
color:red;}
#versionexport{
position:relative;
left:-100px;

}
</style>
</head>
<body style="overflow:-Scroll;overflow-x:hidden">
<div class="title"><h1>功能查询</h1></div>
<form name="myform1">
<input   type="hidden" name="savePath1" value="">
<input   type="hidden" name="funname" value="">
<input type="hidden" name="listsize"  id="listsize" value="${page.totalCount}" id="listsize">
<input type="hidden" name="pagenumber1" value="${page.pageNow}" id="pagenumber1">
<input type="hidden" name="pagetotalcount"  id="pagetotalcount" value="">
<input type="hidden" name="usertype" id="usertype" value="${userType}">
<input type="hidden" name="filepath"  id="filepath" value="">
<input type="hidden" name="testname"  id="testname" value="">


<table class="searchCondition">
<tr>
<td>开始时间
	<input type="text" id="startDate"  onclick="J.calendar.get({dir:'right'});" name="startDate"  
	onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg1').innerHTML=''"/>
  <div style="display: inline" id="msg1"></div></td>
<td>截至时间
 <input type="text" id="endDate" onclick="J.calendar.get();" name="endDate"
 onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg2').innerHTML=''"/>
<div style="display: inline" id="msg2"></div></td>
<td>功能名称<input name="functionName" id="functionName" type="text" style="width:110px;"
onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg3').innerHTML=''"/>
<div style="display: inline" id="msg3"></div></td>
<td>
<label>功能类别</label>
<select name="typetest" id="typetest"  onchange="selectChecked();" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg3').innerHTML=''"/>
<option selected="selected" value="请选择">请选择</option>
<c:forEach var="testType" items="${testTypeAllList}" varStatus="vs">
             <option value="${testType.typeName}">${testType.typeName}</option>
       </c:forEach>
</select>
<div style="display: inline" id="msg5"></div>
</td>
<td>
<label>功能类型</label>
<select name="testcode" id="testcode"  onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg4').innerHTML=''" />
<option value="请选择" selected="selected">请选择</option>
  <!--<c:forEach var="testCode" items="${testCodeList}" varStatus="vs">
             <option value="${testCode.testName}">${testCode.testName}</option>
       </c:forEach>-->
</select>
<div style="display: inline" id="msg4"></div>
</td>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<td><input type="button" value="查询"  class="button" onclick="querySomeVersion1()"></td>
</tr>
</table>
</br>
<div id="pageutil" class="pageutil">
<a  id="versionexport"  class="versionexport" href="javascript:FunctionExcle()" >功能表信息导出</a>
共有<input class="blue" id="totalcount" type="button" value="${page.totalCount}" >条记录
    <td style="margin-left: 0px;">每页显示<select id="pagesize"  onchange="getFunByCriteria()">
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
</form>
<form name="myform">
<input   type="hidden" name="id" value=""> 
<input   type="hidden" name="userid"  id="userid" value="${userid}"> 
<table boder="1" cellpadding="10" id="funtable" class="funtable">
<tr>
<th>功能ID</th>
<th>功能名称</th>
<th>测试类别</th>
<th>调试手册下载</th>
<th>点击查看对应程序版本信息</th>
<th>功能创建时间</th>
<th id="edit">修改</th>
<th id="delete">删除</th>
</tr>
<c:forEach items="${requestScope.AllFunList}" var="fun" varStatus="vs">
<tr>
<td style="text-align:  center;">${fun.id}</td>
<td style="text-align:  center;">${fun.name}</td>
<td style="text-align:  center;">${fun.testType.typeName}</td>
<td style="text-align:  center;"><a href="javascript:download('${fun.debugFile}','${fun.name}')">调试手册下载</a></td>
<td style="text-align:  center;"><a href="javascript:seePgEdition('${fun.id}')">程序版本信息</a></td>
<td style="text-align:  center;">${fun.istDateFormat}</td>
<td name="edit" style="text-align:  center;"><a href="javascript:editfunction('${fun.id}')">修改</a></td>
<td name="delete" style="text-align:  center;"><a href="javascript:deletefunction('${fun.id}')">删除</a></td>
</tr>
</c:forEach>
</table>
</form>
<div id="down_center"></div>	
</body>
</html>