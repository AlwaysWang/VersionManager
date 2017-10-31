<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
       <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
     <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
System.out.println(basePath);
%>
<script type="text/javascript" src="<%=basePath%>jquery/jquery-1.8.0.min.js"></script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>功能列表</title>
<script type="text/javascript">
window.onload=function(){ 
   var form = document.forms[0];  
   var versionId= window.opener.document.getElementById('versionId').value;
   document.forms.myform.versionId.value=versionId;
$.ajax({  
		       type:"POST",  
		       data:{versionId:versionId},
		       url:"${pageContext.request.contextPath}/installVersion/showFunList",  
		       success:function(data){
		        $("#totalpagecount").attr("value",data.page.totalPageCount);
		       $("#totalcount").attr("value",data.page.totalCount);
		        $("#funIdList").attr("value",data.FunIdList);
		       $("#funIdList1").attr("value",data.FunIdList);
		       list=data.AllFunList;
		       AllFunIdList=data.AllFunIdList;
		      pagecount=data.page.totalPageCount;
		       $("#pagenumber").empty();
		       for(var i=1;i<=pagecount;i++){
	     	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
	     	    		  } 	 
		              for(var i=0;i<list.length;i++){ 
		            	  
		              
         $("#funtable").append("<tr><td><input name='"+list[i].id+"' type='checkbox' id='function' value='"+list[i].id+"'    onclick='checkboxOnclick("+list[i].id+")'><span>"+list[i].name+"</span></td>");
         if(i%6==0){
           	$("#funtable").append("</tr>");
           }
		              } 
		                $("tr:even").addClass("even");
                      $("tr:odd").addClass("odd");
		           
		              FunIdList=data.FunIdList;
		              var msg=eval("("+FunIdList+")");
		              $.each(FunIdList, function (index, item) {
		            	   // $("input[name='program']").each(function () {
		            	   	$(":checkbox").each(function(){
		            	        if ($(this).val() == item) {
		            	            $(this).attr("checked",true);
		            	        }
		            	    });
		            	}); 
		       }         
		});
$.ajax({  
		       type:"POST",  
		       data:{
		       },
		       url:"${pageContext.request.contextPath}/installVersion/showtesttype",  
		       success:function(data){
		       testTypeNameList=data.testTypeNameList;
		       testTypeIdList=data.testTypeIdList;
		        var testtype = document.getElementById("typetest");
		         testtype.options[0]= new Option("请选择",  "");
		         for(var i=0;i<testTypeIdList.length;i++){
	  testtype.options[i+1]= new Option(testTypeNameList[i],  testTypeIdList[i]);
	  }
}
});
}
function selectChecked(){
document.getElementById("pagebottom").innerHTML = "";
document.getElementById("msg1").innerHTML = "";
	var typename=$("#typetest").find("option:selected").text(); 
	$("#testcode").empty();
	$.ajax({
	   type: "POST",
	   url: "${pageContext.request.contextPath}/function/typetest",
	   data: "typename="+typename+"",
	  dateType:"json",
	   success: function(value){
		   msg=value.list;
           msg1=value.list1;
	  var obj = document.getElementById("testcode");
	  for(var i=0;i<msg.length;i++){
	  obj.options[i]= new Option(msg1[i]+msg[i],msg[i]);
	
	  }
	  } 
	});
	}

function checkboxOnclick(id){
var funIdList=document.getElementById("funIdList1").value;
var versionId= document.getElementById("versionId").value;
var check = document.getElementsByName(id)[0];
 var a = 1;
  if(check.checked){
        a = 1;//添加
        }else{
        a = 0;//取消
        }
$.ajax({  
		       type:"POST",  
		       data:{funid:id,done:a,versionId:versionId,funIdList:funIdList
		       },
		       url:"${pageContext.request.contextPath}/installVersion/saveFunction",  
		       success:function(data){  
		     list=data.list;
		     funNameList=data.funNameList;
		     $("#funIdList1").attr("value",list);
		     $("#funNameList").attr("value",funNameList);
		       }
		       });
		       }
