<%@ page language="java"  import="java.util.*"  contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
    <%String path =request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//System.out.println(basePath);
%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>   

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript"  src="<%=basePath%>js/showdate.js"></script>
	<script type="text/javascript" src="<%=basePath%>lhgcalendar/lhgcore.js"></script>
	<script type="text/javascript" src="<%=basePath%>lhgcalendar/lhgcalendar.js"></script>
	<script type="text/javascript" src="<%=basePath%>jquery/jquery-1.8.0.min.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-base.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-all.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-lang-zh_CN.js"></script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>版本查询</title>
<script type="text/javascript">
function editVersion(id){
	 var form = document.forms[0];  
	 form.action = "${pageContext.request.contextPath}/installVersion/updateVersion"; 
	 document.forms.myform.id.value = id;
	 form.method = "post";  
   form.submit();  
}
function deleteVersion(id){
	var pagesize=$("#pagesize").attr("value");
		var pageno=1;
		$("#pageno").attr("value",1);
		var pagenumber=1;//页面信息
  var r=confirm("确定删除吗？");
if(r==true)
{$.ajax({
	type:"post",
   url: "${pageContext.request.contextPath}/installVersion/deleteVersionById",
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
		    		   $("#typetest option[value='请选择']").attr("selected", true);
		    		   $("#testcode").empty();
		    	 for(var i=1;i<=pagecount;i++){
		 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
		 	    		  } 	
		 	if( list.length>0){
		    			$("#versiontable").html("<tr><th>版本号</th><th>版本名称</th><th>操作说明下载</th><th>程序下载</th><th>版本发布时间</th><th>修改</th><th>删除</th></tr>");
				    		  for(var i=0;i<list.length;i++){
				    			  
				    			  $("#versiontable").append("<tr><td>"+list[i].verCode+
				    					             "</td><td>"+list[i].verName+
				    					             "</td><td><a href='javascript:download(\""+list[i].operName+"\",\""+list[i].verCode+"\")'>"+"操作说明下载"+
				    					              "</a></td><td><a href='javascript:downloadProgram(\""+list[i].savePath+"\",\""+list[i].verCode+"\")'>"+"对应程序下载"+
				    					              "</td><td>"+list[i].istDateFormat+
				    					              "</a></td><td><a href='javascript:editVersion("+list[i].id+")'>"+"修改"+
				    					              "</a></td><td><a href='javascript:deleteVersion("+list[i].id+")'>"+"删除"+
				    					              "</a></td></tr>"
				    					              );
				    		  
				    			  }
				    			  	 $("td").css("text-align","center");
		    			
 }
 else{
  $("#versiontable").empty();
 $("#down_center").html("版本已全部删除");
   $("#pageutil").hide();
 }
 
   }
   
   });

}
}
function download(savepath,verCode){ 
	 var form = document.forms[0]; 
	 form.action = "${pageContext.request.contextPath}/installVersion/downloadtext";
	 document.forms.myform.savePath1.value = savepath;
	 document.forms.myform.verCode.value=verCode;
	form.method = "post";  
	form.submit();  
}
function downloadProgram(storagePath,verCode){
	 var form = document.forms[0]; 
	 form.action = "${pageContext.request.contextPath}/installVersion/downloadProgram";
	 document.forms.myform.storagePath1.value = storagePath;
	 document.forms.myform.verCode.value=verCode;
	 form.method = "post";  
	 form.submit(); 
	
}
window.onload=function(){ 
	var array = new Array();  
	    <c:if test="${empty requestScope.installAllList}">
	   // document.getElementById("down_center").innerHTML = "没有找到符合条件的版本";
	   // $("#versiontable").empty();
	   //$("#pageutil").hide();
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
	
var opts1=document.getElementById('typetest').options;
var obj1=new Object(),index=0;
while(index<opts1.length){
	if(opts1[index].text in obj1) opts1[index]=null;
	else{
		obj1[opts1[index].text]=opts1[index].text;
		index++;
	}
}
obj1=null;
var userType=$("#usertype").val();
if(userType=="普通用户"){
	$("#edit").hide();
	$("#delete").hide();
	$("td[name='edit']").hide();
	$("td[name='delete']").hide();
}
$("#pageno").attr("value",1);
var pagesize=$("#pagesize").attr("value");
var listcount=$("#totalcount").val();
var pagenumber=$("#pagenumber1").val();
var startDate = document.getElementsByName("startDate")[0].value;
var endDate = document.getElementsByName("endDate")[0].value;
var typeName= document.getElementsByName("typetest")[0].value;
//var testCode= document.getElementsByName("testcode")[0].value;
 var testCode=$("#testcode").find("option:selected").text();
$.ajax({
	type:"post",
   url: "${pageContext.request.contextPath}/installVersion/querySomeListByCriteria",
   data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,typetest:typeName,testcode:testCode},
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
function selectChecked(){
  	 document.getElementById("msg3").innerHTML = "";
	var typename=$("#typetest").attr("value");
	$("#testcode").empty();
	$.ajax({
	   type: "POST",
	   url: "${pageContext.request.contextPath}/function/typetest",
	   data: "typename="+typename+"",
	  dateType:"json",
	   success: function(value){
		   msg=value.list;
           msg1=value.list1;
	  // var msg=eval("("+value+")");
	  var obj = document.getElementById("testcode");
	  for(var i=0;i<msg.length;i++){
	  obj.options[i]= new Option(msg[i],msg1[i]);
	
	  }
	  } 
	});
	}
function getVersionByCriteria(){
	var userType=$("#usertype").val();
	$("#pageno").attr("value",1);
	var pagesize=$("#pagesize").attr("value");
	var listcount=$("#totalcount").val();
	var listsize=$("#listsize").val();
	var pagenumber=$("#pagenumber1").val();
	var startDate = document.getElementsByName("startDate")[0].value;
	var endDate = document.getElementsByName("endDate")[0].value;
	var typeName= document.getElementsByName("typetest")[0].value;
	//var testCode= document.getElementsByName("testcode")[0].value;
	 var testCode=$("#testcode").find("option:selected").text();
		$.ajax({
			type:"post",
		    url: "${pageContext.request.contextPath}/installVersion/querySomeListByCriteria",
		    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,typetest:typeName,testcode:testCode},
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
		    		  if(list.length>0){
		    			  if(userType=="普通用户"){
		    				  $("#versiontable").html("<tr><th>版本号</th><th>版本名称</th><th>操作说明下载</th><th>程序下载</th><th>版本发布时间</th></tr>");
				    		  for(var i=0;i<list.length;i++){
				    			  $("#versiontable").append("<tr><td>"+list[i].verCode+
				    					             "</td><td>"+list[i].verName+
				    					              "</td><td><a href='javascript:download(\""+list[i].operName+"\",\""+list[i].verCode+"\")'>"+"操作说明下载"+
				    					              "</a></td><td><a href='javascript:downloadProgram(\""+list[i].savePath+"\",\""+list[i].verCode+"\")'>"+"对应程序下载"+
				    					              "</td><td>"+list[i].istDateFormat+
				    					              "</a></td></tr>"
				    					              );		  
				    		  }
				    		  	 $("td").css("text-align","center");
		    				  
		    			  }
		    			  else{
		    		  $("#versiontable").html("<tr><th>版本号</th><th>版本名称</th><th>操作说明下载</th><th>程序下载</th><th>版本发布时间</th><th>修改</th><th>删除</th></tr>");
		    		  for(var i=0;i<list.length;i++){
		    			  $("#versiontable").append("<tr><td>"+list[i].verCode+
		    					             "</td><td>"+list[i].verName+
		    					             "</td><td><a href='javascript:download(\""+list[i].operName+"\",\""+list[i].verCode+"\")'>"+"操作说明下载"+
		    					              "</a></td><td><a href='javascript:downloadProgram(\""+list[i].savePath+"\",\""+list[i].verCode+"\")'>"+"对应程序下载"+
		    					              "</td><td>"+list[i].istDateFormat+
		    					              "</a></td><td><a href='javascript:editVersion("+list[i].id+")'>"+"修改"+
		    					              "</a></td><td><a href='javascript:deleteVersion("+list[i].id+")'>"+"删除"+
		    					              "</a></td></tr>"
		    					              );		  
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
		var startDate = document.getElementsByName("startDate")[0].value;
		 var endDate = document.getElementsByName("endDate")[0].value;
		 var typeName= document.getElementsByName("typetest")[0].value;
		// var testCode= document.getElementsByName("testcode")[0].value;
		 var testCode=$("#testcode").find("option:selected").text();
		$.ajax({
			type:"post",
			 url: "${pageContext.request.contextPath}/installVersion/querySomeListByCriteria",
			    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,typetest:typeName,testcode:testCode},
		    success:function(value){
		    		  pagecount=value.pageCount;
		    		  list=value.versionlist;
		    		  page=value.page;
		    		  listsize=value.listsize;
		    		  $("#totalpagecount").attr("value",pagecount);
		    		  if(list.length>0){
		    			  if(userType=="普通用户"){
		    		  $("#versiontable").html("<tr><th>版本号</th><th>版本名称</th><th>操作说明下载</th><th>程序下载</th><th>版本发布时间</th></tr>");
		    		  for(var i=0;i<list.length;i++){
		    			  $("#versiontable").append("<tr><td>"+list[i].verCode+
		    					             "</td><td>"+list[i].verName+
		    					             "</td><td><a href='javascript:download(\""+list[i].operName+"\",\""+list[i].verCode+"\")'>"+"操作说明下载"+
		    					              "</a></td><td><a href='javascript:downloadProgram(\""+list[i].savePath+"\",\""+list[i].verCode+"\")'>"+"对应程序下载"+
		    					              "</td><td>"+list[i].istDateFormat+
		    					              "</a></td></tr>"
		    					              );
		    		  }
		    		  	 $("td").css("text-align","center");
		    			  }
		    		  else{
		    			  $("#versiontable").html("<tr><th>版本号</th><th>版本名称</th><th>操作说明下载</th><th>程序下载</th><th>版本发布时间</th><th>修改</th><th>删除</th></tr>");
		    		  for(var i=0;i<list.length;i++){
		    			  $("#versiontable").append("<tr><td>"+list[i].verCode+
		    					             "</td><td>"+list[i].verName+
		    					             "</td><td><a href='javascript:download(\""+list[i].operName+"\",\""+list[i].verCode+"\")'>"+"操作说明下载"+
		    					              "</a></td><td><a href='javascript:downloadProgram(\""+list[i].savePath+"\",\""+list[i].verCode+"\")'>"+"对应程序下载"+
		    					              "</td><td>"+list[i].istDateFormat+
		    					              "</a></td><td><a href='javascript:editVersion("+list[i].id+")'>"+"修改"+
		    					                "</a></td><td><a href='javascript:deleteVersion("+list[i].id+")'>"+"删除"+
		    					              "</a></td></tr>"
		    					              );
		    		  }
		    		  	 $("td").css("text-align","center");
		    		  }
		    		  if(list.length==0){
				    		 $("#down_center").html("没有找到符合条件的版本");
				    		 }
		    		  }     
		    }
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
			 var typeName= document.getElementsByName("typetest")[0].value;
			 //var testCode= document.getElementsByName("testcode")[0].value;
			  var testCode=$("#testcode").find("option:selected").text();
			$.ajax({
				type:"post",
				 url: "${pageContext.request.contextPath}/installVersion/querySomeListByCriteria",
				    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,typetest:typeName,testcode:testCode},
			    success:function(value){
			    		  pagecount=value.pageCount;
			    		  list=value.versionlist;
			    		  page=value.page;
			    		  listsize=value.listsize;
			    		  $("#totalpagecount").attr("value",pagecount);
			    		  if(list.length>0){
			    			  if(userType=="普通用户"){
			    		  $("#versiontable").html("<tr><th>版本号</th><th>版本名称</th><th>操作说明下载</th><th>程序下载</th><th>版本发布时间</th></tr>");
			    		  for(var i=0;i<list.length;i++){
			    			  $("#versiontable").append("<tr><td>"+list[i].verCode+
			    					             "</td><td>"+list[i].verName+
			    					             "</td><td><a href='javascript:download(\""+list[i].operName+"\",\""+list[i].verCode+"\")'>"+"操作说明下载"+
			    					              "</a></td><td><a href='javascript:downloadProgram(\""+list[i].savePath+"\",\""+list[i].verCode+"\")'>"+"对应程序下载"+
			    					              "</td><td>"+list[i].istDateFormat+
			    					              "</a></td></tr>"
			    					              );
			    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));		  
			    		  }
			    		  	 $("td").css("text-align","center");
			    			  }
			    			  else{
			    				  $("#versiontable").html("<tr><th>版本号</th><th>版本名称</th><th>操作说明下载</th><th>程序下载</th><th>版本发布时间</th><th>修改</th><th>删除</th></tr>");
					    		  for(var i=0;i<list.length;i++){
					    			  $("#versiontable").append("<tr><td>"+list[i].verCode+
					    					             "</td><td>"+list[i].verName+
					    					             "</td><td><a href='javascript:download(\""+list[i].operName+"\",\""+list[i].verCode+"\")'>"+"操作说明下载"+
					    					              "</a></td><td><a href='javascript:downloadProgram(\""+list[i].savePath+"\",\""+list[i].verCode+"\")'>"+"对应程序下载"+
					    					              "</td><td>"+list[i].istDateFormat+
					    					              "</a></td><td><a href='javascript:editVersion("+list[i].id+")'>"+"修改"+
					    					                "</a></td><td><a href='javascript:deleteVersion("+list[i].id+")'>"+"删除"+
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
	//alert(pagenuber);
	//alert(listcount);
	//alert(document.getElementsByName("listsize")[0].value);
	//判断是否有条件搜索
		var startDate = document.getElementsByName("startDate")[0].value;
		 var endDate = document.getElementsByName("endDate")[0].value;
		 var typeName= document.getElementsByName("typetest")[0].value;
		 //var testCode= document.getElementsByName("testcode")[0].value;
	 var testCode=$("#testcode").find("option:selected").text();
		$.ajax({
			type:"post",
			 url: "${pageContext.request.contextPath}/installVersion/querySomeListByCriteria",
			    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,typetest:typeName,testcode:testCode},
		    success:function(value){
		    		  pagecount=value.pageCount;
		    		  list=value.versionlist;
		    		  page=value.page;
		    		  listsize=value.listsize;
		    		  $("#totalpagecount").attr("value",pagecount);
		    		  if(list.length>0){
		    			  if(userType=="普通用户"){
		    		  $("#versiontable").html("<tr><th>版本号</th><th>版本名称</th><th>操作说明下载</th><th>程序下载</th><th>版本发布时间</th></tr>");
		    		  for(var i=0;i<list.length;i++){
		    			  $("#versiontable").append("<tr><td>"+list[i].verCode+
		    					             "</td><td>"+list[i].verName+
		    					             "</td><td><a href='javascript:download(\""+list[i].operName+"\",\""+list[i].verCode+"\")'>"+"操作说明下载"+
		    					              "</a></td><td><a href='javascript:downloadProgram(\""+list[i].savePath+"\",\""+list[i].verCode+"\")'>"+"对应程序下载"+
		    					              "</td><td>"+list[i].istDateFormat+
		    					              "</a></td></tr>"
		    					              );
		    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
		    					  
		    		  }
		    		  	 $("td").css("text-align","center");
		    			  }
		    			  else{
				    		  $("#versiontable").html("<tr><th>版本号</th><th>版本名称</th><th>操作说明下载</th><th>程序下载</th><th>版本发布时间</th><th>修改</th><th>删除</th></tr>");
				    		  for(var i=0;i<list.length;i++){
				    			  $("#versiontable").append("<tr><td>"+list[i].verCode+
				    					             "</td><td>"+list[i].verName+
				    					             "</td><td><a href='javascript:download(\""+list[i].operName+"\",\""+list[i].verCode+"\")'>"+"操作说明下载"+
				    					              "</a></td><td><a href='javascript:downloadProgram(\""+list[i].savePath+"\",\""+list[i].verCode+"\")'>"+"对应程序下载"+
				    					              "</td><td>"+list[i].istDateFormat+
				    					              "</a></td><td><a href='javascript:editVersion("+list[i].id+")'>"+"修改"+
				    					                "</a></td><td><a href='javascript:deleteVersion("+list[i].id+")'>"+"删除"+
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
		 var typeName= document.getElementsByName("typetest")[0].value;
		// var testCode= document.getElementsByName("testcode")[0].value;
		 var testCode=$("#testcode").find("option:selected").text();
		$.ajax({
			type:"post",
			 url: "${pageContext.request.contextPath}/installVersion/querySomeListByCriteria",
			    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,typetest:typeName,testcode:testCode},
		    success:function(value){
		    		  pagecount=value.pageCount;
		    		  list=value.versionlist;
		    		  page=value.page;
		    		  listsize=value.listsize;
		    		  $("#totalpagecount").attr("value",pagecount);
		    		  if(list.length>0){
		    			if(userType=="普通用户"){
		    		  $("#versiontable").html("<tr><th>版本号</th><th>版本名称</th><th>操作说明下载</th><th>版本发布时间</th><th>程序下载</th></tr>");
		    		  for(var i=0;i<list.length;i++){
		    			  
		    			  $("#versiontable").append("<tr><td>"+list[i].verCode+
		    					             "</td><td>"+list[i].verName+
		    					             "</td><td><a href='javascript:download(\""+list[i].operName+"\",\""+list[i].verCode+"\")'>"+"操作说明下载"+
		    					              "</a></td><td><a href='javascript:downloadProgram(\""+list[i].savePath+"\",\""+list[i].verCode+"\")'>"+"对应程序下载"+
		    					              "</td><td>"+list[i].istDateFormat+
		    					              "</a></td></tr>"
		    					              );
		    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
		    		  
		    			  }
		    			  	 $("td").css("text-align","center");
		    			}
		    			else{
		    				$("#versiontable").html("<tr><th>版本号</th><th>版本名称</th><th>操作说明下载</th><th>程序下载</th><th>版本发布时间</th><th>修改</th><th>删除</th></tr>");
				    		  for(var i=0;i<list.length;i++){
				    			  
				    			  $("#versiontable").append("<tr><td>"+list[i].verCode+
				    					             "</td><td>"+list[i].verName+
				    					             "</td><td><a href='javascript:download(\""+list[i].operName+"\",\""+list[i].verCode+"\")'>"+"操作说明下载"+
				    					              "</a></td><td><a href='javascript:downloadProgram(\""+list[i].savePath+"\",\""+list[i].verCode+"\")'>"+"对应程序下载"+
				    					              "</td><td>"+list[i].istDateFormat+
				    					              "</a></td><td><a href='javascript:editVersion("+list[i].id+")'>"+"修改"+
				    					                "</a></td><td><a href='javascript:deleteVersion("+list[i].id+")'>"+"删除"+
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
function checkDate(d){
	   var ds=d.match(/\d+/g),ts=['getFullYear','getMonth','getDate'];
	     var d=new Date(d.replace(/-/g,'/')),i=3;
	     ds[1]--;
	     while(i--)if( ds[i]*1!=d[ts[i]]()) return false;
	     return true;
	    }
	   
	function querySomeVersion1(){
		//$("#pagesize option[text=2]").attr("selected",true); 
		var totalpagecount=$("#pagetotalcount").val();
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
		 var typeName= document.getElementsByName("typetest")[0].value;
		 if(typeName=="请选择"){
		 typeName="";
		 }
		// var testcode= document.getElementsByName("testcode")[0].value;
		 var testcode=$("#testcode").find("option:selected").text();
		/*var op=document.getElementById("testcode");
		 var testcode=op.options[op.selectedIndex].text;*/
		 var begintime = document.getElementById("c2").value;
		 var endtime = document.getElementById("c1").value;
		/* if(startDate.trim().length==0&&endDate.trim().length==0&&typeName=="请选择"){
			 document.getElementById("msg1").innerHTML = "<font color='red'>搜索条件不能都为空</font>";
			 return;
		 }
		 if(startDate.trim().length!=0|endDate.trim().length!=0|typeName!="请选择"){
			 document.getElementById("msg1").innerHTML = "";
		 }*/
		 if(startDate.trim().length!=0){
			 if(checkDate(begintime)==false){
				 document.getElementById("msg1").innerHTML = "<font color='red'> 请输入正确的时间格式</font>";
			 }
			 if(checkDate(begintime)==true){
				 document.getElementById("msg1").innerHTML = "";
			 }
			 
		 }
		 if(endDate.trim().length!=0){
			 if(checkDate(endtime)==false){
				 document.getElementById("msg2").innerHTML = "<font color='red'>请输入正确的时间格式</font>";
			 }
			 if(checkDate(endtime)==true){
				 document.getElementById("msg2").innerHTML = "";
			 }
		 }
		 if(endDate.trim().length!=0&&startDate.trim().length!=0){
			 if(startDate>endDate){
				 document.getElementById("msg2").innerHTML = "<font color='red'>开始时间不能早于结束时间</font>";
			 }
			 else{
				 document.getElementById("msg2").innerHTML = "";
			 }
		 }
		 else{
			 document.getElementById("msg2").innerHTML = "";
		 }
	       var typeName1=$("#typetest option:selected").text(); 
		 	 if(typeName1!="请选择"&&testcode==""){
		  document.getElementById("msg3").innerHTML = "<font color='red'>该测试类别没有测试类型</font>";
		 }
		 if(typeName1!="请选择"&&testcode!=""){
		 document.getElementById("msg3").innerHTML = "";
		 }
			 $.ajax({
				  type: "POST",
				   url: "${pageContext.request.contextPath}/installVersion/querySomeVersionByQuery",
				   data: {pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,typetest:typeName,testcode:testcode},
				   success:function(value){
					   //$("#versiontable").empty();
			    		  list=value.list;
			    		  page=value.page; 
			    		  listsize=value.listsize;
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
				    	
				    		  if(list.length==0){
				    			  $("#versiontable").empty();
				    			  $("#pageutil").hide();
				    			 $("#down_center").html("没有找到符合条件的版本");
				    		  }  
				    		  if(list.length>0){
				    			  $("#versiontable").empty();
				    			  $("#pageutil").show();
				    			  $("#down_center").empty();
				    			  if(userType=="普通用户"){
			    		  $("#versiontable").html("<tr><th>版本号</th><th>版本名称</th><th>操作说明下载</th><th>程序下载</th><th>版本发布时间</th></tr>");
			    		  for(var i=0;i<list.length;i++){
			    			  $("#versiontable").append("<tr><td>"+list[i].verCode+
			    					             "</td><td>"+list[i].verName+
			    					             "</td><td><a href='javascript:download(\""+list[i].operName+"\",\""+list[i].verCode+"\")'>"+"操作说明下载"+
			    					              "</a></td><td><a href='javascript:downloadProgram(\""+list[i].savePath+"\",\""+list[i].verCode+"\")'>"+"对应程序下载"+
			    					              "</td><td>"+list[i].istDateFormat+
			    					              //"</a></td><td><a href='javascript:editVersion("+list[i].id+")'>"+"修改"+
			    					              "</a></td></tr>"
			    					              );
			    			  $("#versiontable").css({boder:1, cellpadding:10});
			    			  	 $("td").css("text-align","center");
			    					  
			    		  }	  }
				    			  else{
				    				  $("#versiontable").html("<tr><th>版本号</th><th>版本名称</th><th>操作说明下载</th><th>程序下载</th><th>版本发布时间</th><th>修改</th><th>删除</th></tr>");
						    		  for(var i=0;i<list.length;i++){
						    			  $("#versiontable").append("<tr><td>"+list[i].verCode+
						    					             "</td><td>"+list[i].verName+
						    					             "</td><td><a href='javascript:download(\""+list[i].operName+"\",\""+list[i].verCode+"\")'>"+"操作说明下载"+
						    					              "</a></td><td><a href='javascript:downloadProgram(\""+list[i].savePath+"\",\""+list[i].verCode+"\")'>"+"对应程序下载"+
						    					              "</td><td>"+list[i].istDateFormat+
						    					              "</a></td><td><a href='javascript:editVersion("+list[i].id+")'>"+"修改"+
						    					              "</a></td><td><a href='javascript:deleteVersion("+list[i].id+")'>"+"删除"+
						    					              "</a></td></tr>"
						    					              );
						    			 // $("#versiontable").css({boder:1, cellpadding:10});
						    			 $("td").css("text-align","center");
						    					  
						    		  }	
				    			  }
				    		  }
				    		 
			  }
		 
		 })
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
			 var typeName= document.getElementsByName("typetest")[0].value;
			 //var testCode= document.getElementsByName("testcode")[0].value;
			  var testCode=$("#testcode").find("option:selected").text();
			$.ajax({
				type:"post",
				 url: "${pageContext.request.contextPath}/installVersion/querySomeListByCriteria",
				    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,typetest:typeName,testcode:testCode},
			    success:function(value){
			    		  pagecount=value.pageCount;
			    		  list=value.versionlist;
			    		  page=value.page;
			    		  listsize=value.listsize;
			    		  $("#totalpagecount").attr("value",pagecount);
			    		  if(userType=="普通用户"){
			    		  $("#versiontable").html("<tr><th>版本号</th><th>版本名称</th><th>操作说明下载</th><th>程序下载</th><th>版本发布时间</th></tr>");
			    		  for(var i=0;i<list.length;i++){
			    			  $("#versiontable").append("<tr><td>"+list[i].verCode+
			    					             "</td><td>"+list[i].verName+
			    					             "</td><td><a href='javascript:download(\""+list[i].operName+"\",\""+list[i].verCode+"\")'>"+"操作说明下载"+
			    					              "</a></td><td><a href='javascript:downloadProgram(\""+list[i].savePath+"\",\""+list[i].verCode+"\")'>"+"对应程序下载"+
			    					              "</td><td>"+list[i].istDateFormat+
			    					              "</a></td></tr>"
			    					              );
			    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
			    					  
			    		  }	   
			    		  	 $("td").css("text-align","center");
			    		  }
			    		  else{
			    			  $("#versiontable").html("<tr><th>版本号</th><th>版本名称</th><th>操作说明下载</th><th>程序下载</th><th>版本发布时间</th><th>修改</th><th>删除</th></tr>");
				    		  for(var i=0;i<list.length;i++){
				    			  $("#versiontable").append("<tr><td>"+list[i].verCode+
				    					             "</td><td>"+list[i].verName+
				    					             "</td><td><a href='javascript:download(\""+list[i].operName+"\",\""+list[i].verCode+"\")'>"+"操作说明下载"+
				    					              "</a></td><td><a href='javascript:downloadProgram(\""+list[i].savePath+"\",\""+list[i].verCode+"\")'>"+"对应程序下载"+
				    					              "</td><td>"+list[i].istDateFormat+
				    					              "</a></td><td><a href='javascript:editVersion("+list[i].id+")'>"+"修改"+
				    					               "</a></td><td><a href='javascript:deleteVersion("+list[i].id+")'>"+"删除"+
				    					              "</a></td></tr>"
				    					              );
				    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
				    					  
				    		  }	   
				    		  	 $("td").css("text-align","center");
			    		  }
			    }
			});
	}
	function seeRemark(verName,remark){
	alert("版本名称为"+verName+"的版本描述是:"+""+remark);
	}
	function VersionExcle(){
   /*$.ajax({
				type:"post",
				 url: "${pageContext.request.contextPath}/installVersion/exportVersionList",
			    success:function(value){
			    alert("hh");
			    alert(value);
			    }
			    });
			    }*/
	var form = document.forms[0]; 
	document.forms.myform.testname.value=$("#testcode").find("option:selected").text();
	 form.action = "${pageContext.request.contextPath}/installVersion/exportVersionList";
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
     	//document.getElementById("msg8").innerHTML = "<font color='red'> 文件大小不能超过500</font>";
     	alert("文件大小不能超过500");
       target.value="";
       return
      }
      else{
     // document.getElementById("msg8").innerHTML ="";
      }
      var name=target.value;
      var fileName = name.substring(name.lastIndexOf(".")+1).toLowerCase();
      if(fileName !="xls" && fileName !="xlsx"){
     	//document.getElementById("msg8").innerHTML = "<font color='red'> 只支持xls,xlsx格式文件上传</font>";
     	alert("只支持xls,xlsx格式文件");
          target.value="";
          return
      }
      else{
     // document.getElementById("msg8").innerHTML ="";
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
                    //修改后代码:  webObj.HttpAddPostFile("attachment", getPath(document.getElementById("attachment")));
	</script>
<style type="text/css">
table.versiontable {
position:absolute;
 font-family: verdana,arial,sans-serif;
 font-size:11px;
 color:#333333;
 border-width: 1px;
 border-color: #999999;
 border-collapse: collapse;
 left:160px;
width:1070px;
}
div.pageutil{
position:relative;
left:360px;
width:1100px;
}
#versionexport{
position:relative;
left:-150px;
}
div.VersionExcle{
position:relative;
left:160px;
}
div.title{
position:relative;
 left:160px;
width:1100px;
}
table.searchCondition{
position:relative;
left:150px;
width:1070px;
}
table.versiontable th {
 background:#b5cfd2 url('cell-blue.jpg');
 border-width: 1px;
 padding: 8px;
 border-style: solid;
 border-color: #999999;
}
table.versiontable td {
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
top:50px;
}
#versionExport{
position:relative;
 left:160px;
width:1100px;
}

</style>
</head>
<body  style="overflow:-Scroll;overflow-x:hidden;" >
<div id="title" class="title">
<h1 >版本查询1</h1> 
</div>
<form name="myform" enctype="multipart/form-data">
<input   type="hidden" name="id" value="">
<input   type="hidden" name="testname" value="">  
<input type="hidden"  name="storagePath1" value=""> 
<input   type="hidden" name="savePath1" value="" >
<input type="hidden" name="verCode" value="">
<input   type="hidden" name="testtype" value="">
<input type="hidden" name="listsize"  id="listsize" value="${page.totalCount}" id="listsize">
<input type="hidden" name="pagenumber1" value="${page.pageNow}" id="pagenumber1">
<!-- 记录每次动态查询的总页数 -->
<input type="hidden" name="pagetotalcount"  id="pagetotalcount" value="">
<input type="hidden" name="usertype" id="usertype" value="${userType}">
<input type="hidden" name="userid" id="userid" value="${userid}">
<input type="hidden" name="filepath" id="filepath" value="">


<table class="searchCondition">
<tr>
<td >开始时间
	<input type="text" id="c2" onclick="J.calendar.get({dir:'right'});" name="startDate" 
	onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg1').innerHTML=''"/>
	<div style="display: inline" id="msg1"></div>
</td>
<td>截止时间
 <input type="text" id="c1" onclick="J.calendar.get();" name="endDate" 
 onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg1').innerHTML=''"/>
 	<div style="display: inline" id="msg2"></div>
</td>
<td>
<label>测试类别</label>
<select name="typetest" id="typetest"  onchange="selectChecked();" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg3').innerHTML=''"/>
<option value="请选择" selected="selected">请选择</option>
<c:forEach var="testType" items="${testTypeAllList}" varStatus="vs">
             <option value="${testType.typeName}">${testType.typeName}</option>
       </c:forEach>
</select>
<div style="display: inline" id="msg3"></div>
</td>
<td>
<label>测试类型</label>
<select name="testcode" id="testcode"  onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg4').innerHTML=''" />
<option value="" selected="selected">请选择</option>
  <c:forEach var="testCode" items="${testCodeList}" varStatus="vs">
             <option value="${testCode.testName}">${testCode.testName}</option>
       </c:forEach>
</select>
<div style="display: inline" id="msg4"></div>
</td>
<td>
<input type="button" value="查询"  class="button"  onclick="querySomeVersion1()">
</td>
</tr>
</table>

<!-- 最下面显示跳转页面 -->
<!-- ${page.totalCount }总的记录条数  其他的类似，与Page.java相关联 -->
<div id="VersionExcle" class="VersionExcle">
<!-- <input type="file"  id="uploadFile" name="uploadFile" onchange="FilePath(this)"/>-->
</div>
</br>
<div id="pageutil" class="pageutil">
<a  id="versionexport"  class="versionexport" href="javascript:VersionExcle()" >版本表信息导出</a>
共有<input class="blue" id="totalcount" type="button" value="${page.totalCount}">条记录
    每页显示<select id="pagesize"  onchange="getVersionByCriteria()">
   <option selected="selected">10</option>
    <option>20</option>
    <option>50</option>
    <option>100</option>
    </select>条
     共有 <input class="blue" id="totalpagecount" type="button">页 
    当前显示第 <input class="blue" id="pageno" type="button" value=1>
     页 
        跳转  
    <select id="pagenumber" onchange="toSelectedPage()">
    
    
    </select>
      页
     <!-- 首页按钮，跳转到首页 -->
    <td>
    <c:if test="${page.pageNow <= 1 }"></c:if>
   <!--<a href="javascript:;" <c:if test="${page.pageNow > 1 }">onclick="page1(1)"</c:if> >首页</a> -->
    <a href="javascript:firstpage()">首页</a>
    <!-- 上页按钮，跳转到上一页 -->
    <c:if test="${page.pageNow <= 1 }"></c:if>
    <!--  <a href="javascript:;" <c:if test="${page.pageNow  > 1 }">onclick="page1('${page.pageNow - 1}')"</c:if> >上页</a>-->
      <a href="javascript:forwardpage()">上一页</a>
    <!-- 下页按钮，跳转到下一页 -->
    <!--   <c:if test="${page.pageNow >= page.pageNow }"></c:if>
    <a href="javascript:;" <c:if test="${page.pageNow < page.pageNow }">onclick="page1('${page.pageNow + 1}')"</c:if> >下页</a>-->
    <!--  <a href="javascript:page1('${page.pageNow+1}')">下一页</a> -->
    <a href="javascript:nextpage()">下一页</a>
     
    <!-- 末页按钮，跳转到最后一页 -->
     <c:if test="${page.pageNow >= page.totalPageCount }"></c:if>
    <!-- <a href="javascript:;" <c:if test="${page.pageNow < page.totalPageCount }">onclick="page1('${page.totalPageCount}')"</c:if> >末页</a>-->
     <a href="javascript:lastpage()">末页</a>
 </td>
    </div>
<table id="versiontable"  name="versiontable" class="versiontable">
<div id="versionlist" style="color: blue;">
 <th>版本号</th>
<th>版本名称</th>
<!--  <th>操作说明下载</th>-->
<th>点击查看版本描述</th>
<th>程序下载</th>
<th>版本发布时间</th>
<th id="edit">修改</th>
<th id="delete">删除</th>
</tr>
<c:forEach items="${installAllList}" var="version" varStatus="vs">
<tr>
<td style="text-align: center;">${version.verCode}</td>
<td style="text-align: center;">${version.verName}</td>
<!-- <td><a href="javascript:download('${version.operName}','${version.verCode}')">操作说明下载</a></td>-->
<td style="text-align: center;"><a href="javascript:seeRemark('${ version.verName}','${ version.remark}')">版本描述</a></td>
<input   type="hidden" name="savePath" value="${ version.operName}">
<td style="text-align: center;"><a href="javascript:downloadProgram('${version.savePath}','${version.verCode}')">对应程序下载</a></td>
<td style="text-align: center;">${version.istDateFormat}</td>
<input   type="hidden" name="storagePath" value="${ version.program.storagePath}">
<td name="edit" style="text-align: center;"><a href="javascript:editVersion('${ version.id}')">修改</a></td>
<td name="delete" style="text-align: center;"><a href="javascript:deleteVersion('${ version.id}')">删除</a></td>
</tr>
</c:forEach>
</div>
</table>
</form>
	<div id="down_center" value="nihao" class="down_center"></div>
	<div id="page"></div> 		 
</body>
</html>