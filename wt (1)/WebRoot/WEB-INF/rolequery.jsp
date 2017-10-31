<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
System.out.println(basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<h1 class="h1">role查询</h1>
<tr>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<tr>
<td>用户名称</td>
<td><input type="text"></td>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="查询"/ class="button">
<table boder="1" cellpadding="10">
<tr>
<th>开始时间</th>
<th>用户名称</th>
<th>用户登录</th>
<th>测试类别描述</th>
</tr>
<c:forEach items="${requestScope.roleList}" var="role" varStatus="vs">
<tr>
<td>${role.istDate}</td>
<td>${role.roleName}</td>
<td>${ role.state}</td>
<td>${role.remark}</td>
</tr>
</c:forEach>
</table>
</body>
</html>