function querySomeFunList(){
  $("#pageno").attr("value",1);
document.getElementById("msg3").innerHTML = "";
var funname=$("#funname").val();
var testtype=$("#typetest").find("option:selected").text(); 
//var testcode=$("#testcode").find("option:selected").text();
var testcode=$("#testcode").find("option:selected").val();
alert(testcode);
var versionId=$("#versionId").val();
var pagesize=$("#pagesize").attr("value");
//var pagenumber=$("#pagenumber").attr("value");
var pagenumber=1;//页面信息
if( testtype!="请选择"&&testcode==""){
	document.getElementById("msg1").innerHTML = "<font color='red'>该测试类别没有具体测试类型</font>";
	  $("#pgno").hide();
	  $("#funtable").hide();
	  $("#pageutil").hide();
	return false;
}
$.ajax({
	    				type:"post",
	    			    url: "${pageContext.request.contextPath}/installVersion/querySomeFunListBycriteria",
	    			    data:{pagesize:pagesize,pagenumber:pagenumber,funname:funname,testcode:testcode,versionid:versionId},
	    			    success:function(data){
	    		   $("#totalpagecount").attr("value",data.page.totalPageCount);
		       $("#totalcount").attr("value",data.page.totalCount);
		        $("#funIdList").attr("value",data.FunIdList);
		       $("#funIdList1").attr("value",data.FunIdList);
		       list=data.funlist;
	    			    pagecount=data.page.totalPageCount;
		       $("#pagenumber").empty();
		       for(var i=1;i<=pagecount;i++){
	     	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
	     	    		  } 	 
	     	    		  if(list.length>0){
	     	    		  $("#pgno").show();
	     	    		  $("#pageutil").show();
	    			     $("#funtable").empty();
	    			     $("#pagebottom").empty();
		              for(var i=0;i<list.length;i++){        
         $("#funtable").append("<tr><td><input name='"+list[i].id+"' type='checkbox' id='function' value='"+list[i].id+"'    onclick='checkboxOnclick("+list[i].id+")'><span>"+list[i].name+"</span></td>");
         }              $("#funtable").show();
		            	 $("tr:even").addClass("even");
                          $("tr:odd").addClass("odd");
		                  var   s=$("#funIdList1").val();
                         FunIdList= s.split(",");
		              $.each(FunIdList, function (index, item) {
		            	   	$(":checkbox").each(function(){
		            	        if ($(this).val() == item) {
		            	            $(this).attr("checked",true);
		            	        }
		            	    });
		            	});
	    			    }
	    			 else{
	    			
	    			      $("#pgno").hide();
	    			      $("#funtable").hide();
	    			      $("#pageutil").hide();
	    			       $("#pagebottom").show();
	    			       $("#pagebottom").html("<font color='red'>没有找到符合条件的功能</font>");
	    			 }
	    			    }
	    			    
	    			    });

}
function getFunByCriteria(){
document.getElementById("msg3").innerHTML = "";//注意
$("#pageno").attr("value",1);
	$("#pagebottom").empty();
var funname=$("#funname").val();
var testtype=$("#typetest").find("option:selected").text(); 
var testcode=$("#testcode").find("option:selected").text();
var versionId=$("#versionId").val();
var pagesize=$("#pagesize").attr("value");
var pagenumber=$("#pagenumber").attr("value");//页面信息
$.ajax({
	    				type:"post",
	    			    url: "${pageContext.request.contextPath}/installVersion/querySomeFunListBycriteria",
	    			    data:{pagesize:pagesize,pagenumber:pagenumber,funname:funname,testcode:testcode,versionid:versionId},
	    			    success:function(data){
	    		   $("#totalpagecount").attr("value",data.page.totalPageCount);
		       $("#totalcount").attr("value",data.page.totalCount);
		        $("#funIdList").attr("value",data.FunIdList);
		       $("#funIdList1").attr("value",data.FunIdList);
		       list=data.funlist;
	    			    pagecount=data.page.totalPageCount;
		       $("#pagenumber").empty();
		       for(var i=1;i<=pagecount;i++){
	     	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
	     	    		  } 	 
	     	    		  $("#funtable").empty();
		              for(var i=0;i<list.length;i++){        
         $("#funtable").append("<tr><td><input name='"+list[i].id+"' type='checkbox' id='function' value='"+list[i].id+"'    onclick='checkboxOnclick("+list[i].id+")'><span>"+list[i].name+"</span></td>");
         }              $("#funtable").show();
		            	 $("tr:even").addClass("even");
                          $("tr:odd").addClass("odd");
		                  var   s=$("#funIdList1").val();
                         FunIdList= s.split(",");
		              $.each(FunIdList, function (index, item) {
		            	   	$(":checkbox").each(function(){
		            	        if ($(this).val() == item) {
		            	            $(this).attr("checked",true);
		            	        }
		            	    });
		            	});
	    			    
	    			    }
	    			    
	    			    });

}


