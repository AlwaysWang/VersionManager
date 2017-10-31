<%@page import="com.itextpdf.text.log.SysoCounter"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"  import="java.util.*,com.wt.bean.*"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
     <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
System.out.println(basePath);
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>   
<script type="text/javascript" src="<%=basePath%>jquery/jquery-1.8.0.min.js"></script>
<script type="text/javascript"  src="<%=basePath%>js/showdate.js"></script>
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
function querySomeProgram(){
	 var form = document.forms[0];  
	 var startDate = document.getElementsByName("startDate")[0].value;
	 var endDate = document.getElementsByName("endDate")[0].value;
	 var pgname = document.getElementsByName("pgname")[0].value;
	 var begintime = document.getElementById("c2").value;
	 var endtime = document.getElementById("c1").value;
	 var testcode= document.getElementsByName("testcode")[0].value;
	 var r = new RegExp("^[1-2]\\d{3}-(0?[1-9]||1[0-2])-(0?[1-9]||[1-2][1-9]||3[0-1])$");

	 if(startDate.trim().length==0){
			document.getElementById("msg1").innerHTML = "<font color='red'>开始时间不能为空</font>";
			return false;
		}
	 if(!r.test(begintime)){
		 document.getElementById("msg1").innerHTML = "<font color='red'> 请输入正确的时间格式</font>";
			return false;
	 }
	 if(endDate.trim().length==0){
			document.getElementById("msg2").innerHTML = "<font color='red'> 截止时间不能为空</font>";
			return false;
		}
	 if(!r.test(endtime)){
		 document.getElementById("msg2").innerHTML = "<font color='red'> 请输入正确的时间格式</font>";
			return false;
	 }
		if(pgname.trim().length==0){
			document.getElementById("msg3").innerHTML = "<font color='red'> 程序名称不能为空</font>";
			return false;
		}
		 if(testcode==0){
				document.getElementById("msg4").innerHTML = "<font color='red'> * 测试类别不能为空</font>";
				return false;
			}
	 form.action = "${pageContext.request.contextPath}/program/querysomeprogram"; 
	 form.method = "post";  
     form.submit(); 
}
function editprogram(id){
	 var form = document.forms[1];  
	 form.action = "${pageContext.request.contextPath}/program/updateprogram"; 
	 document.forms.myform.id.value = id;
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
	   <c:if test="${empty requestScope.pgAllList}">
	    document.getElementById("down_center").innerHTML = "没有找到符合条件的程序";
	    $("#pageutil").hide();
	    $("#programtable").empty();
	    </c:if>
	var pagesize=$("#pagesize").attr("value");
	var listcount=$("#totalcount").val();
    var pagenumber=$("#pagenumber1").val();
	    $.ajax({
	    	type:"post",
	        url: "${pageContext.request.contextPath}/program/queryByCriteria",
	        data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber},
	        //dataType:"text",
	        success:function(value){
	        		  pagecount=value.pageCount;
	        		  list=value.programlist;
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
	
function getFunByCriteria(){
	var userType=$("#usertype").val();
	$("#pageno").attr("value",1);
	var pagesize=$("#pagesize").attr("value");
	var listcount=$("#totalcount").val();
	var listsize=$("#listsize").val();
	var pagenumber=$("#pagenumber1").val();
		 var form = document.forms[0];  
		 var startDate = document.getElementsByName("startDate")[0].value;
		 var endDate = document.getElementsByName("endDate")[0].value;
		 var pgname = document.getElementsByName("pgname")[0].value;
		 var begintime = document.getElementById("c2").value;
		 var endtime = document.getElementById("c1").value;
		// var testcode= document.getElementsByName("testcode")[0].value;
		$.ajax({
			type:"post",
		    url: "${pageContext.request.contextPath}/program/querySomeListByCriteria",
		    //data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,pgname:pgname},
		    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,pgname:pgname},
		    //dataType:"text",
		    success:function(value){
		    		  pagecount=value.pageCount;
		    		  list=value.programlist;
		    		  listsize=value.listsize;
		    	
		    		  $("#totalpagecount").attr("value",pagecount);
		    		  $("#pagetotalcount").attr("value",pagecount);
		    		  $("#pagenumber").empty();
		    		  for(var i=1;i<=pagecount;i++){
		 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
		 	    		
		 	    		  } 	
		    		  //alert(list.length);
		    		  
		    		  if(list.length>0){
		    		 // <td><a href="javascript:download('${version.id}')">操作说明</a></td>
		     if(userType=="普通用户"){
		    			  $("#programtable").html("<tr><th>程序ID</th><th>程序名称</th><th>程序版本信息</<th><th>程序描述</th><th>程序创建时间</th></tr>");
			    		  for(var i=0;i<list.length;i++){
			    		    // for(var j=0;j<list[i].testCode.length;j++){
			    			 //list[i].savePath.replace(/\\/g, "/");
			    			  //alert(list[i].savePath.replace(/\\/g, "/"));
			    			  $("#programtable").append("<tr><td>"+list[i].id+
			    					             "</td><td>"+list[i].pgName+
			    					              "</td><td>"+list[i].pgEdition+
			    					              "</td><td>"+list[i].remark+
			    					              "</td><td>"+list[i].istDateFormat+
			    					              "</a></td></tr>"
			    					              );
			    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
			    		     //}
			    		  }
			    		  		  	 $("td").css("text-align","center");
		     }
		     else{
		    	 $("#programtable").html("<tr><th>程序ID</th><th>程序名称</th><th>程序版本信息</<th><th>程序描述</th><th>程序创建时间</th><th>修改</th><th>删除</th></tr>");
	    		  for(var i=0;i<list.length;i++){
	    		    // for(var j=0;j<list[i].testCode.length;j++){
	    			 //list[i].savePath.replace(/\\/g, "/");
	    			  //alert(list[i].savePath.replace(/\\/g, "/"));
	    			  $("#programtable").append("<tr><td>"+list[i].id+
	    					             "</td><td>"+list[i].pgName+
	    					              "</td><td>"+list[i].pgEdition+
	    					              "</td><td>"+list[i].remark+
	    					              "</td><td>"+list[i].istDateFormat+
	    					              "</td><td><a href='javascript:editprogram("+list[i].id+")'>"+"修改"+
	    					              "</td><td><a href='javascript:deleteprogram("+list[i].id+")'>"+"删除"+
	    					              "</a></td></tr>"
	    					              );
	    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
	    		     //}
	    		  }
	    		  		  	 $("td").css("text-align","center");
		     }
		    		  }
		    		  if(list.length==0){
				    		 $("#down_center").html("没有找到符合条件的程序");
				    	
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
		var form = document.forms[0];  
		 var startDate = document.getElementsByName("startDate")[0].value;
		var endDate = document.getElementsByName("endDate")[0].value;
		 var pgname = document.getElementsByName("pgname")[0].value;
		// var begintime = document.getElementById("c2").value;
		// var endtime = document.getElementById("c1").value;
		// var testcode= document.getElementsByName("testcode")[0].value;
		$.ajax({
			type:"post",
		    url: "${pageContext.request.contextPath}/program/querySomeListByCriteria",
		    //data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,pgname:pgname},
		    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,pgname:pgname},
		    //dataType:"text",
		    success:function(value){
		    		  pagecount=value.pageCount;
		    		  list=value.programlist;
		    		  listsize=value.listsize;
		    		  $("#totalpagecount").attr("value",pagecount);
		    		  $("#pagetotalcount").attr("value",pagecount);
		    		 /* $("#pagenumber").empty();
		    		  for(var i=1;i<=pagecount;i++){
		 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
		 	    		  } 	
*/
		    		  
		    		  if(list.length>0){
				    		 // <td><a href="javascript:download('${version.id}')">操作说明</a></td>
				     if(userType=="普通用户"){
				    			  $("#programtable").html("<tr><th>程序ID</th><th>程序名称</th><th>程序版本信息</<th><th>程序描述</th><th>程序创建时间</th></tr>");
					    		  for(var i=0;i<list.length;i++){
					    		    // for(var j=0;j<list[i].testCode.length;j++){
					    			 //list[i].savePath.replace(/\\/g, "/");
					    			  //alert(list[i].savePath.replace(/\\/g, "/"));
					    			  $("#programtable").append("<tr><td>"+list[i].id+
					    					  "</td><td>"+list[i].pgName+
		    					              "</td><td>"+list[i].pgEdition+
		    					              "</td><td>"+list[i].remark+
		    					              "</td><td>"+list[i].istDateFormat+
					    					              "</a></td></tr>"
					    					              );
					    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
					    		     //}
					    		  }
					    		  		  	 $("td").css("text-align","center");
				     }
				     else{
				    	 $("#programtable").html("<tr><th>程序ID</th><th>程序名称</th><th>程序版本信息</<th><th>程序描述</th><th>程序创建时间</th><th>修改</th><th>删除</th></tr>");
			    		  for(var i=0;i<list.length;i++){
			    		    // for(var j=0;j<list[i].testCode.length;j++){
			    			 //list[i].savePath.replace(/\\/g, "/");
			    			  //alert(list[i].savePath.replace(/\\/g, "/"));
			    			  $("#programtable").append("<tr><td>"+list[i].id+
			    					  "</td><td>"+list[i].pgName+
    					              "</td><td>"+list[i].pgEdition+
    					              "</td><td>"+list[i].remark+
    					              "</td><td>"+list[i].istDateFormat+
    					              "</td><td><a href='javascript:editprogram("+list[i].id+")'>"+"修改"+
    					                 "</td><td><a href='javascript:deleteprogram("+list[i].id+")'>"+"删除"+
			    					              "</a></td></tr>"
			    					              );
			    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
			    		     //}
			    		  }
			    		  		  	 $("td").css("text-align","center");
				     }
				    		  }
		    		  if(list.length==0){
				    		 $("#down_center").html("没有找到符合条件的程序");
				    	
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
		var form = document.forms[0];  
		 var startDate = document.getElementsByName("startDate")[0].value;
		var endDate = document.getElementsByName("endDate")[0].value;
		 var pgname = document.getElementsByName("pgname")[0].value;
		 //var begintime = document.getElementById("c2").value;
		 //var endtime = document.getElementById("c1").value;
		 //var testcode= document.getElementsByName("testcode")[0].value;
		$.ajax({
			type:"post",
		    url: "${pageContext.request.contextPath}/program/querySomeListByCriteria",
		   // data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,pgname:pgname},
		    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,pgname:pgname},
		    //dataType:"text",
		    success:function(value){
		    		  pagecount=value.pageCount;
		    		  list=value.programlist;
		    		  listsize=value.listsize;
		    		  $("#totalpagecount").attr("value",pagecount);
		    		  $("#pagetotalcount").attr("value",pagecount);
		    		  $("#pagenumber").empty();
		    		  for(var i=1;i<=pagecount;i++){
		 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
		 	    		  } 	
		    		 // <td><a href="javascript:download('${version.id}')">操作说明</a></td>
		    			  
		    			  if(list.length>0){
		 		    		 // <td><a href="javascript:download('${version.id}')">操作说明</a></td>
		 		     if(userType=="普通用户"){
		 		    	
		 		    			  $("#programtable").html("<tr><th>程序ID</th><th>程序名称</th><th>程序版本信息</<th><th>程序描述</th><th>程序创建时间</th></tr>");
		 			    		  for(var i=0;i<list.length;i++){
		 			    		    // for(var j=0;j<list[i].testCode.length;j++){
		 			    			 //list[i].savePath.replace(/\\/g, "/");
		 			    			  //alert(list[i].savePath.replace(/\\/g, "/"));
		 			    			  $("#programtable").append("<tr><td>"+list[i].id+
		 			    					 "</td><td>"+list[i].pgName+
		    					              "</td><td>"+list[i].pgEdition+
		    					              "</td><td>"+list[i].remark+
		    					              "</td><td>"+list[i].istDateFormat+
		 			    					              "</a></td></tr>"
		 			    					              );
		 			    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
		 			    		     //}
		 			    		  }
		 			    		  		  	 $("td").css("text-align","center");
		 		     }
		 		     else{
		 
		 		    	 $("#programtable").html("<tr><th>程序ID</th><th>程序名称</th><th>程序版本信息</<th><th>程序描述</th><th>程序创建时间</th><th>修改</th><th>删除</th></tr>");
		 	    		  for(var i=0;i<list.length;i++){
		 	    		    // for(var j=0;j<list[i].testCode.length;j++){
		 	    			 //list[i].savePath.replace(/\\/g, "/");
		 	    			  //alert(list[i].savePath.replace(/\\/g, "/"));
		 	    			  $("#programtable").append("<tr><td>"+list[i].id+
		 	    					 "</td><td>"+list[i].pgName+
   					              "</td><td>"+list[i].pgEdition+
   					              "</td><td>"+list[i].remark+
   					              "</td><td>"+list[i].istDateFormat+
   					              "</td><td><a href='javascript:editprogram("+list[i].id+")'>"+"修改"+
   					                 "</td><td><a href='javascript:deleteprogram("+list[i].id+")'>"+"删除"+
		 	    					              "</a></td></tr>"
		 	    					              );
		 	    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
		 	    		     //}
		 	    		  }
		 	    		  		  	 $("td").css("text-align","center");
		 		     }
		 		    		  }
		    		  if(list.length==0){
				    		 $("#down_center").html("没有找到符合条件的程序");
				    	
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
		var form = document.forms[0];  
		 var startDate = document.getElementsByName("startDate")[0].value;
		 var endDate = document.getElementsByName("endDate")[0].value;
		 var pgname = document.getElementsByName("pgname")[0].value;
		// var begintime = document.getElementById("c2").value;
		// var endtime = document.getElementById("c1").value;
		 //var testcode= document.getElementsByName("testcode")[0].value;
		$.ajax({
			type:"post",
		    url: "${pageContext.request.contextPath}/program/querySomeListByCriteria",
		    //data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,pgname:pgname},
		    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,pgname:pgname},
		    //dataType:"text",
		    success:function(value){
		    		  pagecount=value.pageCount;
		    		  list=value.programlist;
		    		  listsize=value.listsize;
		    		  $("#totalpagecount").attr("value",pagecount);
		    		  $("#pagetotalcount").attr("value",pagecount);
		    		  $("#pagenumber").empty();
		    		  for(var i=1;i<=pagecount;i++){
		 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
		 	    		  } 	

		    		  
		    		  if(list.length>0){
				    		 // <td><a href="javascript:download('${version.id}')">操作说明</a></td>
				     if(userType=="普通用户"){
				    			  $("#programtable").html("<tr><th>程序ID</th><th>程序名称</th><th>程序版本信息</<th><th>程序描述</th><th>程序创建时间</th></tr>");
					    		  for(var i=0;i<list.length;i++){
					    		    // for(var j=0;j<list[i].testCode.length;j++){
					    			 //list[i].savePath.replace(/\\/g, "/");
					    			  //alert(list[i].savePath.replace(/\\/g, "/"));
					    			  $("#programtable").append("<tr><td>"+list[i].id+
					    					  "</td><td>"+list[i].pgName+
		    					              "</td><td>"+list[i].pgEdition+
		    					              "</td><td>"+list[i].remark+
		    					              "</td><td>"+list[i].istDateFormat+
					    					              "</a></td></tr>"
					    					              );
					    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
					    		     //}
					    		  }
					    		  		  	 $("td").css("text-align","center");
				     }
				     else{
				    	 $("#programtable").html("<tr><th>程序ID</th><th>程序名称</th><th>程序版本信息</<th><th>程序描述</th><th>程序创建时间</th><th>修改</th><th>删除</th></tr>");
			    		  for(var i=0;i<list.length;i++){
			    		    // for(var j=0;j<list[i].testCode.length;j++){
			    			 //list[i].savePath.replace(/\\/g, "/");
			    			  //alert(list[i].savePath.replace(/\\/g, "/"));
			    			  $("#programtable").append("<tr><td>"+list[i].id+
			    					  "</td><td>"+list[i].pgName+
    					              "</td><td>"+list[i].pgEdition+
    					              "</td><td>"+list[i].remark+
    					              "</td><td>"+list[i].istDateFormat+
    					              "</td><td><a href='javascript:editprogram("+list[i].id+")'>"+"修改"+
    					                 "</td><td><a href='javascript:deleteprogram("+list[i].id+")'>"+"删除"+
			    					              "</a></td></tr>"
			    					              );
			    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
			    		     //}
			    		  }
			    		  		  	 $("td").css("text-align","center");
				     }
				    		  }
		    		  if(list.length==0){
				    		 $("#down_center").html("没有找到符合条件的程序");
				    	
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
		var form = document.forms[0];  
		var startDate = document.getElementsByName("startDate")[0].value;
		var endDate = document.getElementsByName("endDate")[0].value;
		 var pgname = document.getElementsByName("pgname")[0].value;
		// var begintime = document.getElementById("c2").value;
		 //var endtime = document.getElementById("c1").value;
		// var testcode= document.getElementsByName("testcode")[0].value;
		$.ajax({
			type:"post",
		    url: "${pageContext.request.contextPath}/program/querySomeListByCriteria",
		   // data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,pgname:pgname},
		    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,pgname:pgname},
		    //dataType:"text",
		    success:function(value){
		    		  pagecount=value.pageCount;
		    		  list=value.programlist;
		    		  listsize=value.listsize;
		    		  $("#totalpagecount").attr("value",pagecount);
		    		  $("#pagetotalcount").attr("value",pagecount);
		    		  $("#pagenumber").empty();
		    		  for(var i=1;i<=pagecount;i++){
		 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
		 	    		  } 	

		    		  
		    		  if(list.length>0){
				    		 // <td><a href="javascript:download('${version.id}')">操作说明</a></td>
				     if(userType=="普通用户"){
				    			  $("#programtable").html("<tr><th>程序ID</th><th>程序名称</th><th>程序版本信息</<th><th>程序描述</th><th>程序创建时间</th></tr>");
					    		  for(var i=0;i<list.length;i++){
					    		    // for(var j=0;j<list[i].testCode.length;j++){
					    			 //list[i].savePath.replace(/\\/g, "/");
					    			  //alert(list[i].savePath.replace(/\\/g, "/"));
					    			  $("#programtable").append("<tr><td>"+list[i].id+
					    					  "</td><td>"+list[i].pgName+
		    					              "</td><td>"+list[i].pgEdition+
		    					              "</td><td>"+list[i].remark+
		    					              "</td><td>"+list[i].istDateFormat+
					    					              "</a></td></tr>"
					    					              );
					    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
					    		     //}
					    		  }
					    		  		  	 $("td").css("text-align","center");
				     }
				     else{
				    	 $("#programtable").html("<tr><th>程序ID</th><th>程序名称</th><th>程序版本信息</<th><th>程序描述</th><th>程序创建时间</th><th>修改</th><th>删除</th></tr>");
			    		  for(var i=0;i<list.length;i++){
			    		    // for(var j=0;j<list[i].testCode.length;j++){
			    			 //list[i].savePath.replace(/\\/g, "/");
			    			  //alert(list[i].savePath.replace(/\\/g, "/"));
			    			  $("#programtable").append("<tr><td>"+list[i].id+
			    					  "</td><td>"+list[i].pgName+
    					              "</td><td>"+list[i].pgEdition+
    					              "</td><td>"+list[i].remark+
    					              "</td><td>"+list[i].istDateFormat+
    					              "</td><td><a href='javascript:editprogram("+list[i].id+")'>"+"修改"+
    					                 "</td><td><a href='javascript:deleteprogram("+list[i].id+")'>"+"删除"+
			    					              "</a></td></tr>"
			    					              );
			    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
			    		     //}
			    		  }
			    		  		  	 $("td").css("text-align","center");
				     }
				    		  }
		    		  if(list.length==0){
				    		 $("#down_center").html("没有找到符合条件的程序");
				    	
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
		var form = document.forms[0];  
		var startDate = document.getElementsByName("startDate")[0].value;
		var endDate = document.getElementsByName("endDate")[0].value;
		 var pgname = document.getElementsByName("pgname")[0].value;
		// var begintime = document.getElementById("c2").value;
		 //var endtime = document.getElementById("c1").value;
		// var testcode= document.getElementsByName("testcode")[0].value;
		$.ajax({
			type:"post",
		    url: "${pageContext.request.contextPath}/program/querySomeListByCriteria",
		  // data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,pgname:pgname},
		    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,pgname:pgname},
		    //dataType:"text",
		    success:function(value){
		    		  pagecount=value.pageCount;
		    		  list=value.programlist;
		    		  listsize=value.listsize;
		    		  $("#totalpagecount").attr("value",pagecount);
		    		  $("#pagetotalcount").attr("value",pagecount);
		    		  $("#pagenumber").empty();
		    		  for(var i=1;i<=pagecount;i++){
		 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
		 	    		  }
		    		  if(list.length>0){
				    		 // <td><a href="javascript:download('${version.id}')">操作说明</a></td>
				     if(userType=="普通用户"){
				    			  $("#programtable").html("<tr><th>程序ID</th><th>程序名称</th><th>程序版本信息</<th><th>程序描述</th><th>程序创建时间</th></tr>");
					    		  for(var i=0;i<list.length;i++){
					    		    // for(var j=0;j<list[i].testCode.length;j++){
					    			 //list[i].savePath.replace(/\\/g, "/");
					    			  //alert(list[i].savePath.replace(/\\/g, "/"));
					    			  $("#programtable").append("<tr><td>"+list[i].id+
					    					  "</td><td>"+list[i].pgName+
		    					              "</td><td>"+list[i].pgEdition+
		    					              "</td><td>"+list[i].remark+
		    					              "</td><td>"+list[i].istDateFormat+
					    					              "</a></td></tr>"
					    					              );
					    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
					    		     //}
					    		  }
					    		  		  	 $("td").css("text-align","center");
				     }
				     else{
				    	 $("#programtable").html("<tr><th>程序ID</th><th>程序名称</th><th>程序版本信息</<th><th>程序描述</th><th>程序创建时间</th><th>修改</th><th>删除</th></tr>");
			    		  for(var i=0;i<list.length;i++){
			    		    // for(var j=0;j<list[i].testCode.length;j++){
			    			 //list[i].savePath.replace(/\\/g, "/");
			    			  //alert(list[i].savePath.replace(/\\/g, "/"));
			    			  $("#programtable").append("<tr><td>"+list[i].id+
			    					  "</td><td>"+list[i].pgName+
    					              "</td><td>"+list[i].pgEdition+
    					              "</td><td>"+list[i].remark+
    					              "</td><td>"+list[i].istDateFormat+
    					              "</td><td><a href='javascript:editprogram("+list[i].id+")'>"+"修改"+
    					                 "</td><td><a href='javascript:deleteprogram("+list[i].id+")'>"+"删除"+
			    					              "</a></td></tr>"
			    					              );
			    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
			    		     //}
			    		  }
			    		  		  	 $("td").css("text-align","center");
				     }
				    		  }
		    		  if(list.length==0){
				    		 $("#down_center").html("没有找到符合条件程序");
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
	var totalpagecount=$("#pagetotalcount").val();
	var pagesize=$("#pagesize").attr("value");
	var pageno=1;
	$("#pageno").attr("value",1);
	//var pagenumber=$("#pagenumber").attr("value");
	var pagenumber=1;
	var listcount=$("#totalcount").val();
	var listsize=$("#listsize").val();
	var userType=$("#usertype").val();
	 var form = document.forms[0];  
	var startDate = document.getElementsByName("startDate")[0].value;
	var endDate = document.getElementsByName("endDate")[0].value;
	 var pgname = document.getElementsByName("pgname")[0].value;
	 var begintime = document.getElementById("c2").value;
	 var endtime = document.getElementById("c1").value;
	 var r = new RegExp("^[1-2]\\d{3}-(0?[1-9]||1[0-2])-(0?[1-9]||[1-2][1-9]||3[0-1])$");
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
				  $("#programtable").empty();
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
		    url:"${pageContext.request.contextPath}/program/querysomeprogram",
		    data:{pagesize:pagesize,listcount:listcount,pagenumber:pagenumber,startDate:startDate,endDate:endDate,pgname:pgname},
		    success:function(value){
		    	 $("#programtable").empty();
		   	         list=value.programlist;
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
    			  $("#programtable").html("<tr><th>程序ID</th><th>程序名称</th><th>程序版本信息</<th><th>程序描述</th><th>程序创建时间</th></tr>");
	    		  for(var i=0;i<list.length;i++){
	    		    // for(var j=0;j<list[i].testCode.length;j++){
	    			 //list[i].savePath.replace(/\\/g, "/");
	    			  //alert(list[i].savePath.replace(/\\/g, "/"));
	    			  $("#programtable").append("<tr><td>"+list[i].id+
	    					  "</td><td>"+list[i].pgName+
				              "</td><td>"+list[i].pgEdition+
				              "</td><td>"+list[i].remark+
				              "</td><td>"+list[i].istDateFormat+
	    					              "</a></td></tr>"
	    					              );
	    			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
	    		     //}
	    		  }
	    		  		  	 $("td").css("text-align","center");
     }
     else{
    	 $("#programtable").html("<tr><th>程序ID</th><th>程序名称</th><th>程序版本信息</<th><th>程序描述</th><th>程序创建时间</th><th>修改</th><th>删除</th></tr>");
		  for(var i=0;i<list.length;i++){
		    // for(var j=0;j<list[i].testCode.length;j++){
			 //list[i].savePath.replace(/\\/g, "/");
			  //alert(list[i].savePath.replace(/\\/g, "/"));
			  $("#programtable").append("<tr><td>"+list[i].id+
					  "</td><td>"+list[i].pgName+
		              "</td><td>"+list[i].pgEdition+
		              "</td><td>"+list[i].remark+
		              "</td><td>"+list[i].istDateFormat+
		              "</td><td><a href='javascript:editprogram("+list[i].id+")'>"+"修改"+
		                      "</td><td><a href='javascript:deleteprogram("+list[i].id+")'>"+"删除"+
		    
					              "</a></td></tr>"
					              );
			//var obj= $("<input type='text', name=list[i], value=list[i].savePath />").appendTo($("#table"));
		     //}
		  }
		  		  	 $("td").css("text-align","center");
     }
    		  }
		    		  if(list.length==0){
				    		 $("#down_center").html("没有找到符合条件的程序");
				    	     $("#pageutil").hide();
				    		 }
		    		 
		    	
		       
		    }	
		});		
	
	
	
}
function selectChecked(){
	var typename=$("#typetest").attr("value");
	$.ajax({
	   type: "POST",
	   url: "${pageContext.request.contextPath}/installVersion/typetest",
	   data: "typename="+typename+"",
	  dateType:"json",
	   success: function(value){
		
	   var msg=eval("("+value+")");
	  var obj = document.getElementById("testcode");
	  for(var i=0;i<msg.length;i++){
	  obj.options[i]= new Option(msg[i],i);
	
	  }
	  //selectCheckedTwo();
	  } 
	});
	}
	function  deleteprogram(id){
	var infor;
	var length;
	var infor1;
	var length1;
	var pagesize=$("#pagesize").attr("value");
		var pageno=1;
		var r;
		$("#pageno").attr("value",1);
		var pagenumber=1;//页面信息
		$.ajax({
	type:"post",
   url: "${pageContext.request.contextPath}/program/ConfirmProgramById",
   data:{id:id},
      async:false,
   success:function(value){
   pgModuleList=value.pgModuleList;
   if(pgModuleList.length>0){
  infor=value.FunNameList1;
  length=value.FunNameList1.length;
  infor1=value.FunNameList2;
  length1=value.FunNameList2.length;
  }
 
  if(length>0&& length1>0){
  r=confirm(infor1+"这"+length1+"个功能"+"与该程序对应,"+"\n"+infor+"这"+length+"个功能"+"与该程序唯一对应,"+"\n"+"若该程序删除，请及时为"+infor+"这"+length+"个功能添加对应程序，否则功能将失效");
  }
  if(length>0&& length1==0){
  r=confirm(infor+"这"+length+"个功能"+"与该程序唯一对应,"+"\n"+"若该程序删除，请及时为"+infor+"这"+length+"个功能添加对应程序，否则功能将失效");
  }
  if(length==0&& length1>0){
  r=confirm(infor1+"这"+length1+"个功能"+"与该程序对应,"+"\n"+"确认删除此程序吗");
  }
   if(pgModuleList.length==0){
  r=confirm("没有功能对应该程序，"+"\n"+"确认删除此程序吗");
  }
   }
   });
if(r==true){
$.ajax({
	type:"post",
   url: "${pageContext.request.contextPath}/program/deleteProgramById",
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
		    		    $("#c1").val("");
		    		  $("#c2").val("");
		    		$("#pgname").val("");
		    	 for(var i=1;i<=pagecount;i++){
		 	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
		 	    		  } 	
		 	if(list.length>0){
		    			$("#programtable").html("<tr><th>程序ID</th><th>程序名称</th><th>程序版本信息</<th><th>程序描述</th><th>程序创建时间</th><th>修改</th><th>删除</th></tr>");
		  for(var i=0;i<list.length;i++){
			  $("#programtable").append("<tr><td>"+list[i].id+
					  "</td><td>"+list[i].pgName+
		              "</td><td>"+list[i].pgEdition+
		              "</td><td>"+list[i].remark+
		              "</td><td>"+list[i].istDateFormat+
		              "</td><td><a href='javascript:editprogram("+list[i].id+")'>"+"修改"+
		                      "</td><td><a href='javascript:deleteprogram("+list[i].id+")'>"+"删除"+
		    
					              "</a></td></tr>"
					              );
		  }
		  		  	 $("td").css("text-align","center");
		  }
		  else{
		  $("#programtable").empty();
		   $("#down_center").html("程序已全部删除");
		  $("#pageutil").hide();
		  }
     }
   });
}
}
	
	
	
	
	
	
</script>
<style type="text/css">
a{text-decoration: none;}
table.programtable {
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
left:150px;
width:1080px;
}
table.programtable th {
 background:#b5cfd2 url('cell-blue.jpg');
 border-width: 1px;
 padding: 8px;
 border-style: solid;
 border-color: #999999;
}
table.programtable td {
 background:#dcddc0 url('cell-grey.jpg');
 border-width: 1px;
 padding: 8px;
 border-style: solid;
 border-color: #999999;
}
a{text-decoration: none;}
#down_center{
position:relative;
 left:160px;
width:1100px;
top:40px;
}

</style>
</head>
<body style="overflow:-Scroll;overflow-x:hidden">
<div class="title"><h1>程序查询</h1></div>
<form >
<input type="hidden" name="listsize"  id="listsize" value="${page.totalCount}" id="listsize">
<input type="hidden" name="pagenumber1" value="${page.pageNow}" id="pagenumber1">
<input type="hidden" name="pagetotalcount"  id="pagetotalcount" value="">
<table boder="1" cellpadding="10">
<table class="searchCondition">
<tr>
<td >开始时间
	<input type="text" id="c2"  onclick="J.calendar.get({dir:'right'});" name="startDate" 
	onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg1').innerHTML=''"/>
<div style="display: inline" id="msg1"></td>
<td>截至时间
 <input type="text" id="c1"  onclick="J.calendar.get();" name="endDate" 
 onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg2').innerHTML=''"/>
<div style="display: inline" id="msg2"></td>
<td>程序名称<input type="text" style="width: 100px;" name="pgname" id="pgname" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg3').innerHTML=''"/>
<div style="display: inline" id="msg3"></td>
<!--  <td>
<label>功能类别</label>
<select name="typetest" id="typetest"  onchange="selectChecked();" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg3').innerHTML=''"/>
<option value="请选择" selected="selected">请选择</option>
<c:forEach var="testType" items="${testTypeAllList}" varStatus="vs">
             <option value="${testType.typeName}">${testType.typeName}</option>
       </c:forEach>
</select>
<div style="display: inline" id="msg3"></div>
</td>
<td>功能类型
<select name="testcode" id="testcode"  onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg4').innerHTML=''" />
<option value="" selected="selected">请选择</option>
  <c:forEach var="testCode" items="${testCodeList}" varStatus="vs">
             <option value="${testCode.testName}">${testCode.testName}</option>
       </c:forEach>
</select>
  <div style="display: inline" id="msg4"></div>
  </td>-->
<td><input type="button" value="查询" class="button" onclick="querySomeVersion1();"></td>
</tr>
</table>
</br>
<div class="pageutil" id="pageutil">
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
</form>
<form name="myform">
<input   type="hidden" name="id" value="">
<input type="hidden" name="listsize"  id="listsize" value="${page.totalCount}" id="listsize">
<input type="hidden" name="pagenumber1" value="${page.pageNow}" id="pagenumber1">
<input type="hidden" name="pagetotalcount"  id="pagetotalcount" value=""> 
<input type="hidden" name="usertype" id="usertype" value="${userType}">
<input type="hidden" name="userid"  id="userid" value="${userid}">
<input type="hidden" name="confirm"  id="confirm" value="">
<table boder="1" cellpadding="10" id="programtable" class="programtable">
<tr>
<th>程序ID</th>
<th>程序名称</th>
<th>程序版本信息</th>
<th>程序描述</th>
<th>程序创建时间</th>
<th id="edit">修改</th>
<th id="delete">删除</th>
</tr>
<tr>
<% Object obj=request.getAttribute("pgList"); 
List<Program> pgList=(List)obj;

for(Program program:pgList){
	
	//for(TestCode code : program.getTestCode()){
		//System.out.print("nihao"+program.getId());
%><tr>
 <td style="text-align: center;"><%=program.getId()%></td>
 <td style="text-align: center;"><%=program.getPgName()%></td>
  <td style="text-align: center;"><%=program.getPgEdition()%></td>
 <td style="text-align: center;"><%=program.getRemark()%></td>
 <td style="text-align: center;"><%=program.getIstDateFormat()%></td>
 <td name="edit" style="text-align: center;"><a href="javascript:editprogram('<%=program.getId()%>')">修改</a></td>
  <td name="delete" style="text-align: center;"><a href="javascript:deleteprogram('<%=program.getId()%>')">删除</a></td>
 </tr>
<%} %>
</tr>
</table>
</form>
<div id="down_center"></div>	
</body>
</html>