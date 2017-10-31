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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript"  src="<%=basePath%>js/showdate.js"></script>
	<script type="text/javascript" src="<%=basePath%>lhgcalendar/lhgcore.js"></script>
	<script type="text/javascript" src="<%=basePath%>lhgcalendar/lhgcalendar.js"></script>
	<script type="text/javascript" src="<%=basePath%>jquery/jquery-1.8.0.min.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-base.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-all.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-lang-zh_CN.js"></script>
<script type="text/javascript">
function validate(){
	var form = document.forms[0];  
	var testTypeId= document.getElementsByName("testTypeId")[0].value;
	var testTypeName= document.getElementsByName("testTypeName")[0].value;
	var testTypeRemark= document.getElementsByName("testTypeRemark")[0].value;
	if(testTypeId.trim().length==0){
		document.getElementById("msg1").innerHTML = "<font color='red'> 测试类别id不能为空</font>";
		return false;
	}
	if(testTypeName.trim().length==0){
		document.getElementById("msg2").innerHTML = "<font color='red'>测试类别名称不能为空</font>";
		return false;
	}
	if(testTypeName.length>25){
		document.getElementById("msg2").innerHTML = "<font color='red'>测试类别名称字数不能超过25</font>";
		return false;
	}
	if(testTypeRemark.trim().length==0){
		document.getElementById("msg3").innerHTML = "<font color='red'>测试类别描述不能为空</font>";
		return false;
	}
		if(testTypeRemark.length>50){
		document.getElementById("msg3").innerHTML = "<font color='red'>测试类别描述字数不能超过50</font>";
		return false;
		}
	  $.ajax({
    	  //dateType:"json",
			type:"post",
		    url: "${pageContext.request.contextPath}/testtype/doupdatetesttype",
		    data:{testTypeName:testTypeName,testTypeRemark:testTypeRemark,testTypeId:testTypeId},
		    success:function(value){
		    	document.getElementById("pagebottom").innerHTML = "<font color='black'>测试类别修改成功</font>";
		    }		  
		});	
	
}
function backList(){
	var form = document.forms[0];  
	form.action = "${pageContext.request.contextPath}/testtype/querytesttype/${userid}"; 
	 form.method = "post";  
    form.submit();
}
function keypress1() //textarea输入长度处理   
{   
var text1=document.getElementById("testTypeRemark").value;   
var len;//记录剩余字符串的长度   
len=50-text1.length;   
var show="你还可以输入"+len+"个字";   
document.getElementById("msg3").innerText=show;   
if(parseInt(len)<0) {
document.getElementById("msg3").innerText="已超过最大字数";
return false;
}
}  
</script>
<style type="text/css">
table.testtype {
position:absolute;
 font-family: verdana,arial,sans-serif;
 font-size:16px;
 color:#333333;
 border-width: 1px;
 border-color: #999999;
 border-collapse: collapse;
 left:450px;
}
div.title{
position:relative;
 left:450px;
width:1100px;
}


a{text-decoration: none;}
#th{
color:red;}

#pagebottom{
position:relative;
 left:250px;
width:1100px;
top:300px;

}
</style>

</head>
<body style="overflow:-Scroll;overflow-x:hidden">
<div class="title"><h2>测试类别维护</h2></div>
<form action="<%=basePath%>testtype/doupdatetesttype" method="post">
<table class="testtype">
<tr>
<td>测试类别Id</td>
<td><input name="testTypeId" type="text" readonly="readonly"  value="${requestScope.testType.typeId}" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg1').innerHTML=''"/>
<div style="display: inline" id="msg1"></div></td>
<tr>
<td>测试类别名称</td>
<td><input name="testTypeName"  id="testTypeName"  type="text"   value="${requestScope.testType.typeName}" 
onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg2').innerHTML=''"/>
<div style="display: inline" id="msg2"></div></td>
</tr>
<tr>
<td>测试类别描述</td>
<td>
<textarea name="testTypeRemark"  id="testTypeRemark"   rows="15" cols="30" 
onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg3').innerHTML=''"  onblur="keypress1()"/> <c:out value="${requestScope.testType.remark}"></c:out>  </textarea>
<div style="display: inline" id="msg3"></div></td>
</tr>
<td><input type="button"  value="修改"  onclick="validate()"></td>
<td><input type="button"  value="返回测试类别列表"  onclick="backList()"></td>
</table>
</form>
<div id="pagebottom"></div>
</body>
</html>