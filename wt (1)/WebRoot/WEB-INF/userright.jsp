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
<style type="text/css"">
  a:link{text-decoration:none; color:black;}</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript">
function confirm(){
	var isExist=document.getElementById("isExist").value;
	var form = document.forms[0]; 
	var username = document.getElementById("username").value;
     var usertype= document.getElementById("usertype").value;
     if(isExist=="true"){
    	 document.getElementById("msg1").innerHTML = "<font color='red'>该用户已经拥有权限</font>";
    	 return false;
     }
     if(isExist=="false"){
	if(username==""){
			document.getElementById("msg1").innerHTML = "<font color='red'>用户名称不能为空</font>";
			
			return false;
		}
	 if(username!=""){
			document.getElementById("msg1").innerHTML = "";
		}
	
		 if(usertype==""){
				document.getElementById("msg2").innerHTML = "<font color='red'>用户登录类别不能为空</font>";
				return false;
			}
		 if(usertype!=""){
				document.getElementById("msg2").innerHTML = "";
			
			}
		
	    var op=document.getElementById("username");
		var loginName=op.options[op.selectedIndex].text;
		var userId=	document.getElementById("usertype").value;
		var op1=document.getElementById("usertype");
		var userType=op1.options[op1.selectedIndex].text;
	
	
		//$("#down_center").hide();
	//var op=document.getElementById("username");
	//var loginName=op.options[op.selectedIndex].text;
	if(loginName!="请选择"){
	$.ajax({
		   type: "POST",
		   url: "${pageContext.request.contextPath}/user/queryRoleByRoleName",
		   data: {
			    "loginname":loginName,
		   },
		   success: function(value){
			   var msg=eval("("+value+")");
			   if(msg!=""){
					document.getElementById("msg1").innerHTML = "<font color='red'>该用户已经拥有权限</font>";
					document.getElementById("isExist").value="true";	
					
			   }
			   if(msg==""){
				   document.getElementById("msg1").innerHTML="";
				   document.getElementById("isExist").value="false";
			   }
		  } 
	});
	
	}
	
	
	
		$.ajax({
		   type: "POST",
		   url: "${pageContext.request.contextPath}/user/giveuserright",
		   data: {
			    "userid":userId,
			    "loginname":loginName,
			    "usertype":userType
		   },
		  //traditional:true,
		  //dateType:"json",
		   success: function(value){
			   document.getElementById("down_center").innerHTML = "用户系统权限添加成功！";
			   $("#down_center").show();
			   //$("#username").removeSelected();
			   //alert("hhh");
			   //window.location.reload();
		 
		  } 
		   
		});
     }
			}
	function giveOther(){
		window.location.reload();
	}
window.onload=function(){ 
    var opts=document.getElementById('usertype').options;
    var obj=new Object(),index=0;
    while(index<opts.length){
    	if(opts[index].text in obj) opts[index]=null;
    	else{
    		obj[opts[index].text]=opts[index].text;
    		index++;
    	}
    }
    obj=null;
}
function selected(){
	$("#down_center").hide();
	var op=document.getElementById("username");
	var loginName=op.options[op.selectedIndex].text;
	$.ajax({
		   type: "POST",
		   url: "${pageContext.request.contextPath}/user/queryRoleByRoleName",
		   data: {
			    "loginname":loginName,
		   },
		   success: function(value){
			   var msg=eval("("+value+")");
			   if(msg!=""){
					document.getElementById("msg1").innerHTML = "<font color='red'>该用户已经拥有权限</font>";
					document.getElementById("isExist").value="true";	
					
			   }
			   if(msg==""){
				   document.getElementById("msg1").innerHTML="";
				   document.getElementById("isExist").value="false";
			   }
		  } 
	});
	
	
}
</script>
<style type="text/css">
table.userright {
position:absolute;
 font-family: verdana,arial,sans-serif;
 font-size:20px;
 color:#333333;
 border-width: 1px;
 border-color: #999999;
 border-collapse: collapse;
 left:450px;
}
div.title{
position:relative;
 left:450px;
width:1100px;
}


a{text-decoration: none;}
#th{
color:red;}

#down_center{
position:relative;
 left:160px;
width:1100px;

}
</style>
<body style="overflow:-Scroll;overflow-x:hidden">
<input type="hidden" name="isExist" id="isExist" value="dd"> 
<div class="title"><h1>角色管理</h1></div>
<table class="userright">
<tr>
<td>请选择用户名称：<select id="username" name="username"  onchange="selected()"/>
<option selected="selected" value="">请选择</option>
<c:forEach var="user" items="${userinfoList}" varStatus="vs">
             <option value="${user.id}">${user.loginName}</option>
       </c:forEach>
</select>
<div style="display: inline" id="msg1"></div>
</td>
</tr>
<tr><td>请选择用户的登录类别：</td>
<td><select id="usertype"  name="usertype" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg2').innerHTML=''"/>
<option selected="selected" value="">请选择</option>
             <option value="超级管理员">超级管理员</option>
              <option value="管理员">管理员</option>
               <option value="普通用户">普通用户</option>
</select>
<div style="display: inline" id="msg2"></div></td>
</tr>
<tr><td></td></tr>
<tr><td></td></tr>
<tr><td></td></tr>
<tr><td></td></tr>
<!--  <tr><td>请选择用户可以使用的模块：</td></tr>

<c:forEach var="module" items="${moduleList}" varStatus="vs">
             <td><input name="module" type="checkbox" value="${module.mdId}"/>${module.mdName}</td>
             <c:if test="${vs.count % 2 == 0}">
</tr>
<tr>
</c:if>
       </c:forEach>
  <tr><td><input type="button" id="confirm" class="confirm" value="确定" onclick="confirm();"></td>
  </tr>     
        -->
        <tr><td><input type="button" id="confirm" class="confirm" value="确定" onclick="confirm();"></td>
        <td><input type="button" id="giveOther" class="giveOther" value="为其他用户赋值" onclick="giveOther();"></td>
  </tr> 
  <tr><td><a href="<%=basePath%>user/userright1" target="mainhome">点击此处查看角色权限</a></td></tr>
       </table>
<div id="down_center"></div>	
</body>
</html>