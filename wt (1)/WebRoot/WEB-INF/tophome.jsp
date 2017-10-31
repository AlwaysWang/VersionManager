<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
System.out.println(basePath);
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript"  src="<%=basePath%>js/showdate.js"></script>
	<script type="text/javascript" src="<%=basePath%>lhgcalendar/lhgcore.js"></script>
	<script type="text/javascript" src="<%=basePath%>lhgcalendar/lhgcalendar.js"></script>
	<script type="text/javascript" src="<%=basePath%>jquery/jquery-1.8.0.min.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-base.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-all.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-lang-zh_CN.js"></script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">
#header{
position:absolute;
left:160px;
width:1100px;
height:70px;
background-color: gray;
}
#time{
position:absolute;
top:70px;
left:160px;
width:1100px;
height:40px;
background-color: gray;
}
.menu{
position:absolute;
top:100px;
left:160px;
width:1100px;
height:80px;
background-color: gray;
}

    .menu1{ width: 14.28%; height: 100px; margin: 10px;}
    .menu1{ overflow: hidden; }
    .menu1{ float: left; }
   .menu1 a{
   text-decoration: none;
   }
  a:link{text-decoration:none; color:black;}
a:hover{text-decoration:underline; color:red;}

li{list-style: none;
}
#nav{ width:76.5%; height:35px; background:black;}
#nav ul{ width:1024px; height:100%; margin:auto;}/*导航条内容，1024px居中*/
#nav ul li{ width:150px; height:100%; float:left; display:block; border-right:1px solid #fff; text-align:center;}/*导航内栏目样式*/
#nav ul li a{ color:#FFF; line-height:35px; text-decoration:none;}/*导航内顶级栏目链接样式*/
#nav ul li  a:link,ul  li a:visited{ 
 background-color:#EEEEEE; 
} 
#nav ul li a:hover{ color:#FB600D;}/*顶级栏目链接鼠标经过变色*
#nav ul li:hover ul{ width:150px; display: inline; }/*鼠标经过顶级栏目时显示子栏目菜单*/
#nav ul li ul li{width:150px; background:#FB600D; border-top:1px solid #FFF;}/*子栏目列表样式*/
#nav ul li ul li a{ color:#FFF; line-height:35px; text-decoration:none;}/*子栏目列表链接样式*/
#nav ul li ul li a:hover{ color:#000;}/*子栏目列表鼠标经过样式*/
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
function showsub(li){ 
alert("hh");
 var submenu=li.getElementsByTagName("ul")[0]; 
 submenu.style.display="block"; 
} 
function hidesub(li){ 
alert("jj");
 var submenu=li.getElementsByTagName("ul")[0]; 
 submenu.style.display="none"; 
}

  </script>
</head>
<body onload="disptime();" style="overflow-y:hidden">
<form name="myform">
<input   type="hidden" name="id" value="${loginUser.userName}">
<input type="hidden" name="role" id="role" value="${roleUser.roleId}">
<div id="header" >
   <h1 style="text-align: center;" >欢迎${loginUser.userName}来到杭州金硕信息技术有限公司 在线小项目</h1> 
</div>
<div id="time">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<td><a href="<%=basePath%>user/FindNews/${roleUser.roleId}" target="mainhome" style="color:#FFF; line-height:35px; text-decoration:none;">查看最新公告</a></td>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<td>${loginUser.loginName}您好！${roleUser.roleId}</td><td>当前时间是</td>  <INPUT name="myclock" type="text" value="" size="8">
&nbsp;&nbsp;<td><a href="<%=basePath%>user/passwordupdate/${roleUser.roleId}" target="mainhome" style="color:#FFF; line-height:35px; text-decoration:none;">密码修改</a></td>
<td><a href="<%=basePath%>user/exit/${roleUser.roleId}" target="_parent" style="color:#FFF; line-height:35px; text-decoration:none;">退出登录</a></td></div>
<div class="menu" id="nav">
<ul>


 <li><a href="#"  onmouseout="hidesub(this)"  onmouseover="showsub(this)">版本管理</a>
 <ul>
<li><a href="<%=basePath%>installVersion/queryInsatllVersion/${roleUser.roleId}" target="mainhome">版本查询</a></li>
<!-- <li><a href="<%=basePath%>installVersion/queryInsatllVersion/"  target="mainhome">版本查询</a></li>-->
<li><a href="<%=basePath%>installVersion/protectInsatllVersion/${roleUser.roleId}" target="mainhome">版本添加</a></li>
</ul>
</li>



<li><a href="#">功能管理</a>
<ul>
<li><a href="<%=basePath%>function/queryAllFun/${roleUser.roleId}"  target="mainhome">功能查询</a></li>
<li><a href="<%=basePath%>function/protectFun/${roleUser.roleId}"  target="mainhome">功能添加</a></li>
</ul>
</li>




<li><a href="#">程序管理</a>
<ul>
<li><a href="<%=basePath%>program/queryAllProgram/${roleUser.roleId}"  target="mainhome">程序查询</a></li>
<li><a href="<%=basePath%>program/protectProgram/${roleUser.roleId}" target="mainhome">程序添加</a></li>
</ul>
</li>


<li><a href="#">测试类别管理</a>
<ul>
<li><a href="<%=basePath%>testtype/querytesttype/${roleUser.roleId}" target="mainhome">测试类别查询</a></li>
<li><a href="<%=basePath%>testtype/protecttesttype/${roleUser.roleId}" target="mainhome">测试类别添加</a></li>
<li><a href="<%=basePath%>testtype/protecttestcode/${roleUser.roleId}" target="mainhome">测试类型添加</a></li>
</ul>
</li>


<li><a href="#">系统管理</a>
<ul>
<li><a href="<%=basePath%>user/userinfoquery/${roleUser.roleId}" target="mainhome">用户查询</a></li>
<li><a href="<%=basePath%>user/userinfoprotect/${roleUser.roleId}" target="mainhome">用户添加</a></li>
</ul>
</li>


<li><a href="#">公告管理</a>
<ul>
<li><a href="<%=basePath%>news/querynews/${roleUser.roleId}" target="mainhome">公告查询</a></li>
<li><a href="<%=basePath%>news/protectnews/${roleUser.roleId}" target="mainhome">公告添加</a></li>
</ul>
</li>
<li>
<a href="<%=basePath%>user/userright/${roleUser.roleId}" target="mainhome" style="color:#FFF; line-height:35px; text-decoration:none;">权限管理</a></td>
</li>
</ul> 
</div>
</form>
</body>
</html>