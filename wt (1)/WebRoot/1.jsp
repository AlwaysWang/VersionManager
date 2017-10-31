<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<style type="text/css">
*{ 
 margin:0; 
 padding:0; 
} 
.nav{ 
 background-color:#EEEEEE; 
 height:40px; 
 width:450px; 
 margin:0 auto; 
} 
ul{ 
 list-style:none; 
} 
ul li{ 
 float:left; 
 line-height:40px; 
 text-align:center; 
} 
a{ 
 text-decoration:none; 
 color:#000000; 
 display:block; 
 width:90px; 
 height:40px; 
} 
a:hover{ 
 background-color:#666666; 
 color:#FFFFFF; 
} 
ul li ul li{ 
 float:none; 
 background-color:#EEEEEE; 
} 
ul li ul{ 
 display:none; 
} 
/*为了兼容IE7设置的CSS样式，但是又必须写在a:hover前面*/
ul li ul li a:link,ul li ul li a:visited{ 
 background-color:#EEEEEE; 
} 
ul li ul li a:hover{ 
 background-color:#009933; 
} 

</style>
<script type="text/javascript">
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
<body>
<div id="nav" class="nav"> 
 <ul> 
  <li><a href="#">网站首页</a></li> 
  <li onmouseover="showsub(this)" onmouseout="hidesub(this)"><a href="#">课程大厅</a> 
  <ul> 
   <li><a href="#">JavaScript</a></li> 
   <li><a href="#">jQuery</a></li> 
   <li><a href="#">Ajax</a></li> 
  </ul> 
  </li> 
  <li onmouseover="showsub(this)" onmouseout="hidesub(this)"><a href="#">学习中心</a> 
  <ul> 
   <li><a href="#">视频学习</a></li> 
   <li><a href="#">案例学习</a></li> 
   <li><a href="#">交流平台</a></li> 
  </ul> 
  </li> 
  <li><a href="#">经典案例</a></li> 
  <li><a href="#">关于我们</a></li> 
 </ul> 
</div> 
</body>
</html>