function firstpage(){
document.getElementById("msg3").innerHTML = "";//注意
$("#pagebottom").empty();
var funname=$("#funname").val();
var testtype=$("#typetest").find("option:selected").text(); 
var testcode=$("#testcode").find("option:selected").text();
var versionId=$("#versionId").val();
var pagesize=$("#pagesize").attr("value");
	var pageno=1;
	    			if(pageno==1){
	    			$("#pagebottom").html("<font color='red'>已到第一页</font>");
	    			}
	    			$("#pageno").attr("value",1);
	    			var pagenumber=$("#pageno").val();//页面信息
$.ajax({
	    				type:"post",
	    			    url: "${pageContext.request.contextPath}/installVersion/querySomeFunListBycriteria",
	    			    data:{pagesize:pagesize,pagenumber:pagenumber,funname:funname,testcode:testcode,versionid:versionId},
	    			    success:function(data){
	    		   $("#totalpagecount").attr("value",data.page.totalPageCount);
		       $("#totalcount").attr("value",data.page.totalCount);
		        $("#funIdList").attr("value",data.FunIdList);
		       $("#funIdList1").attr("value",data.FunIdList);
		       list=data.funlist;
	    			    pagecount=data.page.totalPageCount;
		       $("#pagenumber").empty();
		       for(var i=1;i<=pagecount;i++){
	     	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
	     	    		  } 	 
	     	    		  $("#funtable").empty();
		              for(var i=0;i<list.length;i++){        
         $("#funtable").append("<tr><td><input name='"+list[i].id+"' type='checkbox' id='function' value='"+list[i].id+"'    onclick='checkboxOnclick("+list[i].id+")'><span>"+list[i].name+"</span></td>");
         }              $("#funtable").show();
		            	 $("tr:even").addClass("even");
                          $("tr:odd").addClass("odd");
		                  var   s=$("#funIdList1").val();
                         FunIdList= s.split(",");
		              $.each(FunIdList, function (index, item) {
		            	   	$(":checkbox").each(function(){
		            	        if ($(this).val() == item) {
		            	            $(this).attr("checked",true);
		            	        }
		            	    });
		            	});
	    			    
	    			    }
	    			    
	    			    });

}
function forwardpage(){
document.getElementById("msg3").innerHTML = "";//注意
$("#pagebottom").empty();
var funname=$("#funname").val();
var testtype=$("#typetest").find("option:selected").text(); 
var testcode=$("#testcode").find("option:selected").text();
var versionId=$("#versionId").val();
var pagesize=$("#pagesize").attr("value");
	var pageNo=$("#pageno").val();
	    			var pageno=pageNo*1-1;
	    			if(pageno==0){
	    			$("#pagebottom").html("<font color='red'>已到第一页</font>");
	    			return;
	    			}
	    			$("#pageno").attr("value",pageno);
	    			var pagenumber=$("#pageno").val();//页面信息
$.ajax({
	    				type:"post",
	    			    url: "${pageContext.request.contextPath}/installVersion/querySomeFunListBycriteria",
	    			    data:{pagesize:pagesize,pagenumber:pagenumber,funname:funname,testcode:testcode,versionid:versionId},
	    			    success:function(data){
	    		   $("#totalpagecount").attr("value",data.page.totalPageCount);
		       $("#totalcount").attr("value",data.page.totalCount);
		        $("#funIdList").attr("value",data.FunIdList);
		       $("#funIdList1").attr("value",data.FunIdList);
		       list=data.funlist;
	    			    pagecount=data.page.totalPageCount;
		       $("#pagenumber").empty();
		       for(var i=1;i<=pagecount;i++){
	     	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
	     	    		  } 	 
	     	    		  $("#funtable").empty();
		              for(var i=0;i<list.length;i++){        
         $("#funtable").append("<tr><td><input name='"+list[i].id+"' type='checkbox' id='function' value='"+list[i].id+"'    onclick='checkboxOnclick("+list[i].id+")'><span>"+list[i].name+"</span></td>");
         }              $("#funtable").show();
		            	 $("tr:even").addClass("even");
                          $("tr:odd").addClass("odd");
		                  var   s=$("#funIdList1").val();
                         FunIdList= s.split(",");
		              $.each(FunIdList, function (index, item) {
		            	   	$(":checkbox").each(function(){
		            	        if ($(this).val() == item) {
		            	            $(this).attr("checked",true);
		            	        }
		            	    });
		            	});
	    			    
	    			    }
	    			    
	    			    });

}

