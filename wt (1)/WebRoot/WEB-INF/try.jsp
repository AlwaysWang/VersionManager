<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<style type="text/css">
*{ margin:0; padding:0;}/*浏览器边缘无缝隙*/
#nav{ width:100%; height:35px; background:#fb600d;}/*100%宽度导航条*/
#nav ul{ width:1024px; height:100%; margin:auto;}/*导航条内容，1024px居中*/
#nav ul li{ width:150px; height:100%; float:left; display:block; border-right:1px solid #fff; text-align:center;}/*导航内栏目样式*/
#nav ul li a{ color:#FFF; line-height:35px; text-decoration:none;}/*导航内顶级栏目链接样式*/
#nav ul li a:hover{ color:#000;}/*顶级栏目链接鼠标经过变色*/
#nav ul li ul{ width:150px; display:none;}/*顶级栏目下子栏目内容触发前先隐藏*/
#nav ul li:hover ul{ width:150px; display:block; }/*鼠标经过顶级栏目时显示子栏目菜单*/
#nav ul li ul li{width:150px; background:#FB600D; border-top:1px solid #FFF;}/*子栏目列表样式*/
#nav ul li ul li a{ color:#FFF; line-height:35px; text-decoration:none;}/*子栏目列表链接样式*/
#nav ul li ul li a:hover{ color:#000;}/*子栏目列表鼠标经过样式*/
</style>
</head>
<body>
<div id="nav">
<ul>
            <li><a href="#">网站首页</a>
                <ul>
                    <li><a href="#">菜单1</a></li>
                    <li><a href="#">菜单1</a></li>
                    <li><a href="#">菜单1</a></li>
                    <li><a href="#">菜单1</a></li>
               </ul>
            </li>
            <li><a href="#">网站首页</a>
               <ul>
                    <li><a href="#">菜单2</a></li>
                    <li><a href="#">菜单2</a></li>
                    <li><a href="#">菜单2</a></li>
                    <li><a href="#">菜单2</a></li>
               </ul>
            </li>
            <li><a href="#">网站首页</a></li>
    </ul>
</div>
</body>
</html>