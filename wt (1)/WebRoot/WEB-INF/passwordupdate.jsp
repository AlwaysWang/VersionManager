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
<title>密码修改</title>
<style type="text/css">
.button{
background-color: gray;
}
#down_center{
position:absolute;
left:180px;
top:280px;
font-size: 30px;
color:red;
}
table.password {
position:absolute;
 font-family: verdana,arial,sans-serif;
 font-size:30px;
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
 left:250px;
width:1100px;

}

</style>
<script type="text/javascript" src="<%=basePath%>jquery/jquery-1.8.0min.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-base.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-all.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-lang-zh_CN.js"></script>
<script type="text/javascript">
function validate(){
    var form = document.forms[0];  
	var loginName = document.getElementsByName("loginName")[0].value;
	var password = document.getElementsByName("password")[0].value;
	var newpassword= document.getElementsByName("newpassword")[0].value;
	var newpassword1 = document.getElementsByName("newpassword1")[0].value;
	if(loginName.trim().length==0){
			document.getElementById("msg1").innerHTML = "<font color='red'> 用户账号不能为空</font>";
			return false;
		}
	if(password.trim().length==0){
			document.getElementById("msg2").innerHTML = "<font color='red'> 用户密码不能为空</font>";
			return false;
		}
		if(newpassword.trim().length==0){
			document.getElementById("msg3").innerHTML = "<font color='red'> 新密码不能为空</font>";
			return false;
		}
		if(newpassword1.trim().length==0){
			document.getElementById("msg4").innerHTML = "<font color='red'> 确认密码不能为空</font>";
			return false;
		}
		Ext.Ajax.request({  
		    url:"<%=basePath%>user/updatepassword",  
		    method:"POST",  
		   params:{
		    	'loginName':loginName,
		    	'password':password,
		    	'newpassword':newpassword,
		    	'newpassword1':newpassword1
		    	
	    	},  
		    success:function(obj,action){  
		      var jsonData = Ext.util.JSON.decode(obj.responseText);  
		      //  数据请求成功  
		        if(jsonData.success){  
		        	alert("密码修改成功啦");
		           window.location.href = "<%=basePath%>user/doupdatepassword";
		          // document.getElementById("down_center").innerHTML = "<br><font>修改成功啦！</font>";
	    
		      }
		       if(jsonData.nouser){  
		           document.getElementById("down_center").innerHTML = "<br><font color='red'>用户名根本不存在！</font>";
		           return false;
		      }
		       if(jsonData.passwrong){  
		            document.getElementById("down_center").innerHTML = "<br><font color='red'>用户密码输入错误！</font>";
		            return false;
		      }
		       if(jsonData.passsame){
		    	   document.getElementById("down_center").innerHTML = "<br><font color='red'>新旧密码相同！</font>";
		    	   return false;
		       }
		        if(jsonData.passsamewrong){  
		         document.getElementById("down_center").innerHTML = "<br><font color='red'>两次输入密码不一样！</font>";
		         return false;
		      }
		    
		      }
		   , 
		    failure:function(){  
		    document.getElementById("down_center").innerHTML = "<br><font color='red'>用户名和密码输入错误！</font>";
		    
		   }  
	}); 
	
	
	
}

</script>
</head>
<body style="overflow:-Scroll;overflow-x:hidden">
<form>
<div class="title"><h1>用户安全中心</h2></div>
<table  class="password" border="0">
<tr>
<td>登录账号</td>
<td>
<input id="loginName" name="loginName" type="text" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg1').innerHTML=''"/>
 <div style="display: inline" id="msg1"></td></tr>
<tr>
<td>原密码</td><td><input id="password" name="password" type="password"  value="<%request.getAttribute("username") ;%>" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg2').innerHTML=''"/>
<div style="display: inline" id="msg2"></td>
</tr>
<tr></tr>
<tr>
<td>新密码</td><td><input id="newpassword" name="newpassword" type="password"  onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg3').innerHTML=''"/>
<div style="display: inline" id="msg3"></td>
</tr>
<tr>
<td>确认密码</td><td><input id="newpassword1" name="newpassword1" type="password" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg4').innerHTML=''"/ >
<div style="display: inline" id="msg4"></td>
</tr>
<tr>
<td><input   type="button" value="确认修改"  onclick="validate();">


<td><input   type="reset"  value="重置"></td>

</tr>
</div>
</table>
</form>
<div id="down_center"></div>	
</body>
</html>