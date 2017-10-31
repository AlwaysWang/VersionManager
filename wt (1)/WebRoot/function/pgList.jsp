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
<title>程序列表</title>
<script type="text/javascript">
window.onload=function(){ 
   var form = document.forms[0];  
   var funid= window.opener.document.getElementById('funid').value;
   document.forms.myform.funid.value = funid;
$.ajax({  
		       type:"POST", 
		      data:{funid:funid },
		       url:"${pageContext.request.contextPath}/function/showPgList", 
		       success:function(data){
		         $("#totalpagecount").attr("value",data.page.totalPageCount);
		       $("#totalcount").attr("value",data.page.totalCount);
		       $("#pgIdList").attr("value",data.pgIdList);
		       $("#pgIdList1").attr("value",data.pgIdList);
		       list=data.pgList;
		       IdAllList=data.pgIdAllList;
		       pagecount=data.page.totalPageCount;
		       $("#pagenumber").empty();
		       for(var i=1;i<=pagecount;i++){
	     	    		 $("#pagenumber").append("<option vlue=\""+i+"\">"+i+"</ooption>");
	     	    		  } 	 
		              for(var i=0;i<list.length;i++){ 
         $("#pgtable").append("<tr><td><input name='"+list[i].id+"', type='checkbox' ,id='program', value='"+list[i].id+"', onclick='checkboxOnclick("+list[i].id+")'><span>"+list[i].pgName+"</span></td>")
		              }
		              $("tr:even").addClass("even");
                      $("tr:odd").addClass("odd");
		              pgIdList=data.pgIdList;  
		              var msg=eval("("+pgIdList+")");
		              $.each(pgIdList, function (index, item) {
		           
		            	   	$(":checkbox").each(function(){
		            	        if ($(this).val() == item) {
		            	            $(this).attr("checked",true);
		            	        }
		            	    });
		            	}); 
		    
		       }         
		});
		
}
function checkboxOnclick(id){
var pgIdList=document.getElementById("pgIdList1").value;
var funid= document.getElementById("funid").value;
var check = document.getElementsByName(id)[0];
 var a = 1;
  if(check.checked){
        a = 1;//添加
        }else{
        a = 0;//取消
        }
$.ajax({  
		       type:"POST",  
		       data:{pgid:id,done:a,funid:funid,pgIdList:pgIdList
		       },
		       url:"${pageContext.request.contextPath}/function/saveProgram",  
		       success:function(data){  
		     list=data.list;
		     pgNameList=data.pgNameList;
		     $("#pgIdList1").attr("value",list);
		     $("#pgNameList").attr("value",pgNameList);
		       }
		       });
		       }