function nextpage(){
document.getElementById("msg3").innerHTML = "";
$("#pagebottom").empty();
var funname=$("#funname").val();
var testtype=$("#typetest").find("option:selected").text(); 
var testcode=$("#testcode").find("option:selected").text();
var versionId=$("#versionId").val();
var pagesize=$("#pagesize").attr("value");
var pageNo=$("#pageno").val();
var totalpagecount=$("#totalpagecount").val();
	    			var pageno=pageNo*1+1;
	    			if(totalpagecount<pageno){
	    			$("#pagebottom").html("<font color='red'>已到最后一页</font>");
	    			return;
	    			}
	    			$("#pageno").attr("value",pageno);
	    			var pagenumber=$("#pageno").val();//页面信息
$.ajax({
	    				type:"post",
	    			    url: "${pageContext.request.contextPath}/installVersion/querySomeFunListBycriteria",
	    			    data:{pagesize:pagesize,pagenumber:pagenumber,funname:funname,testcode:testcode,versionid:versionId},
	    			    success:function(data){
	    		   $("#totalpagecount").attr("value",data.page.totalPageCount);
		       $("#totalcount").attr("value",data.page.totalCount);
		        $("#funIdList").attr("value",data.FunIdList);
		       $("#funIdList1").attr("value",data.FunIdList);
		       list=data.funlist;
	    			    pagecount=data.page.totalPageCount;
		       $("#pagenumber").empty();
		       for(var i=1;i<=pagecount;i++){
	     	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
	     	    		  } 	 
	     	    		  $("#funtable").empty();
		              for(var i=0;i<list.length;i++){        
         $("#funtable").append("<tr><td><input name='"+list[i].id+"' type='checkbox' id='function' value='"+list[i].id+"'    onclick='checkboxOnclick("+list[i].id+")'><span>"+list[i].name+"</span></td>");
         }              $("#funtable").show();
		            	$("tr:even").addClass("even");
                         $("tr:odd").addClass("odd");
		                  var   s=$("#funIdList1").val();
                         FunIdList= s.split(",");
		              $.each(FunIdList, function (index, item) {
		            	   	$(":checkbox").each(function(){
		            	        if ($(this).val() == item) {
		            	            $(this).attr("checked",true);
		            	        }
		            	    });
		            	});
	    			    
	    			    }
	    			    
	    			    });

}

