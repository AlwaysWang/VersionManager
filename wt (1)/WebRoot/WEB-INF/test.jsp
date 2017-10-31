<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script>
function OpenDiv(){
document.getElementById("div1").style.display="block";
document.getElementById("open").style.display="none";
document.getElementById("div1").style.overflow="scroll";

}

function CloseDiv(){
document.getElementById("div1").style.display="none";
document.getElementById("open").style.display="block";
}
</script>
<style>
#div1{
display: none;
position: absolute;
left:50%;
top:50%;
width:250px;
height:150px;
background-color:gray;
text-align: center;
}
#open{
position: absolute;
top:50%;
left:50%;
width:100px;
height:50px;
}
</style>
</head>
<body>
<div id="div1">
<table>
<tr><td>账号</td><td><input type="text"></td></tr>
<tr><td>密码</td><td><input type="text"></td></tr>
</table>
   <a href="javascript:CloseDiv();">关闭</a>
</div>
<input type="button" value="打开" onclick="javascript:OpenDiv();" id="open">
</body>
</html>