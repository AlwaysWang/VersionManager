<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%String path =request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//System.out.println(basePath);
%> 
<title>Insert title here</title>
<style type="text/css">
table.newstable {
position:absolute;
 font-family: verdana,arial,sans-serif;
 font-size:11px;
 color:#333333;
 border-width: 1px;
 border-color: #999999;
 border-collapse: collapse;
 left:160px;
width:1100px;
}
table.searchCondition{
position:relative;
left:160px;
width:1100px;
}
table.newstable th {
 background:#b5cfd2 url('cell-blue.jpg');
 border-width: 1px;
 padding: 20px;
 border-style: solid;
 border-color: #999999;
}
table.newstable td {
 background:#dcddc0 url('cell-grey.jpg');
 border-width: 1px;
 padding: 20px;
 border-style: solid;
 border-color: #999999;
}
div.title{
position:relative;
}
div.newscontent{

position:relative;
left:160px;
width:1080px;
word-break:break-all; 
text-align: center;

}
 #container {
 margin: 0 auto; width:1060px;
 }
 
</style>
</head>
<body  style="overflow:-Scroll;overflow-x:hidden">
<div class="title" style="text-align: center"><h2>以下是最新公告</h2></div>
<div class="newstitle" style="text-align: center"><h2>公告标题：${news.title }</h2></div>
<div class="newscontent" style="text-align: center"><h2>公告内容：${news.content }</h2></div>
<div class="newstitle" style="text-align: center"><h2>公告时间：${news.istDateFormat }</h2></div>
</table>
</body>
</html>