function lastpage(){
document.getElementById("msg3").innerHTML = "";
$("#pagebottom").empty();
var funname=$("#funname").val();
var testtype=$("#typetest").find("option:selected").text(); 
var testcode=$("#testcode").find("option:selected").text();
var versionId=$("#versionId").val();
var pagesize=$("#pagesize").attr("value");
	var pagenumber=$("#pageno").val();
	          var totalpagecount=$("#totalpagecount").val();
	    			$("#pageno").attr("value",totalpagecount);
	    			var pagenumber=$("#pageno").val();
	    			$("#pagebottom").html("<font color='red'>已到最后一页</font>");//页面信息
$.ajax({
	    				type:"post",
	    			    url: "${pageContext.request.contextPath}/installVersion/querySomeFunListBycriteria",
	    			    data:{pagesize:pagesize,pagenumber:pagenumber,funname:funname,testcode:testcode,versionid:versionId},
	    			    success:function(data){
	    		   $("#totalpagecount").attr("value",data.page.totalPageCount);
		       $("#totalcount").attr("value",data.page.totalCount);
		        $("#funIdList").attr("value",data.FunIdList);
		       $("#funIdList1").attr("value",data.FunIdList);
		       list=data.funlist;
	    			    pagecount=data.page.totalPageCount;
		       $("#pagenumber").empty();
		       for(var i=1;i<=pagecount;i++){
	     	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
	     	    		  } 	 
	     	    		  $("#funtable").empty();
		              for(var i=0;i<list.length;i++){        
         $("#funtable").append("<tr><td><input name='"+list[i].id+"' type='checkbox' id='function' value='"+list[i].id+"'    onclick='checkboxOnclick("+list[i].id+")'><span>"+list[i].name+"</span></td>");
         }              $("#funtable").show();
		            	 $("tr:even").addClass("even");
                          $("tr:odd").addClass("odd");
		                  var   s=$("#funIdList1").val();
                         FunIdList= s.split(",");
		              $.each(FunIdList, function (index, item) {
		            	   	$(":checkbox").each(function(){
		            	        if ($(this).val() == item) {
		            	            $(this).attr("checked",true);
		            	        }
		            	    });
		            	});
	    			    
	    			    }
	    			    
	    			    });

}

function toSelectedPage(){
document.getElementById("msg3").innerHTML = "";
$("#pagebottom").empty();
var funname=$("#funname").val();
var testtype=$("#typetest").find("option:selected").text(); 
var testcode=$("#testcode").find("option:selected").text();
var versionId=$("#versionId").val();
var pagesize=$("#pagesize").attr("value");
	 var pagenumber=$("#pagenumber").attr("value");
	           	$("#pageno").attr("value",pagenumber);//页面信息
$.ajax({
	    				type:"post",
	    			    url: "${pageContext.request.contextPath}/installVersion/querySomeFunListBycriteria",
	    			    data:{pagesize:pagesize,pagenumber:pagenumber,funname:funname,testcode:testcode,versionid:versionId},
	    			    success:function(data){
	    		   $("#totalpagecount").attr("value",data.page.totalPageCount);
		       $("#totalcount").attr("value",data.page.totalCount);
		       $("#funIdList").attr("value",data.FunIdList);
		       $("#funIdList1").attr("value",data.FunIdList);
		       list=data.funlist;
	    			    pagecount=data.page.totalPageCount;
		    //   $("#pagenumber").empty();
		      /* for(var i=1;i<=pagecount;i++){
	     	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
	     	    		  } 	 */
	     	    		  $("#funtable").empty();
		              for(var i=0;i<list.length;i++){        
         $("#funtable").append("<tr><td><input name='"+list[i].id+"' type='checkbox' id='function' value='"+list[i].id+"'    onclick='checkboxOnclick("+list[i].id+")'><span>"+list[i].name+"</span></td>");
         }              $("#funtable").show();
		            	$("tr:even").addClass("even");
                         $("tr:odd").addClass("odd");
		                  var   s=$("#funIdList1").val();
                         FunIdList= s.split(",");
		              $.each(FunIdList, function (index, item) {
		            	   	$(":checkbox").each(function(){
		            	        if ($(this).val() == item) {
		            	            $(this).attr("checked",true);
		            	        }
		            	    });
		            	});
	    			    
	    			    }
	    			    
	    			    });

}




