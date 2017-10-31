<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
     <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
System.out.println(basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>项目主页面</title>
</head>
<frameset rows="33%,67%"  frameborder="no" marginWidth=0 marginHeight=0 scrolling=no border="0" name="home">
                <frame src="<%=basePath%>tophome.jsp"  name="tophome">
                  <frame src="<%=basePath%>mainhome2.jsp" name="mainhome">
    <!--      <frameset cols="20%,80%">
 <frame src="<%=basePath%>mainhome1.jsp" name="mainhome1">
  <frameset cols="88.89%,11.11%">
                 <frame src="<%=basePath%>mainhome2.jsp" name="mainhome">
               <frame src="<%=basePath%>mainhome3.jsp" name="mainhome2">
              </frameset>
 </frameset>-->
  </frameset>                    
                
<body >                 
          
                   
   </body>                 

