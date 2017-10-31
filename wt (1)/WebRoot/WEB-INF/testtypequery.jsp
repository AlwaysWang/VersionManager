<%@page import="com.itextpdf.text.log.SysoCounter,com.wt.bean.TestType,java.util.*"%>
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
</style>
<script type="text/javascript"  src="<%=basePath%>js/showdate.js"></script>
	<script type="text/javascript" src="<%=basePath%>lhgcalendar/lhgcore.js"></script>
	<script type="text/javascript" src="<%=basePath%>lhgcalendar/lhgcalendar.js"></script>
	<script type="text/javascript" src="<%=basePath%>jquery/jquery-1.8.0.min.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-base.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-all.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-lang-zh_CN.js"></script>
<script type="text/javascript">
function checkDate(d){
	   var ds=d.match(/\d+/g),ts=['getFullYear','getMonth','getDate'];
	     var d=new Date(d.replace(/-/g,'/')),i=3;
	     ds[1]--;
	     while(i--)if( ds[i]*1!=d[ts[i]]()) return false;
	     return true;
	    }
function querySomeTestType(){
	 var form = document.forms[0];  
	 var startDate = document.getElementsByName("startDate")[0].value;
	 var endDate = document.getElementsByName("endDate")[0].value;
	 var begintime = document.getElementById("c2").value;
	 var endtime = document.getElementById("c1").value;
	 var r = new RegExp("^[1-2]\\d{3}-(0?[1-9]||1[0-2])-(0?[1-9]||[1-2][1-9]||3[0-1])$");
	 if(startDate.trim().length==0){
			document.getElementById("msg1").innerHTML = "<font color='red'> 开始时间不能为空</font>";
			return false;
		}
	 if(!r.test(begintime)){
		 document.getElementById("msg1").innerHTML = "<font color='red'> 请输入正确的时间格式</font>";
			return false;
	 }
	 if(endDate.trim().length==0){
			document.getElementById("msg2").innerHTML = "<font color='red'>  截止时间不能为空</font>";
			return false;
		}
	 if(!r.test(endtime)){
		 document.getElementById("msg2").innerHTML = "<font color='red'> 请输入正确的时间格式</font>";
			return false;
	 }
	 form.action = "${pageContext.request.contextPath}/testtype/queryByName"; 
	 form.method = "post";  
     form.submit();  
}
function editTestType(typeId){
	 var form = document.forms[0]; 
	 form.action = "${pageContext.request.contextPath}/testtype/updatetesttype"; 
	 document.forms.myform.typeId.value = typeId;
	// document.forms.myform.userid.value = userid;
	 form.method = "post";  
    form.submit();  
}
window.onload=function(){ 
	var userType=$("#usertype").val();
	if(userType=="普通用户"){
		$("#edit").hide();
		$("#delete").hide();
		$("td[name='edit']").hide();
		$("td[name='delete']").hide();
	}
	var array = new Array();  
	/*<c:forEach items="${requestScope.installAllList}" var="item" varStatus="status" >  
	    array.push("${item}");  //对象，加引号
	 
	    alert("${item.verCode}");   //传递过来的是字符串，加引号 
	    </c:forEach>  */ 
	    <c:if test="${empty requestScope.testTypeAllList}">
	    document.getElementById("down_center").innerHTML = "没有找到符合条件的测试";
	    $("#pageutile").hide();
	    $("#testtypetable").empty();
	    </c:if>
	    var pagenumber=$("#pagenumber1").val();
	     $("#pageno").attr("value",1);
	    var pagesize=$("#pagesize").attr("value");
	   var listcount=$("#totalcount").val();
	   var pagenumber=$("#pagenumber1").val();
	   
	   $.ajax({
	    	type:"post",
	        url: "${pageContext.request.contextPath}/testtype/queryByCriteria",
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
 		$("#pageno").attr("value",1);
 		var pagesize=$("#pagesize").attr("value");
 		var listcount=$("#totalcount").val();
 		var listsize=$("#listsize").val();
 		var pagenumber=$("#pagenumber1").val();
 			var startDate = document.getElementsByName("startDate")[0].value;
 			 var endDate = document.getElementsByName("endDate")[0].value;
 			 var typeName= document.getElementsByName("typetest")[0].value;
 			 	 if(typeName=="请选择"){
	 typeName="";
	 }
 			$.ajax({
 				type:"post",
 			    url: "${pageContext.request.contextPath}/testtype/querySomeByCriteria",
 			    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,typetest:typeName},
 			    //dataType:"text",
 			    success:function(value){
 			    		  pagecount=value.pageCount;
 			    		  list=value.typelist;
 			    		  listsize=value.listsize;
 			    		  $("#totalpagecount").attr("value",pagecount);
 			    		  $("#pagetotalcount").attr("value",pagecount);
 			    		  $("#pagenumber").empty();
 			    		  for(var i=1;i<=pagecount;i++){
 			 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
 			 	    		
 			 	    		  } 	
 			    		  if(list.length>0){
 			    			 $("#down_center").empty;
 			    		 // <td><a href="javascript:download('${version.id}')">操作说明</a></td>
 			    		if(userType=="普通用户"){
 			    			 $("#testtypetable").html("<tr><th>测试类别ID</th><th>测试类别名称</th><th>测试类别描述</th></tr>");
 		 		    		  for(var i=0;i<list.length;i++){
 		 		    			  $("#testtypetable").append("<tr><td>"+list[i].typeId+
 		 		    					             "</td><td>"+list[i].typeName+
 		 		    					              "</td><td>"+list[i].remark+
 		 		    					              "</a></td></tr>"
 		 		    					              );
 		 		    			 
 		 		    		  }
 		 		    		  		  	 $("td").css("text-align","center");
 			    		}
 			    		else{
 			    			 $("#testtypetable").html("<tr><th>测试类别ID</th><th>测试类别名称</th><th>测试类别描述</th><th>修改</th><th>删除</th></tr>");
		 		    		  for(var i=0;i<list.length;i++){
		 		    			  $("#testtypetable").append("<tr><td>"+list[i].typeId+
		 		    					             "</td><td>"+list[i].typeName+
		 		    					              "</td><td>"+list[i].remark+
		 		    					              "</td><td><a href='javascript:editTestType("+list[i].typeId+")'>"+"修改"+
		 		    					               "</td><td><a href='javascript:deleteTestType("+list[i].typeId+")'>"+"删除"+
		 		    					              "</a></td></tr>"
		 		    					              );
		 		    			 
		 		    		  }
		 		    		  		  	 $("td").css("text-align","center");
 	    		    		 }
 			    		  }
 			    		  if(list.length==0){
 					    		 $("#down_center").html("没有找到符合条件的测试");
 					    	
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
		 	 if(typeName=="请选择"){
	 typeName="";
	 }
		$.ajax({
			type:"post",
		    url: "${pageContext.request.contextPath}/testtype/querySomeByCriteria",
		    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,typetest:typeName},
		    //dataType:"text",
		    success:function(value){
		    		  pagecount=value.pageCount;
		    		  list=value.typelist;
		    		  listsize=value.listsize;
		    		  $("#totalpagecount").attr("value",pagecount);
		    		  $("#pagetotalcount").attr("value",pagecount);
		    		  $("#pagenumber").empty();
		    		  for(var i=1;i<=pagecount;i++){
		 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
		 	    		
		 	    		  } 	
		    		  if(list.length>0){
			    			 $("#down_center").empty;
			    		 // <td><a href="javascript:download('${version.id}')">操作说明</a></td>
			    		if(userType=="普通用户"){
			    			 $("#testtypetable").html("<tr><th>测试类别ID</th><th>测试类别名称</th><th>测试类别描述</th></tr>");
		 		    		  for(var i=0;i<list.length;i++){
		 		    			  $("#testtypetable").append("<tr><td>"+list[i].typeId+
		 		    					             "</td><td>"+list[i].typeName+
		 		    					              "</td><td>"+list[i].remark+
		 		    					              "</a></td></tr>"
		 		    					              );
		 		    			 
		 		    		  }
		 		    		  		  	 $("td").css("text-align","center");
			    		}
			    		else{
			    			 $("#testtypetable").html("<tr><th>测试类别ID</th><th>测试类别名称</th><th>测试类别描述</th><th>修改</th><th>删除</th></tr>");
		 		    		  for(var i=0;i<list.length;i++){
		 		    			  $("#testtypetable").append("<tr><td>"+list[i].typeId+
		 		    					             "</td><td>"+list[i].typeName+
		 		    					              "</td><td>"+list[i].remark+
		 		    					              "</td><td><a href='javascript:editTestType("+list[i].typeId+")'>"+"修改"+
		 		    					                        "</td><td><a href='javascript:deleteTestType("+list[i].typeId+")'>"+"删除"+
		 		    					              "</a></td></tr>"
		 		    					              );
		 		    			 
		 		    		  }
		 		    		  		  	 $("td").css("text-align","center");
	    		    		 }
			    		  }
		    		  if(list.length==0){
				    		 $("#down_center").html("没有找到符合条件的测试");
				    	
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
		 	 if(typeName=="请选择"){
	 typeName="";
	 }
		$.ajax({
			type:"post",
		    url: "${pageContext.request.contextPath}/testtype/querySomeByCriteria",
		    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,typetest:typeName},
		    //dataType:"text",
		    success:function(value){
		    		  pagecount=value.pageCount;
		    		  list=value.typelist;
		    		  listsize=value.listsize;
		    		  $("#totalpagecount").attr("value",pagecount);
		    		  $("#pagetotalcount").attr("value",pagecount);
		    		  $("#pagenumber").empty();
		    		  for(var i=1;i<=pagecount;i++){
		 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
		 	    		
		 	    		  } 	
		    		  //alert(list.length);
		    		  
		    		  if(list.length>0){
			    			 $("#down_center").empty;
			    		 // <td><a href="javascript:download('${version.id}')">操作说明</a></td>
			    		if(userType=="普通用户"){
			    			 $("#testtypetable").html("<tr><th>测试类别ID</th><th>测试类别名称</th><th>测试类别描述</th></tr>");
		 		    		  for(var i=0;i<list.length;i++){
		 		    			  $("#testtypetable").append("<tr><td>"+list[i].typeId+
		 		    					             "</td><td>"+list[i].typeName+
		 		    					              "</td><td>"+list[i].remark+
		 		    					              "</a></td></tr>"
		 		    					              );
		 		    			 
		 		    		  }
		 		    		  		  	 $("td").css("text-align","center");
			    		}
			    		else{
			    			 $("#testtypetable").html("<tr><th>测试类别ID</th><th>测试类别名称</th><th>测试类别描述</th><th>修改</th><th>删除</th></tr>");
		 		    		  for(var i=0;i<list.length;i++){
		 		    			  $("#testtypetable").append("<tr><td>"+list[i].typeId+
		 		    					             "</td><td>"+list[i].typeName+
		 		    					              "</td><td>"+list[i].remark+
		 		    					              "</td><td><a href='javascript:editTestType("+list[i].typeId+")'>"+"修改"+
		 		    					                        "</td><td><a href='javascript:deleteTestType("+list[i].typeId+")'>"+"删除"+
		 		    					              "</a></td></tr>"
		 		    					              );
		 		    			 
		 		    		  }
		 		    		  		  	 $("td").css("text-align","center");
	    		    		 }
			    		  }
		    		  if(list.length==0){
				    		 $("#down_center").html("没有找到符合条件的测试");
				    	
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
		 var typeName= document.getElementsByName("typetest")[0].value;
		 	 if(typeName=="请选择"){
	 typeName="";
	 }
		$.ajax({
			type:"post",
		    url: "${pageContext.request.contextPath}/testtype/querySomeByCriteria",
		    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,typetest:typeName},
		    //dataType:"text",
		    success:function(value){
		    		  pagecount=value.pageCount;
		    		  list=value.typelist;
		    		  listsize=value.listsize;
		    		  $("#totalpagecount").attr("value",pagecount);
		    		  $("#pagetotalcount").attr("value",pagecount);
		    		  $("#pagenumber").empty();
		    		  for(var i=1;i<=pagecount;i++){
		 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
		 	    		
		 	    		  } 	
		    		  if(list.length>0){
			    			 $("#down_center").empty;
			    		 // <td><a href="javascript:download('${version.id}')">操作说明</a></td>
			    		if(userType=="普通用户"){
			    			 $("#testtypetable").html("<tr><th>测试类别ID</th><th>测试类别名称</th><th>测试类别描述</th></tr>");
		 		    		  for(var i=0;i<list.length;i++){
		 		    			  $("#testtypetable").append("<tr><td>"+list[i].typeId+
		 		    					             "</td><td>"+list[i].typeName+
		 		    					              "</td><td>"+list[i].remark+
		 		    					              "</a></td></tr>"
		 		    					              );
		 		    			 
		 		    		  }
		 		    		  		  	 $("td").css("text-align","center");
			    		}
			    		else{
			    			 $("#testtypetable").html("<tr><th>测试类别ID</th><th>测试类别名称</th><th>测试类别描述</th><th>修改</th><th>删除</th></tr>");
		 		    		  for(var i=0;i<list.length;i++){
		 		    			  $("#testtypetable").append("<tr><td>"+list[i].typeId+
		 		    					             "</td><td>"+list[i].typeName+
		 		    					              "</td><td>"+list[i].remark+
		 		    					              "</td><td><a href='javascript:editTestType("+list[i].typeId+")'>"+"修改"+
		 		    					                        "</td><td><a href='javascript:deleteTestType("+list[i].typeId+")'>"+"删除"+
		 		    					              "</a></td></tr>"
		 		    					              );
		 		    			 
		 		    		  }
		 		    		  		  	 $("td").css("text-align","center");
	    		    		 }
			    		  }
		    		  if(list.length==0){
				    		 $("#down_center").html("没有找到符合条件的测试");
				    	
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
		 	 if(typeName=="请选择"){
	 typeName="";
	 }
		$.ajax({
			type:"post",
		    url: "${pageContext.request.contextPath}/testtype/querySomeByCriteria",
		    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,typetest:typeName},
		    //dataType:"text",
		    success:function(value){
		    		  pagecount=value.pageCount;
		    		  list=value.typelist;
		    		  listsize=value.listsize;
		    		  $("#totalpagecount").attr("value",pagecount);
		    		  $("#pagetotalcount").attr("value",pagecount);
		    		  $("#pagenumber").empty();
		    		  for(var i=1;i<=pagecount;i++){
		 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
		 	    		  } 	
		    		  //alert(list.length);
		    		  
		    		  if(list.length>0){
			    			 $("#down_center").empty;
			    		 // <td><a href="javascript:download('${version.id}')">操作说明</a></td>
			    		if(userType=="普通用户"){
			    			 $("#testtypetable").html("<tr><th>测试类别ID</th><th>测试类别名称</th><th>测试类别描述</th></tr>");
		 		    		  for(var i=0;i<list.length;i++){
		 		    			  $("#testtypetable").append("<tr><td>"+list[i].typeId+
		 		    					             "</td><td>"+list[i].typeName+
		 		    					              "</td><td>"+list[i].remark+
		 		    					              "</a></td></tr>"
		 		    					              );
		 		    			 
		 		    		  }
		 		    		  		  	 $("td").css("text-align","center");
			    		}
			    		else{
			    			 $("#testtypetable").html("<tr><th>测试类别ID</th><th>测试类别名称</th><th>测试类别描述</th><th>修改</th><th>删除</th></tr>");
		 		    		  for(var i=0;i<list.length;i++){
		 		    			  $("#testtypetable").append("<tr><td>"+list[i].typeId+
		 		    					             "</td><td>"+list[i].typeName+
		 		    					              "</td><td>"+list[i].remark+
		 		    					              "</td><td><a href='javascript:editTestType("+list[i].typeId+")'>"+"修改"+
		 		    					              "</td><td><a href='javascript:deleteTestType("+list[i].typeId+")'>"+"删除"+
		 		    					              "</a></td></tr>"
		 		    					              );
		 		    			 
		 		    		  }
		 		    		  		  	 $("td").css("text-align","center");
	    		    		 }
			    		  }
		    		  if(list.length==0){
				    		 $("#down_center").html("没有找到符合条件的测试");
				    	
		    		  }	
		       
		    }	
		});		
}	

function querySomeVersion1(){
	var totalpagecount=$("#pagetotalcount").val();
	var pagesize=$("#pagesize").attr("value");
	var pageno=1;
	$("#pageno").attr("value",1);
	var pagenumber=1;
	var listcount=$("#totalcount").val();
	//alert(listcount);
	var listsize=$("#listsize").val();
		 var userType=$("#usertype").val();
	 var userType=$("#usertype").val();
	 var form = document.forms[0]; 
	 var startDate = document.getElementsByName("startDate")[0].value;
	 var endDate = document.getElementsByName("endDate")[0].value;
	 var typeName= document.getElementsByName("typetest")[0].value;
	 if(typeName=="请选择"){
	 typeName="";
	 }
	 var begintime = document.getElementById("c2").value;
	 var endtime = document.getElementById("c1").value;
	 var r = new RegExp("^[1-2]\\d{3}-(0?[1-9]||1[0-2])-(0?[1-9]||[1-2][1-9]||3[0-1])$");
	 if(startDate.trim().length!=0){
		 if(checkDate(begintime)==false){
		  $("#pageutil").hide();
			 document.getElementById("msg1").innerHTML = "<font color='red'> 请输入正确的时间格式</font>";
			  $("#testtypetable").empty();
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
				  $("#testtypetable").empty();
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
		    url: "${pageContext.request.contextPath}/testtype/queryByName",
		    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,typetest:typeName},
		    success:function(value){
		    	 $("#testtypetable").empty();
	    		  list=value.typelist;
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
		    		  if(list.length>0){
		    			  $("#pageutil").show();
		    			  $("#down_center").empty();
		    			 
		    		 // <td><a href="javascript:download('${version.id}')">操作说明</a></td>
		    			 if(userType=="普通用户"){
		    		 $("#testtypetable").html("<tr><th>测试类别ID</th><th>测试类别名称</th><th>测试类别描述</th></tr>");
	 		    		  for(var i=0;i<list.length;i++){
	 		    			  $("#testtypetable").append("<tr><td>"+list[i].typeId+
	 		    					             "</td><td>"+list[i].typeName+
	 		    					              "</td><td>"+list[i].remark+
	 		    					              "</a></td></tr>"
	 		    					              );
	 		    		  }
	 		    		  		  	 $("td").css("text-align","center");
		    			 }
		    			 else{
		    				 $("#testtypetable").html("<tr><th>测试类别ID</th><th>测试类别名称</th><th>测试类别描述</th><th>修改</th><th></th></tr>");
		 		    		  for(var i=0;i<list.length;i++){
		 		    			  $("#testtypetable").append("<tr><td>"+list[i].typeId+
		 		    					             "</td><td>"+list[i].typeName+
		 		    					              "</td><td>"+list[i].remark+
		 		    					              "</td><td><a href='javascript:editTestType("+list[i].typeId+")'>"+"修改"+
		 		    					                        "</td><td><a href='javascript:deleteTestType("+list[i].typeId+")'>"+"删除"+
		 		    					              "</a></td></tr>"
		 		    					              );
		 		    		  }
		 		    		  		  	 $("td").css("text-align","center");
		    				 
		    			 }
   		    		 }
		    		  if(list.length==0){
		    			  $("#pageutil").hide();
				    		 $("#down_center").html("没有找到符合条件的测试");
				    	
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
		 var typeName= document.getElementsByName("typetest")[0].value;
		 	 if(typeName=="请选择"){
	 typeName="";
	 }
		$.ajax({
			type:"post",
		    url: "${pageContext.request.contextPath}/testtype/querySomeByCriteria",
		    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,typetest:typeName},
		    //dataType:"text",
		    success:function(value){
		    		  pagecount=value.pageCount;
		    		  list=value.typelist;
		    		  listsize=value.listsize;
		    		  $("#totalpagecount").attr("value",pagecount);
		    		  $("#pagetotalcount").attr("value",pagecount);
		    		  if(list.length>0){
		    			  $("#pageutil").show();
			    		$("#down_center").empty;
			    		 // <td><a href="javascript:download('${version.id}')">操作说明</a></td>
			    		if(userType=="普通用户"){
			    			 $("#testtypetable").html("<tr><th>测试类别ID</th><th>测试类别名称</th><th>测试类别描述</th></tr>");
		 		    		  for(var i=0;i<list.length;i++){
		 		    			  $("#testtypetable").append("<tr><td>"+list[i].typeId+
		 		    					             "</td><td>"+list[i].typeName+
		 		    					              "</td><td>"+list[i].remark+
		 		    					              "</a></td></tr>"
		 		    					              );
		 		    			 
		 		    		  }
		 		    		  		  	 $("td").css("text-align","center");
			    		}
			    		else{
			    			 $("#testtypetable").html("<tr><th>测试类别ID</th><th>测试类别名称</th><th>测试类别描述</th><th>修改</th><th></th></tr>");
		 		    		  for(var i=0;i<list.length;i++){
		 		    			  $("#testtypetable").append("<tr><td>"+list[i].typeId+
		 		    					             "</td><td>"+list[i].typeName+
		 		    					              "</td><td>"+list[i].remark+
		 		    					              "</td><td><a href='javascript:editTestType("+list[i].typeId+")'>"+"修改"+
		 		    					                        "</td><td><a href='javascript:deleteTestType("+list[i].typeId+")'>"+"删除"+
		 		    					              "</a></td></tr>"
		 		    					              );
		 		    			 
		 		    		  }
		 		    		  		  	 $("td").css("text-align","center");
	    		    		 }
			    		  }
		    		  if(list.length==0){
				    		 $("#down_center").html("没有找到符合条件的测试");
				    		 $("#pageutil").hide();
				    		 
				    	
		    		  }	
		       
		    }	
		});		
}	

function deleteTestType(id){
var pagesize=$("#pagesize").attr("value");
		var pageno=1;
		$("#pageno").attr("value",1);
		var pagenumber=1;//页面信息
  var r=confirm("确定删除吗？");
if(r==true)
{$.ajax({
	type:"post",
   url: "${pageContext.request.contextPath}/testtype/deleteTestTypeById",
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
		    	 for(var i=1;i<=pagecount;i++){
		 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
		 	    		  } 	
		 	if( list.length>0){
		    			$("#testtypetable").html("<tr><th>测试类别ID</th><th>测试类别名称</th><th>测试类别描述</th><th>修改</th><th>删除</th></tr>");
		 		    		  for(var i=0;i<list.length;i++){
		 		    			  $("#testtypetable").append("<tr><td>"+list[i].typeId+
		 		    					             "</td><td>"+list[i].typeName+
		 		    					              "</td><td>"+list[i].remark+
		 		    					              "</td><td><a href='javascript:editTestType("+list[i].typeId+")'>"+"修改"+
		 		    					                        "</td><td><a href='javascript:deleteTestType("+list[i].typeId+")'>"+"删除"+
		 		    					              "</a></td></tr>"
		 		    					              );
		 		    			 
		 		    		  }
		 		    		  		  	 $("td").css("text-align","center");
		 		    		  }
		 		    		
		 		    		
 else{ 
 $("#testtypetable").empty();
 $("#down_center").html("没有找到符合条件的测试");
				    $("#pageutil").hide();

 }
   }
   
   });

}
}


</script>
<style type="text/css">
table.testtypetable {
position:absolute;
 font-family: verdana,arial,sans-serif;
 font-size:11px;
 color:#333333;
 border-width: 1px;
 border-color: #999999;
 border-collapse: collapse;
 left:150px;
width:1070px;
}
div.pageutil{
position:relative;
left:460px;
width:1100px;
}
div.title{
position:relative;
 left:160px;
width:1100px;
}
table.searchCondition{
position:relative;
left:160px;
width:1060px;
}
table.testtypetable th {
 background:#b5cfd2 url('cell-blue.jpg');
 border-width: 1px;
 padding: 8px;
 border-style: solid;
 border-color: #999999;
}
table.testtypetable td {
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
 <div class="title"><h1>测试类别查询</h1></div>
 <form class="testtype"  method="post" name="myform">
 <input   type="hidden" name="typeId" value=""> 
 <input type="hidden" name="listsize"  id="listsize" value="${page.totalCount}" id="listsize">
<input type="hidden" name="pagenumber1" value="${page.pageNow}" id="pagenumber1">
<input type="hidden" name="pagetotalcount"  id="pagetotalcount" value="">
<input type="hidden" name="usertype" id="usertype" value="${userType}">
<input type="hidden" name="userid" id="userid" value="${userid}">
 <table class="searchCondition">
<tr>
<td>测试类别
<select name="typetest" id="typetest"  onchange="selectChecked();" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg3').innerHTML=''"/>
<option value="请选择" selected="selected">请选择</option>
<c:forEach var="testType" items="${testTypeAllList1}" varStatus="vs">
             <option value="${testType.typeName}">${testType.typeName}</option>
       </c:forEach>
</select>
</td>
<td >开始时间
	<input type="text" id="c2"  onclick="J.calendar.get({dir:'right'});" name="startDate" 
		onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg1').innerHTML=''"/>&nbsp;
<div style="display: inline" id="msg1"></div></td>
<td>截至时间
 <input type="text" id="c1" onclick="J.calendar.get();" name="endDate" 
 	onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg2').innerHTML=''"/>
<div style="display: inline" id="msg2"></div></td>
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
<%Object list1=request.getAttribute("testTypeAllList");
if(list1==null){
System.out.print("空");}
if(list1!=null){
List<TestType> AllList=(List)list1;
//System.out.print(AllList.size());
for(int i=0;i<AllList.size();i++){
TestType testType=AllList.get(i);
String id=testType.getRemark();

}
}
 %>
 <table id="testtypetable" class="testtypetable">
<tr>
<th>测试类别ID</th>
<th>测试类别名称</th>
<th>测试类别描述</th>
<th id="edit">修改</th>
<th id="delete">删除</th>
</tr>
<c:forEach items="${requestScope.testTypeAllList}" var="testType" varStatus="vs">
<td style="text-align: center;">${testType.typeId}</td>
<td style="text-align: center;">${testType.typeName}</td>
<td style="text-align: center;">${testType.remark}</td>
 <td name="edit" style="text-align: center;"><a href="javascript:editTestType('${ testType.typeId}')" >修改</a></td>
  <td name="edit" style="text-align: center;"><a href="javascript:deleteTestType('${ testType.typeId}')" >删除</a></td>
</tr>
</c:forEach>
</table>
</form>
	<div id="down_center"></div>		
</body>
</html>