$(document).ready(function(){
 //隔行表色
 $("tr:even").addClass("even");
 $("tr:odd").addClass("odd");

});




function onsubmit11(){
    $("#pagebottom").hide();
	var chk_value=$("#funIdList1").val();
    /*$('input[name="function"]:checked').each(function(){//遍历每一个名字为interest的复选框，其中选中的执行函数  
    chk_value.push($(this).val());//将选中的值添加到数组chk_value中  
    });*/
    if(chk_value.length==0){
		 document.getElementById("msg3").innerHTML = "<font color='red'>您未选择任何对应功能</font>";
		 return false;
	 }
	 if(chk_value.length!=0){
		 document.getElementById("msg3").innerHTML = "";
		
	 }
	  /* var chk_value1 =[];//定义一个数组  
     $('input[name="function"]:checked').each(function(){//遍历每一个名字为interest的复选框，其中选中的执行函数  
     chk_value1.push($(this).next().text());//将选中的值添加到数组chk_value中  
     });*/
	 window.opener.document.getElementById("funList1").value=$("#funIdList1").val();//txtJDRY是要显示在父页面中那个文本框里的文本框的id  
     if($("#funNameList").val()!="")
     {
     window.opener.document.getElementById("funList2").value=$("#funNameList").val();
     }
	// window.returnValue=chk_value;
	 
   window.close();
}
</script>
<style type="text/css">
.even{
 background-color:#ccc;
}
.odd{
 background-color:white;
}
.selected{
 background-color:#FF6;
}
.se{
 background-color:#666;
}
a{text-decoration: none;}
</style>
</head>
<body>
<form name="myform">
<input type="hidden" name="versionId"  id="versionId" value="">
<input type="hidden" name="AllFunList"  id="AllFunList" value="">
<input type="hidden" name="funIdList"  id="funIdList" value="">
<input type="hidden" name="funIdList1"  id="funIdList1" value="">
<input type="hidden" name="funNameList"  id="funNameList" value="">
功能名称<input type="text" name="funname" id="funname"  size="10px"></br>
<td>
<label>测试类别</label>
<select name="typetest" id="typetest"  onchange="selectChecked();" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg3').innerHTML=''"/>
<option value="" selected="selected">请选择</option>

</select>
<div style="display: inline" id="msg1"></div>
</td>
</br>
<td>
<label>测试类型</label>
<select name="testcode" id="testcode" />
<option value="" selected="selected">请选择</option>
  
</select>
<div style="display: inline" id="msg2"></div>
</td>
</br>
<input type="button" value="查询" onclick="querySomeFunList();"/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="提交" onclick="onsubmit11();"/><div style="display: inline" id="msg3"></div>
</br>
<div id="pgno">当前显示第 <input class="blue" id="pageno" type="button" value=1>页</div>
<table id="funtable" class="funtable">

</table>
   </form>
   <div id="pagebottom"> </div>
   <div id="pageutil" class="pageutil">
   <td>共有<input class="blue" id="totalcount" type="button" value="${page.totalCount}">条程序</td>
    <td>每页显示<select id="pagesize"  onchange="getFunByCriteria()">
       <option selected="selected">10</option>
    <option>20</option>
    <option>50</option>
    <option>100</option>
    </select>条
    </br>
     共有 <input class="blue" id="totalpagecount" type="button">页 
    
         跳转  <select id="pagenumber" onchange="toSelectedPage()">
    </select>
      页
    </td>
    </br>
     <!-- 首页按钮，跳转到首页 -->
    <td>
    <c:if test="${page.pageNow <= 1 }"></c:if>
  
    <a href="javascript:firstpage()">首页</a>
  
   
      <a href="javascript:forwardpage()">上一页</a>
  
   

   
    <a href="javascript:nextpage()">下一页</a>

   
  
     <a href="javascript:lastpage()">末页</a>
 </td>
 </div>
   
   
   
   
</body>
</html>