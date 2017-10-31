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
<title>Insert title here</title>
<script type="text/javascript"  src="<%=basePath%>js/showdate.js"></script>
<script type="text/javascript" src="<%=basePath%>jquery/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>lhgcalendar/lhgcore.js"></script>
	<script type="text/javascript" src="<%=basePath%>lhgcalendar/lhgcalendar.js"></script>
	<script language="javascript" src="<%=basePath%>extjs/ext-base.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-all.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-lang-zh_CN.js"></script>
<script type="text/javascript">
function insertUser(){
	 var form = document.forms[0]; 
	 var userName= document.getElementsByName("userName")[0].value;
	  var loginName= document.getElementsByName("loginName")[0].value;
	 var loginPass= document.getElementsByName("loginPass")[0].value;
	 	 var loginPass1= document.getElementsByName("loginPass1")[0].value;
	  if(userName.trim().length==0){
		document.getElementById("msg1").innerHTML = "<font color='red'>用户名称不能为空</font>";
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
		if(loginName.length>25){
	document.getElementById("msg2").innerHTML = "<font color='red'> 登陆名字数不能超过25</font>";
		return false;
	}
	if(loginPass.trim().length==0){
		document.getElementById("msg3").innerHTML = "<font color='red'> 用户密码不能为空</font>";
		return false;
	}
			if(loginPass.length>25){
	document.getElementById("msg3").innerHTML = "<font color='red'>  用户密码字数不能超过25</font>";
		return false;
	}
	if(loginPass1.trim().length==0){
		document.getElementById("msg4").innerHTML = "<font color='red'> 确认密码不能为空</font>";
		return false;
	}
			if(loginPass1.length>25){
	document.getElementById("msg4").innerHTML = "<font color='red'>  确认密码字数不能超过25</font>";
		return false;
	}
	if(loginPass1!=loginPass){
	document.getElementById("msg4").innerHTML = "<font color='red'>  两次输入密码不同</font>";
	return false;
	}

	  $.ajax({
    	  //dateType:"json",
			type:"post",
		    url: "${pageContext.request.contextPath}/user/userinfoprotect/insertuserinfo",
		    data:{userName:userName,loginName:loginName,loginPass:loginPass},
		    success:function(value){
		    	document.getElementById("pagebottom").innerHTML = "<font color='black'>用户添加成功,请记得给用户设置系统权限</font>";
		    $("input[name='userName']").val("").focus();
		    $("input[name='loginName']").val("");
		    $("input[name='loginPass']").val("");
		    $("input[name='loginPass1']").val("");
		    $("#msg1").empty();
		    $("#msg2").empty();
		    $("#msg3").empty();
		    $("#msg4").empty();
		    	
		    	
		    }		  
		});	
}
$(document).ready(function(){
	$("#loginName").blur(function(){
    var loginName=$("#loginName").val();
    $.ajax({
    	  dateType:"json",
			type:"post",
		    url: "${pageContext.request.contextPath}/user/queryUserInfoByLoginName",
		    data:{loginName:loginName},
		    success:function(value){
		    	var msg=eval("("+value+")");
		    	if((msg=="")==false){
		    		document.getElementById("msg2").innerHTML = "<font color='red'>此登陆名已经存在</font>";
		    	}
		    }		  
		});	
		
		
		
});
	 
	});
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
var text1=document.getElementById("loginName").value; 
var len=25-text1.length;   
var show="你还可以输入"+len+"个字";   
document.getElementById("msg2").innerText=show;  
if(parseInt(len)<0) {
document.getElementById("msg2").innerText="已超过最大字数";
return false;
}
}   
function keypress3() //text输入长度处理   
{   
var text1=document.getElementById("loginPass").value; 
var len=25-text1.length;   
var show="你还可以输入"+len+"个字";   
document.getElementById("msg3").innerText=show;  
if(parseInt(len)<0) {
document.getElementById("msg3").innerText="已超过最大字数";
return false;
}
}   

function keypress4() //text输入长度处理   
{   
var text1=document.getElementById("loginPass1").value; 
var len=25-text1.length;   
var show="你还可以输入"+len+"个字";   
document.getElementById("msg4").innerText=show;  
if(parseInt(len)<0) {
document.getElementById("msg4").innerText="已超过最大字数";
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
<div class="title"><h2>用户添加</h2></div>
<form >
<table class="user">
<tr>
<td>用户名称</td>
<td><input name="userName"  id="userName" type="text"   onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg1').innerHTML=''" />
<div style="display: inline" id="msg1"></div></td>
</tr>
<tr>
<tr>
<td>用户账号</td>
<td><input name="loginName" id="loginName" type="text"  onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg2').innerHTML=''" />
<div style="display: inline" id="msg2"></div></td>
</tr>
<tr>
<tr>
<td>用户密码</td>
<td><input name="loginPass"  id="loginPass" type="password" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg3').innerHTML=''"/>
<div style="display: inline" id="msg3"></div></td>
</tr>
<tr>
<td>确认密码</td>
<td><input name="loginPass1"  id="loginPass1" type="password" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg3').innerHTML=''" />
<div style="display: inline" id="msg4"></div></td>
</tr>
<td><input type="button"  value="添加"  onclick="insertUser()">
<td><input type="button"  value="返回用户展示页面"  onclick="backUserList()">
</table>
</form>
<div id="pagebottom"></div>
</body>
</html>