<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
System.out.println(basePath);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <link rel="stylesheet" href="style.css" />
<link href='http://fonts.googleapis.com/css?family=Oleo+Script' rel='stylesheet' type='text/css'>
<script type="text/javascript" src="<%=basePath%>jquery/jquery-1.8.0min.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-base.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-all.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-lang-zh_CN.js"></script>
<script type="text/javascript">
	function login(){
		var userAccount = document.getElementsByName("userAccount")[0].value;
		var userPass = document.getElementsByName("userPass")[0].value;
		if(userAccount.trim().length==0){
			document.getElementById("msg1").innerHTML = "<font color='red'> 用户名不能为空</font>";
			document.getElementsByName("userAccount")[0].focus();
			document.getElementsByName("userAccount")[0].style.borderColor="red";
			document.getElementsByName("userAccount")[0].style.borderStyle="dotted";
			return false;
		}
		if(userPass.trim().length==0){
			document.getElementById("msg2").innerHTML = "<font color='red'> 密码不能为空</font>";
			document.getElementsByName("userPass")[0].focus();
			document.getElementsByName("userPass")[0].style.borderColor="red";
			document.getElementsByName("userPass")[0].style.borderStyle="dotted";
			return false;
			}
			//var form = document.forms[0]; 
			 //form.action = "${pageContext.request.contextPath}/user/loginon"; 
			 //form.method = "post";  
		    //form.submit();  
	
		Ext.Ajax.request({  
		    url:"<%=basePath%>user/loginon",  
		    method:"POST",  
		   params:{
		    	'userAccount':userAccount,
		    	'userPass':userPass
	    	},  
		    success:function(obj,action){  
		      var jsonData = Ext.util.JSON.decode(obj.responseText);  
		      //  数据请求成功  
		        if(jsonData.success){  
		           window.location.href = "<%=basePath%>user/index";
		      }
		        if(jsonData.success1){  
			           window.location.href = "<%=basePath%>user/index1";
			      }
		        if(jsonData.success2){  
			           window.location.href = "<%=basePath%>user/index2";
			      }
		        if(jsonData.success3){  
		        	document.getElementById("down_center").innerHTML = "<br><font color='red'>该用户还没有拥有登录权限</font>";
			      }
		        else{
				document.getElementById("down_center").innerHTML = "<br><font color='red'>用户名和密码输入错误！</font>";
		        }  
		   },  
		    failure:function(){  
		    document.getElementById("down_center").innerHTML = "<br><font color='red'>用户名和密码输入错误！</font>";
		   }  
	}); 
	}
</script>
<style type="text/css">
body{
	background-image:url(bg.png);
	font-family: 'Oleo Script', cursive;
}

.lg-container{
	width:300px;
	padding:20px 40px;
	border:1px solid #f4f4f4;
	background:rgba(255,255,255,.5);
	-webkit-border-radius:10px;
	-moz-border-radius:10px;

	-webkit-box-shadow: 0 0 2px #aaa;
	-moz-box-shadow: 0 0 2px #aaa;
	position: absolute;
	top:220px;
	left:850px;
	
	
}
.lg-container h1{
	font-size:40px;
	text-align:center;
}
#lg-form > div {
	margin:10px 5px;
	padding:5px 0;

}
#lg-form label{
	display: none;
	font-size: 20px;
	line-height: 25px;
}
#lg-form input[type="text"],
#lg-form input[type="password"]{
	border:1px solid rgba(51,51,51,.5);
	-webkit-border-radius:10px;
	-moz-border-radius:10px;
	padding: 5px;
	font-size: 16px;
	line-height: 20px;
	width: 100%;
	font-family: 'Oleo Script', cursive;
	text-align:center;
}
#lg-form div:nth-child(3) {
	text-align:center;
}
#lg-form button{
	font-family: 'Oleo Script', cursive;
	font-size: 18px;
	border:1px solid #000;
	padding:5px 10px;
	border:1px solid rgba(51,51,51,.5);
	-webkit-border-radius:10px;
	-moz-border-radius:10px;

	-webkit-box-shadow: 2px 1px 1px #aaa;
	-moz-box-shadow: 2px 1px 1px #aaa;
	cursor:pointer;
}
#lg-form button:active{
	-webkit-box-shadow: 0px 0px 1px #aaa;
	-moz-box-shadow: 0px 0px 1px #aaa;
}
#lg-form button:hover{
	background:#f4f4f4;
}
#message{width:100%;text-align:center}
.success {
	color: green;
}
.error {
	color: red;
}
a{
text-decoration: none;
font-size: 35px;
color: black;

}
.head {
margin: 0px opx;


}
.head h1{
text-align: center;
font-size: 40px;}
.remark{
position: absolute;
top: 200px;
left: 30px;
right:750px;
}
.remark p{
font-family: inherit;
font-size: 20px;
}
</style>
    <base href="<%=basePath%>">
    <title>登录页面</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
  </head>
  
  <body>
  <table width="100%"  height="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="561" style="background:url(images/lbg.gif)"><table width="940" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="238" style="background:url(images/login01.jpg)">&nbsp;</td>
          </tr>
          <tr>
            <td height="190"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="208" height="190" style="background:url(images/login02.jpg)">&nbsp;</td>
                <td width="518" style="background:url(images/login03.jpg)"><table width="320" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="40" height="50"><img src="images/user.gif" width="30" height="30"></td>
                    <td width="38" height="50">用户</td>
                    <td width="242" height="50"><input type="text" name="userAccount" id="userAccount" style="width:164px; height:32px; line-height:34px; background:url(images/inputbg.gif) repeat-x; border:solid 1px #d1d1d1; font-size:9pt; font-family:Verdana, Geneva, sans-serif;" placeholder="用户名"
                    onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg1').innerHTML=''"></td>
                  </tr>
                  <tr>
                    <td height="50"><img src="images/password.gif" width="28" height="32"></td>
                    <td height="50">密码</td>
                    <td height="50"><input type="password" name="userPass" id="userPass" style="width:164px; height:32px; line-height:34px; background:url(images/inputbg.gif) repeat-x; border:solid 1px #d1d1d1; font-size:9pt;" placeholder="密码"
                    onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg2').innerHTML=''" /></td>
                  </tr>
                  <tr>
                    <td height="40">&nbsp;</td>
                    <td height="40">&nbsp;</td>
                    <td height="60"><a href="javascript:login()"><img src="images/login.gif" width="95" height="34" onclick="javascript:login()"></a></td>
                  </tr>
                </table></td>
                <td width="214" style="background:url(images/login04.jpg)" >&nbsp;</td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td height="133" style="background:url(images/login05.jpg)">&nbsp;</td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
  </body>
</html>
