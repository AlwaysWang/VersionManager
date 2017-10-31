<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
System.out.println(basePath);
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">
body { font-family:Verdana; font-size:16px; margin:0 auto;}
#container {margin: 0 auto; width:1060px;background-color: gray;}
.nav{background-color: gray;}
a:link{text-decoration:none; color:black;}
a:hover{text-decoration:underline; color:red;}
#nav{ width:100%; height:20px; background:gray;}
#nav ul { 
 list-style:none; 
} 
#nav ul li{ 
 float:left; 
 text-align:center; 
 width: 25%;
 border-right:0px solid #fff; 
} 
#nav ul li a{ 
font-size:17px;
 text-decoration:none; 
 display:block; 
} 
ul li ul{ 
 display:none; 
} 
a:hover{ 
 background-color:red; 
 color:#FFFFFF; 
} 
 a:link{text-decoration:none; color:black;}



</style>
<script type="text/javascript" src="<%=basePath%>jquery/jquery-1.8.0min.js"></script>
  <script type="text/javascript">
  $(function(){
	  var dv=$(".menu div");

	  dv.click(function(){

	  var aixuexi=$(this);

	  if(aixuexi.next("ul").is(":hidden")){

	   aixuexi.next("ul").show();

	    }else{

	  aixuexi.next("ul").hide();

	}

	  })

	})
	  function disptime( ) 
     { 
     
     var time = new Date( ); //获得当前时间 
     var hour = time.getHours( ); //获得小时、分钟、秒 
     var minute = time.getMinutes( ); 
     var second = time.getSeconds( ); 
     var apm="AM"; //默认显示上午: AM 
     
     if (hour>12) //按12小时制显示 
     { 
      hour=hour-12; 
      apm="PM" ; 
     } 
     if (minute < 10) //如果分钟只有1位，补0显示 
      minute="0"+minute; 
     if (second < 10) //如果秒数只有1位，补0显示 
      second="0"+second; 
     /*设置文本框的内容为当前时间*/ 
     document.myform.myclock.value =hour+":"+minute+":"+second+" "+apm; 
     /*设置定时器每隔1秒（1000毫秒），调用函数disptime()执行，刷新时钟显示*/ 
     var myTime = setTimeout("disptime()",1000); 
     
    } 
     function say(){
      //window.parent.close();
  var form = document.forms[0]; 
  form.action = "${pageContext.request.contextPath}/user/exit/${roleUser.roleId}";
 form.method = "post";  
 form.submit(); 


     }
     function showsub(li){ 
 var submenu=li.getElementsByTagName("ul")[0]; 
 submenu.style.display="block"; 
} 
function hidesub(li){ 
 var submenu=li.getElementsByTagName("ul")[0]; 
 submenu.style.display="none"; 
}
  
  </script>
</head>
<body onload="disptime();" style="overflow-y:hidden">
<div id="container">
<form name="myform">
<div id="header" >
   <h1 style="text-align: center;" >版本管理系统</h1> 
<div id="time" style="text-align: right">
${loginUser.loginName}您好  当前时间是  <INPUT name="myclock" type="text" value="" size="8">
</div>

<div class="nav" id="nav">
<ul>

 <li onmouseover="showsub(this)" onmouseout="hidesub(this)"><a href="#">版本管理</a>
 <ul>
<a href="<%=basePath%>installVersion/queryInsatllVersion/${roleUser.roleId}"  target="mainhome">版本查询</a>
</ul>
</li>

 <li onmouseover="showsub(this)" onmouseout="hidesub(this)"><a href="#">公告查询</a>
 <ul>
<a href="<%=basePath%>user/FindNews/${roleUser.roleId}"  target="mainhome">查询最新公告</a></li>
</ul>
</li>

 <li onmouseover="showsub(this)" onmouseout="hidesub(this)">
 <a href="<%=basePath%>user/passwordupdate/${roleUser.roleId}" target="mainhome">密码修改</a>
</li>
 
 <li onmouseover="showsub(this)" onmouseout="hidesub(this)">
 <a href="<%=basePath%>/user/exit/${roleUser.roleId}" target="_parent">退出登录</a>
 
</li>

</div>

</div>

</form>
</div>
</body>
</html>