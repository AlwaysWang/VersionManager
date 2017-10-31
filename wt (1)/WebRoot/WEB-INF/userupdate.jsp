<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
        <%
String path =request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
System.out.println(basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript"  src="<%=basePath%>js/showdate.js"></script>
<script type="text/javascript" src="<%=basePath%>jquery/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>lhgcalendar/lhgcore.js"></script>
	<script type="text/javascript" src="<%=basePath%>lhgcalendar/lhgcalendar.js"></script>
	<script language="javascript" src="<%=basePath%>extjs/ext-base.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-all.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-lang-zh_CN.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
function doupdate(id){
$("#pagebottom").empty();
	 var form = document.forms[0]; 
	 var userName= document.getElementsByName("userName")[0].value;
	  var loginName= document.getElementsByName("loginName")[0].value;
	 var loginPass= document.getElementsByName("loginPass")[0].value;
	 var username=$("#username").val();
	 var loginname=$("#loginname").val();
	 var loginpass=$("#loginpass").val();
	  if(userName.trim().length==0){
		document.getElementById("msg1").innerHTML = "<font color='red'> 用户名称不能为空</font>";
		return false;
	}
		if(userName.length>25){
	document.getElementById("msg1").innerHTML = "<font color='red'> 用户名称字数不能超过25</font>";
		return false;
	}
	if( loginName.trim().length==0){
		document.getElementById("msg2").innerHTML = "<font color='red'>登陆名不能为空</font>";
		return false;
	}
	if(loginPass.trim().length==0){
		document.getElementById("msg3").innerHTML = "<font color='red'> 用户密码不能为空</font>";
		return false;
	}
		if(loginPass.length>25){
	document.getElementById("msg3").innerHTML = "<font color='red'> 用户密码字数不能超过25</font>";
		return false;
	}
	if(userName==username&&loginName==loginname&&loginPass==loginpass){
		document.getElementById("pagebottom").innerHTML = "您未做任何修改!";
		return;
	}
	 $.ajax({
	    	type:"post",
	        url: "${pageContext.request.contextPath}/user/doupdate",
	        data:{userId:id,userName:userName,loginName:loginName,loginPass:loginPass},
	        //dataType:"text",
	        success:function(value){
	        	document.getElementById("pagebottom").innerHTML = "用户更改成功";
	        }
	    });  
	 /*form.action = "${pageContext.request.contextPath}/user/doupdate"; 
	 document.forms.myform.id.value = id;
	 form.method = "post";  
     form.submit(); */
}
function backUserList(){
	 var form = document.forms[0]; 
	form.action = "${pageContext.request.contextPath}/user/userinfoquery/${userid}"; 
	form.method = "post";  
    form.submit(); 
	
}
function keypress1() //text输入长度处理   
{   
var reg = new RegExp("[\\u4E00-\\u9FFF]+","g");
var text1=document.getElementById("userName").value; 
var len=25-text1.length;   
var show="你还可以输入"+len+"个字";   
document.getElementById("msg1").innerText=show;  
if(parseInt(len)<0) {
document.getElementById("msg1").innerText="已超过最大字数";
return false;
}
}   
function keypress2() //text输入长度处理   
{   
var reg = new RegExp("[\\u4E00-\\u9FFF]+","g");
var text1=document.getElementById("loginPass").value; 
var len=25-text1.length;   
var show="你还可以输入"+len+"个字";   
document.getElementById("msg3").innerText=show;  
if(parseInt(len)<0) {
document.getElementById("msg3").innerText="已超过最大字数";
return false;
}
}   

</script>
<style type="text/css">
table.user {
position:absolute;
 font-family: verdana,arial,sans-serif;
 font-size:16px;
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

#pagebottom{
position:relative;
 left:250px;
width:1100px;
top:200px;

}
</style>
</head>
<body style="overflow:-Scroll;overflow-x:hidden">
<div class="title"><h2>用户维护</h2></div>
<form name="myform">
<input   type="hidden" name="id" value=""> 
<input   type="hidden" id="username" value="${requestScope.user.userName}"> 
<input   type="hidden" id="loginname" value="${requestScope.user.loginName}"> 
<input   type="hidden" id="loginpass" value="${requestScope.user.loginpass}"> 
<table class="user">
<tr>
<td>用户名称</td>
<td><input name="userName" id="userName" type="text" value="${requestScope.user.userName}" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg1').innerHTML=''"  />
<div style="display: inline" id="msg1"></div></td>
</tr>
<tr>
<tr>
<td>用户账号</td>
<td><input  readonly="true" name="loginName" type="text" value="${requestScope.user.loginName}" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg2').innerHTML=''"/>
<div style="display: inline" id="msg2"></div></td>
</tr>
<tr>
<tr>
<td>用户密码</td>
<td><input name="loginPass" type="password" id="loginPass" value="${requestScope.user.loginpass}"  onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg3').innerHTML=''" />
<div style="display: inline" id="msg3"></div></td>
</tr>
<!--  <td><input type="button" value="添加" onclick="window.location.href='<%=basePath%>user/userinfoprotect/insertuserinfo/'"></td> -->
<!-- <td><input type="button" value="修改"></td></tr>-->
<td><input type="button"  value="修改" onclick="doupdate('${ requestScope.user.id}')"></td>
<td><input type="button"  value="返回用户列表" onclick="backUserList()"></td>
</table>
</form>
<div id="pagebottom"></div>
</body>
</html>