function onsubmit11(){
$("#pagebottom").hide();
   var chk_value=$("#pgIdList1").val();
    if(chk_value==""){
		 document.getElementById("msg3").innerHTML = "<font color='red'>您未选择任何对应程序</font>";
		 return false;
	 }
	 if(chk_value.length!=0){
		 document.getElementById("msg3").innerHTML = "";
	 }
	 window.opener.document.getElementById("programlist1").value=$("#pgIdList1").val();
	 if($("#pgNameList").val()!=""){
	 window.opener.document.getElementById("programlist2").value=$("#pgNameList").val();
	}
   window.close();
}
function querySomePgList(){
document.getElementById("msg3").innerHTML = "";
var pgName=document.getElementById("pgName").value;
var pagesize=$("#pagesize").attr("value");
//var pagenumber=$("#pagenumber").attr("value");
var pagenumber=1;
var funid=document.getElementById("funid").value;
$.ajax({
	    				type:"post",
	    			    url: "${pageContext.request.contextPath}/function/querySomePgList",
	    			    data:{pagesize:pagesize,pagenumber:pagenumber,pgName:pgName,funid:funid},
	    			    success:function(value){
	    			     $("#totalpagecount").attr("value",value.page.totalPageCount);
		                 $("#totalcount").attr("value",value.page.totalCount);
		                 $("#pgIdList").attr("value",value.pgIdList);
	    			     list=value.somepglist;
	    			     pagecount=value.page.totalPageCount;
	    			     $("#pagenumber").empty();
	        		  for(var i=1;i<=pagecount;i++){
	     	    		 $("#pagenumber").append("<option value=\""+i+"\">"+i+"</ooption>");
	     	    		  } 
	     	    		  if(list.length>0){
	     	    		  $("#pgno").show();
	     	    		  $("#pageutil").show();
	    			     $("#pgtable").empty();
	    			     $("#pagebottom").empty();
	    			       for(var i=0;i<list.length;i++){ 
	    			     
         $("#pgtable").append("<tr><td><input name='"+list[i].id+"', type='checkbox' ,id='program', value='"+list[i].id+"', onclick='checkboxOnclick("+list[i].id+")'><span>"+list[i].pgName+"</span></td>");
         }
          $("#pgtable").show();
		              $("tr:even").addClass("even");
                      $("tr:odd").addClass("odd");
		           
		                  var   s=$("#pgIdList1").val();
                         pgIdList= s.split(",");
		              //var msg=eval("("+pgIdList+")");
		              $.each(pgIdList, function (index, item) {
		            	   	$(":checkbox").each(function(){
		            	        if ($(this).val() == item) {
		            	            $(this).attr("checked",true);
		            	        }
		            	    });
	    			      });
	    			      }
	    			      else{
	    			      $("#pgno").hide();
	    			      $("#pgtable").hide();
	    			      $("#pageutil").hide();
	    			     // $("#pagebottom").html("没有找到符合条件的程序");
	    			     	       $("#pagebottom").show();
	    			      $("#pagebottom").html("<font color='red'>没有找到符合条件的程序</font>");
	    			      
	    			      }
	    			    }
	    			    });
}
  function getFunByCriteria(){
  	$("#pagebottom").empty();
  document.getElementById("msg3").innerHTML = "";
  $("#pageno").attr("value",1);
  var pagesize=$("#pagesize").val();
 var totalcount=$("#totalcount").val();
var pagenumber=$("#pageno").val();
var pgName=document.getElementById("pgName").value;
var funid=document.getElementById("funid").value;
  $.ajax({
	    				type:"post",
	    			    url: "${pageContext.request.contextPath}/function/querySomePgList",
	    			    data:{pagesize:pagesize,pagenumber:pagenumber,totalcount:totalcount,pgName:pgName,funid:funid},
	    			    success:function(value){
     		     $("#totalpagecount").attr("value",value.page.totalPageCount);
		                 $("#totalcount").attr("value",value.page.totalCount);
		                 $("#pgIdList").attr("value",value.pgIdList);
	    			     list=value.somepglist;
	    			     pagecount=value.page.totalPageCount;
	    			     $("#pagenumber").empty();
	        		  for(var i=1;i<=pagecount;i++){
	     	    		 $("#pagenumber").append("<option value=\""+i+"\">"+i+"</ooption>");
	     	    		  } 	 
	    			     $("#pgtable").empty();
	    			       for(var i=0;i<list.length;i++){ 
         $("#pgtable").append("<tr><td><input name='"+list[i].id+"', type='checkbox' ,id='program', value='"+list[i].id+"', onclick='checkboxOnclick("+list[i].id+")'><span>"+list[i].pgName+"</span></td>");
         }
		              $("tr:even").addClass("even");
                      $("tr:odd").addClass("odd");
		           
		              pgIdList=value.pgIdList;  
		              var msg=eval("("+pgIdList+")");
		              $.each(pgIdList, function (index, item) {
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
	document.getElementById("msg3").innerHTML = "";
	$("#pagebottom").empty();
	 var  pgIdList=document.getElementById("pgIdList1").value;
	        var funid=document.getElementById("funid").value;
	          var pgName=document.getElementById("pgName").value;
	           var totalcount=$("#totalcount").val();
	             var totalpagecount=$("#totalpagecount").val();
	    			var pagesize=$("#pagesize").attr("value");
	    			var pageno=1;
	    			if(pageno==1){
	    			$("#pagebottom").html("<font color='red'>已到第一页</font>");
	    			}
	    			$("#pageno").attr("value",1);
	    			var pagenumber=$("#pageno").val();
	    $.ajax({
	    				type:"post",
	    			    url: "${pageContext.request.contextPath}/function/querySomePgList",
	    			    data:{pagesize:pagesize,pagenumber:pagenumber,totalcount:totalcount,pgName:pgName,funid:funid},
	    			    success:function(value){
     		     $("#totalpagecount").attr("value",value.page.totalPageCount);
		                 $("#totalcount").attr("value",value.page.totalCount);
		                 $("#pgIdList").attr("value",value.pgIdList);
	    			     list=value.somepglist;
	    			     pagecount=value.page.totalPageCount;
	    			     $("#pagenumber").empty();
	        		  for(var i=1;i<=pagecount;i++){
	     	    		 $("#pagenumber").append("<option value=\""+i+"\">"+i+"</ooption>");
	     	    		  } 	 
	    			     $("#pgtable").empty();
	    			       for(var i=0;i<list.length;i++){ 
         $("#pgtable").append("<tr><td><input name='"+list[i].id+"', type='checkbox' ,id='program', value='"+list[i].id+"', onclick='checkboxOnclick("+list[i].id+")'><span>"+list[i].pgName+"</span></td>");
         }
		              $("tr:even").addClass("even");
                      $("tr:odd").addClass("odd");
		       
		             // pgIdList=value.pgIdList; 
		             //pgIdList=value.pgIdList1;
		          //   alert(pgIdList);
             var   s=$("#pgIdList1").val();
             pgIdList= s.split(",");
		  // var  pgIdList=[1283,1285,1284,1282,1280];
		              $.each(pgIdList, function (index, item) {
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
		document.getElementById("msg3").innerHTML = "";
		$("#pagebottom").empty();
		var funid=document.getElementById("funid").value;
		         var pgName=document.getElementById("pgName").value;
		       var totalcount=$("#totalcount").val();
	             var totalpagecount=$("#totalpagecount").val();
	    			var pagesize=$("#pagesize").attr("value");
	    			var pageNo=$("#pageno").val();
	    			var pageno=pageNo*1-1;
	    			if(pageno==0){
	    			$("#pagebottom").html("<font color='red'>已到第一页</font>");
	    			return;
	    			}
	    			$("#pageno").attr("value",pageno);
	    			var pagenumber=$("#pageno").val();
	    $.ajax({
	    				type:"post",
	    			    url: "${pageContext.request.contextPath}/function/querySomePgList",
	    			    data:{pagesize:pagesize,pagenumber:pagenumber,totalcount:totalcount,pgName:pgName,funid:funid},
	    			    success:function(value){
     		     $("#totalpagecount").attr("value",value.page.totalPageCount);
		                 $("#totalcount").attr("value",value.page.totalCount);
		                 $("#pgIdList").attr("value",value.pgIdList);
	    			     list=value.somepglist;
	    			     pagecount=value.page.totalPageCount;
	    			     $("#pagenumber").empty();
	        		  for(var i=1;i<=pagecount;i++){
	     	    		 $("#pagenumber").append("<option value=\""+i+"\">"+i+"</ooption>");
	     	    		  } 	 
	     	    		  
	     	    
	    			     $("#pgtable").empty();
	    			       for(var i=0;i<list.length;i++){ 
         $("#pgtable").append("<tr><td><input name='"+list[i].id+"', type='checkbox' ,id='program', value='"+list[i].id+"', onclick='checkboxOnclick("+list[i].id+")'><span>"+list[i].pgName+"</span></td>");
         }
		              $("tr:even").addClass("even");
                      $("tr:odd").addClass("odd");
		           
		            //  pgIdList=value.pgIdList;  
		            //  var msg=eval("("+pgIdList+")");
		                 var   s=$("#pgIdList1").val();
                   pgIdList= s.split(",");
		              $.each(pgIdList, function (index, item) {
		            	   	$(":checkbox").each(function(){
		            	        if ($(this).val() == item) {
		            	            $(this).attr("checked",true);
		            	        }
		            	    });
	    			      });
	    			      
	    			      //alert(list.length);
	    			   
  }
});	
		   			
	}
	function nextpage(){
	document.getElementById("msg3").innerHTML = "";
	$("#pagebottom").empty();
	var funid=document.getElementById("funid").value;
	           var pgName=document.getElementById("pgName").value;
	            var totalcount=$("#totalcount").val();
	             var totalpagecount=$("#totalpagecount").val();
	    			var pagesize=$("#pagesize").attr("value");
	    			var pageNo=$("#pageno").val();
	    			var pageno=pageNo*1+1;
	    			if(totalpagecount<pageno){
	    			$("#pagebottom").html("<font color='red'>已到最后一页</font>");
	    			return;
	    			}
	    			$("#pageno").attr("value",pageno);
	    			var pagenumber=$("#pageno").val();
	    $.ajax({
	    				type:"post",
	    			    url: "${pageContext.request.contextPath}/function/querySomePgList",
	    			    data:{pagesize:pagesize,pagenumber:pagenumber,totalcount:totalcount,pgName:pgName,funid:funid},
	    			    success:function(value){
	    			   
     		     $("#totalpagecount").attr("value",value.page.totalPageCount);
		                 $("#totalcount").attr("value",value.page.totalCount);
		                 $("#pgIdList").attr("value",value.pgIdList);
	    			     list=value.somepglist;
	    			     pagecount=value.page.totalPageCount;
	    			     $("#pagenumber").empty();
	        		  for(var i=1;i<=pagecount;i++){
	     	    		 $("#pagenumber").append("<option value=\""+i+"\">"+i+"</ooption>");
	     	    		  } 	 
	    			     $("#pgtable").empty();
	    			       for(var i=0;i<list.length;i++){ 
         $("#pgtable").append("<tr><td><input name='"+list[i].id+"', type='checkbox' ,id='program', value='"+list[i].id+"', onclick='checkboxOnclick("+list[i].id+")'><span>"+list[i].pgName+"</span></td>");
         }
		              $("tr:even").addClass("even");
                      $("tr:odd").addClass("odd");
		           
		              //pgIdList=value.pgIdList;  
		              //var msg=eval("("+pgIdList+")");
		                   var   s=$("#pgIdList1").val();
                         pgIdList= s.split(",");
		              $.each(pgIdList, function (index, item) {
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
	var funid=document.getElementById("funid").value;
	           var pgName=document.getElementById("pgName").value;
	            var totalcount=$("#totalcount").val();
	           	   var totalpagecount=$("#totalpagecount").val();
	           	$("#pageno").attr("value",totalpagecount);
	    			var pagesize=$("#pagesize").attr("value");
	    			var pagenumber=$("#pageno").val();
	    			$("#pageno").attr("value",totalpagecount);
	    			var pagenumber=$("#pageno").val();
	    			$("#pagebottom").html("<font color='red'>已到最后一页</font>");
	    $.ajax({
	    				type:"post",
	    			    url: "${pageContext.request.contextPath}/function/querySomePgList",
	    			    data:{pagesize:pagesize,pagenumber:pagenumber,totalcount:totalcount,pgName:pgName,funid:funid},
	    			    success:function(value){
	    			   
     		     $("#totalpagecount").attr("value",value.page.totalPageCount);
		                 $("#totalcount").attr("value",value.page.totalCount);
		                 $("#pgIdList").attr("value",value.pgIdList);
	    			     list=value.somepglist;
	    			     pagecount=value.page.totalPageCount;
	    			     $("#pagenumber").empty();
	        		  for(var i=1;i<=pagecount;i++){
	     	    		 $("#pagenumber").append("<option value=\""+i+"\">"+i+"</ooption>");
	     	    		  } 	 
	    			     $("#pgtable").empty();
	    			       for(var i=0;i<list.length;i++){ 
         $("#pgtable").append("<tr><td><input name='"+list[i].id+"', type='checkbox' ,id='program', value='"+list[i].id+"', onclick='checkboxOnclick("+list[i].id+")'><span>"+list[i].pgName+"</span></td>");
         }
		              $("tr:even").addClass("even");
                      $("tr:odd").addClass("odd");
		           
		             // pgIdList=value.pgIdList;  
		            //  var msg=eval("("+pgIdList+")");
		                 var   s=$("#pgIdList1").val();
                        pgIdList= s.split(",");
		              $.each(pgIdList, function (index, item) {
		            	   	$(":checkbox").each(function(){
		            	        if ($(this).val() == item) {
		            	            $(this).attr("checked",true);
		            	        }
		            	    });
	    			      });
  }
});			   			
	}
	function  toSelectedPage(){
	document.getElementById("msg3").innerHTML = "";
	$("#pagebottom").empty();
	var funid=document.getElementById("funid").value;
	           var pgName=document.getElementById("pgName").value;
	            var totalcount=$("#totalcount").val();
	           	   var totalpagecount=$("#totalpagecount").val();
	           	   var pagenumber=$("#pagenumber").attr("value");
	           	$("#pageno").attr("value",pagenumber);
	    			var pagesize=$("#pagesize").attr("value");	
	    $.ajax({
	    				type:"post",
	    			    url: "${pageContext.request.contextPath}/function/querySomePgList",
	    			    data:{pagesize:pagesize,pagenumber:pagenumber,totalcount:totalcount,pgName:pgName,funid:funid},
	    			    success:function(value){
	    			   
     		     $("#totalpagecount").attr("value",value.page.totalPageCount);
		                 $("#totalcount").attr("value",value.page.totalCount);
		                 $("#pgIdList").attr("value",value.pgIdList);
	    			     list=value.somepglist;
	    			     pagecount=value.page.totalPageCount;
	    			     /*$("#pagenumber").empty();
	        		  for(var i=1;i<=pagecount;i++){
	     	    		 $("#pagenumber").append("<option value=\""+i+"\">"+i+"</ooption>");
	     	    		  } 	 */
	    			     $("#pgtable").empty();
	    			       for(var i=0;i<list.length;i++){ 
         $("#pgtable").append("<tr><td><input name='"+list[i].id+"', type='checkbox' ,id='program', value='"+list[i].id+"', onclick='checkboxOnclick("+list[i].id+")'><span>"+list[i].pgName+"</span></td>");
         }
		              $("tr:even").addClass("even");
                      $("tr:odd").addClass("odd");
		           
		             // pgIdList=value.pgIdList;  
		            //  var msg=eval("("+pgIdList+")");
		                 var   s=$("#pgIdList1").val();
                        pgIdList= s.split(",");
		              $.each(pgIdList, function (index, item) {
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
  
 //点击变色 
 $("tr").toggle(
 function(){
   
  $(this).addClass("selected");
   
 },function (){
 
  $(this).removeClass("selected");
 
 }
 );
 
 //滑动变色
 $("tr").mouseover(function (){
  
 $(this).addClass("se"); 
  
 }).mouseout(function (){
  
 $(this).removeClass("se");
  
 });
});
</script>
<style type="text/css">
.even{
 background-color:#ccc;;
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
<input type="hidden" name="listsize"  id="listsize" value="${page.totalCount}" id="listsize">
<input type="hidden" name="pagenumber1" value="${page.pageNow}" id="pagenumber1">
<input type="hidden" name="pagetotalcount"  id="pagetotalcount" value="">
<input type="hidden" name="funid"  id="funid" value="">
<input type="hidden" name="pgList"  id="pgList" value="">
<input type="hidden" name="pgIdList"  id="pgIdList" value="">
<input   type="hidden" name="pgIdList1"  id="pgIdList1" value="">
<input   type="hidden" name="pgNameList"  id="pgNameList" value="">
<input type="text" name="pgName" id="pgName" size="10">&nbsp;&nbsp;&nbsp;<input type="button" value="查询" onclick="querySomePgList()">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="提交" onclick="onsubmit11();"/><div style="display: inline" id="msg3"></div>
</br>
<div id="pgno">当前显示第 <input class="blue" id="pageno" type="button" value=1>页</div>

<table id="pgtable" class="pgtable">
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