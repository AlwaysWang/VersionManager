<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
         <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
System.out.println(basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<frameset rows="30%,70%"  frameborder="no" marginWidth=0 marginHeight=0 scrolling=no border="0">
                <frame src="<%=basePath%>tophome2.jsp"  name="tophome">
                  <frame src="<%=basePath%>mainhome2.jsp" name="mainhome">
  </frameset>  
<body>

</body>
</html>