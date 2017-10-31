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
<title>Insert title here</title>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<script type="text/javascript"  src="<%=basePath%>js/showdate.js"></script>
	<script type="text/javascript" src="<%=basePath%>lhgcalendar/lhgcore.js"></script>
	<script type="text/javascript" src="<%=basePath%>lhgcalendar/lhgcalendar.js"></script>
	<script type="text/javascript" src="<%=basePath%>jquery/jquery-1.8.0.min.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-base.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-all.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-lang-zh_CN.js"></script>
 <script type="text/javascript">
function insert(){
	var form = document.forms[0];
	var testtype=document.getElementById("typetest").value;
	var testname=document.getElementById("testname").value;
	var remark=document.getElementsByName("testCodeRemark")[0].value;
	if(testtype==""){
	document.getElementById("msg1").innerHTML = "<font color='red'>所属测试类别不能为空</font>";
		return false;
	}
	if(testtype!=""){
		document.getElementById("msg1").innerHTML = "";
	}
	if(testname==""){
	document.getElementById("msg2").innerHTML = "<font color='red'>测试类型名称不能为空</font>";
			return false;
	}
	if(testname!=""){
	document.getElementById("msg2").innerHTML = "";
	}
	if(testname.length>50){
	document.getElementById("msg2").innerHTML = "<font color='red'>测试类型名称字数不能超过50</font>";
			return false;
	}
   if(remark.trim().length==0){
    document.getElementById("msg3").innerHTML = "<font color='red'>测试类型描述不能为空</font>";
    		return false;
   }
    if(remark.trim().length!=0){
    document.getElementById("msg3").innerHTML = "";
   }
   if(remark.length>25){
	document.getElementById("msg3").innerHTML = "<font color='red'>测试类型描述字数不能超过25</font>";
			return false;
	}
  $.ajax({
    	  //dateType:"json",
			type:"post",
		    url: "${pageContext.request.contextPath}/testtype/inserttestcode",
		    data:{typeid:testtype,testname:testname,remark:remark},
		    success:function(value){
		    	document.getElementById("pagebottom").innerHTML = "<font color='black'>测试类型添加成功</font>";
		    	$("input[name='testname']").val("").focus();
		    	$("textarea[name='testCodeRemark']").val("");
		    	$("#msg1").empty();
		        $("#msg2").empty();
		       $("#msg3").empty();
		    	
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
var text1=document.getElementById("testCodeRemark").value;   
var len;//记录剩余字符串的长度   
len=25-text1.length;   
var show="你还可以输入"+len+"个字";   
document.getElementById("msg3").innerText=show;   
if(parseInt(len)<0) {
document.getElementById("msg3").innerText="已超过最大字数";
return false;
}
}  

</script>
<style type="text/css">
#testtype {
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
<div class="title"><h2>测试类型添加</h2></div>
<form>
<table class="testtype" id="testtype">
<tr>
<td>所属测试类别</td>
<td>
<select name="typetest" id="typetest"  onchange="selectChecked();">
<option value="" selected="selected">请选择</option>
<c:forEach var="testType" items="${testtypeList}" varStatus="vs">
             <option value="${testType.typeId}">${testType.typeName}</option>
       </c:forEach>
</select>
<div style="display: inline" id="msg1"></div>
</td>
</tr>
<tr>
<td>测试类型名称</td>
<td><input name="testname" id="testname" type="text" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg1').innerHTML=''"/>
<div style="display: inline" id="msg2"></div></td>
</tr>
<tr>
<td>测试类型描述</td>
<td>
<textarea name="testCodeRemark"  id="testCodeRemark"  rows="15" cols="20" onblur="keypress1()">  
</textarea>
<div style="display: inline" id="msg3"></div></td>
</tr>
<td><input type="button"  value="添加" onclick="insert();"></td>
<td><input type="button"  value="返回测试类别列表"  onclick="backList()"></td>
</table>
</form>
<div id="pagebottom"></div>
</body>
</html>