<%@page import="com.itextpdf.text.log.SysoCounter,com.wt.bean.TestType,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
     <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
System.out.println(basePath);
%> 
<script type="text/javascript"  src="<%=basePath%>js/showdate.js"></script>
<script type="text/javascript" src="<%=basePath%>lhgcalendar/lhgcore.js"></script>
	<script type="text/javascript" src="<%=basePath%>lhgcalendar/lhgcalendar.js"></script>
<script type="text/javascript" src="<%=basePath%>jquery/jquery-1.8.0.min.js"></script>
<script src="<%=basePath%>js/ajaxfileupload.js"></script>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="<%=basePath%>jquery/jquery-1.8.0.min.js"></script>
<script type="text/javascript"  src="<%=basePath%>js/showdate.js"></script>
<script type="text/javascript" src="<%=basePath%>lhgcalendar/lhgcore.js"></script>
	<script type="text/javascript" src="<%=basePath%>lhgcalendar/lhgcalendar.js"></script>
	<style type="text/css">
table.version {
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
#down_center{
position:relative;
 left:250px;
width:1100px;
}
#fundiv{
display:none;
}
#funtr{
display:none;
}
#div1{
display: none;
position: absolute;
left:600px;
top:20px;
width:300px;
height:400px;
background-color:white;
text-align: center;
border:1px solid #999;
padding:3px;"
}
#progressBar{
position: relative;
left:160px;
width:600px;
top:350px;
display: none;


}
.modal-title{
position: relative;
left:160px;
width:620px;
top:356px;
display: none;

}
.percentage{
position: relative;
left:760px;
width:600px;
top:350px;
display: none;

}
</style>
<script type="text/javascript">
function addVersion(){
if(document.getElementById("msg3").innerHTML ==""){
	    /* var Sys = {};
        var ua = navigator.userAgent.toLowerCase();
        window.ActiveXObject ? Sys.ie = ua.match(/msie ([\d.]+)/)[1] :
        document.getBoxObjectFor ? Sys.firefox = ua.match(/firefox\/([\d.]+)/)[1] :
        window.MessageEvent && !document.getBoxObjectFor ? Sys.chrome = ua.match(/chrome\/([\d.]+)/)[1] :
        window.opera ? Sys.opera = ua.match(/opera.([\d.]+)/)[1] :
        window.openDatabase ? Sys.safari = ua.match(/version\/([\d.]+)/)[1] : 0;*/

	 var form = document.forms[0];
	 //版本号
    var verCode= document.getElementsByName("verCode")[0].value;
	 //版本名称
	var versionname= document.getElementsByName("versionname")[0].value;
	 //操作说明
	var operName= document.getElementsByName("file1")[0].value;
    //版本描述
	//var description= document.getElementsByName("description")[0].value;
	 var description= document.getElementById("description").value;
	/* var chk_value =[];//定义一个数组  
     $('input[name="function"]:checked').each(function(){//遍历每一个名字为interest的复选框，其中选中的执行函数  
     chk_value.push($(this).val());//将选中的值添加到数组chk_value中  
     });
     var chk_value =[];//定义一个数组  
     $('input[name="function"]:checked').each(function(){//遍历每一个名字为interest的复选框，其中选中的执行函数  
     chk_value.push($(this).val());//将选中的值添加到数组chk_value中  
     });*/
	if(verCode==""){
		document.getElementById("msg1").innerHTML = "<font color='red'> 版本号不能为空</font>";
		return false;
	}if(verCode!=""){
		document.getElementById("msg1").innerHTML = "";
	}
		if(verCode.length>50){
		document.getElementById("msg1").innerHTML = "<font color='red'> 版本号最大字数不能超过50</font>";
				return false;
	}
	if(versionname==""){
		document.getElementById("msg2").innerHTML = "<font color='red'> 版本名称不能为空</font>";
		return false;
	}
	if(versionname!=""){
		document.getElementById("msg2").innerHTML = "";
	}
		if(versionname.length>50){
		document.getElementById("msg2").innerHTML = "<font color='red'> 版本名称最大字数不能超过50</font>";
				return false;
	}
	if(operName==""){
		document.getElementById("msg3").innerHTML = "<font color='red'>操作说明不能为空</font>";
		return false;
	}
	if(operName!=""){
		document.getElementById("msg3").innerHTML = "";
			
	}
	/*if(chk_value==""){
		document.getElementById("msg6").innerHTML = "<font color='red'> 您未选择任何功能</font>";
		return false;
	}
	if(chk_value!=""){
		document.getElementById("msg6").innerHTML = "";
	}*/
	if(description.trim().length==0){
		document.getElementById("msg4").innerHTML = "<font color='red'> 版本描述不能为空</font>";
		return false;
	}
	if(description.trim().length!=0){
		document.getElementById("msg4").innerHTML = "";
		
	}
		if(description.trim().length>50){
		document.getElementById("msg4").innerHTML = "<font color='red'> 版本描述的最大字数不能超过200</font>";
		return false;
	}
	var chk_value=document.getElementById("funList1").value;
	if(chk_value==""){
		document.getElementById("msg6").innerHTML = "<font color='red'> 对应的功能不能为空</font>";
		return false;
	}
	if(chk_value!=""){
		document.getElementById("msg6").innerHTML = "";
		 document.forms.myform.funList.value =chk_value;
		
	}
 document.getElementById("percentage").style.display="block";
          document.getElementById("progressBar").style.display="block";
          document.getElementById("myModalLabel").style.display="block";
    document.getElementById("percentage").style.display="block";
document.getElementById("progressBar").style.display="block";
document.getElementById("myModalLabel").style.display="block";
 alert("如果上传文件过大，请耐心等待，勿重复点击");
      form.enctype="multipart/form-data";
	 	 form.action = "${pageContext.request.contextPath}/installVersion/insertInversion"; 
	 	 form.method = "post";  
	     form.submit(); 		
    	  var fileObj = document.getElementById("file1").files[0]; // js 获取文件对象  
     var FileController = "${pageContext.request.contextPath}/function/progress1";
        var form1 = new FormData();  
        form1.append("author", "hooyes"); // 可以增加表单数据  
        form1.append("file", fileObj); // 文件对象  
       var xhr = new XMLHttpRequest();  
        xhr.open("post", FileController, true);
        xhr.onload = function() {  
    };     
       xhr.upload.addEventListener("progress", progressFunction, false);  
       xhr.send(form1);  
    }
   }
    function progressFunction(evt) {  
        var progressBar = document.getElementById("progressBar");  
  
        var percentageDiv = document.getElementById("percentage");  
  
        if (evt.lengthComputable) {  
 
            progressBar.max = evt.total;  
  
            progressBar.value = evt.loaded;  
            percentageDiv.innerHTML = Math.round(evt.loaded / evt.total * 100)  
                    + "%";  
  
        }  
  
    }  
	

	function OpenDiv(){
		document.getElementById("div1").style.display="block";
		document.getElementById("open").style.display="none";
		document.getElementById("div1").style.overflow="scroll";
		document.getElementById("title").style.display="none";
		document.getElementById("version").style.display="none";
		}

		function CloseDiv(){
		document.getElementById("div1").style.display="none";
		document.getElementById("open").style.display="block";
		document.getElementById("title").style.display="block";
		document.getElementById("version").style.display="block";
		}
		function backList(){
			 var form = document.forms[0];
			 form.action = "${pageContext.request.contextPath}/installVersion/queryInsatllVersion/${userid}"; 
			 form.method = "post";  
		    form.submit();    
		}
		function  OpenWin1(){
			window.open ("funList.jsp","","top=250,left=650,width=277,height=500");
		}
		function fileChange(target) {
		var str=$("#file1").val();
var arr=str.split('\\');
var my=arr[arr.length-1];
  var isIE = /msie/i.test(navigator.userAgent) && !window.opera;  
     var fileSize = 0;         
     if (isIE && !target.files) {     
       var filePath = target.value;     
       var fileSystem = new ActiveXObject("Scripting.FileSystemObject");        
       var file = fileSystem.GetFile (filePath);     
       fileSize = file.Size;    
     } else {    
      fileSize = target.files[0].size;     
      }   
      var size = fileSize / 1024;  
      if(my.length>50){
      document.getElementById("msg3").innerHTML = "<font color='red'>文件名称个数不能超过50</font>";
      }
      if(size>500000){  
     	document.getElementById("msg3").innerHTML = "<font color='red'> 文件大小不能超过500</font>";
       target.value="";
       return;
      }
       if(size<=500000&&my.length<=50){
      document.getElementById("msg3").innerHTML ="";
      }
      var name=target.value;
      var fileName = name.substring(name.lastIndexOf(".")+1).toLowerCase();
      if(fileName !="xls" && fileName !="xlsx"&&fileName !="txt"&&fileName !="docx"&&fileName !="zip"&&fileName !="rar"&&fileName !="doc"){
     	document.getElementById("msg3").innerHTML = "<font color='red'> 只支持xls,xlsx,txt,docx,zip,rar,doc格式文件上传</font>";
          target.value="";
          return;
      }
    } 
     function keypress() //textarea输入长度处理   
{   
var text1=document.getElementById("description").value;   
var len;//记录剩余字符串的长度   
len=200-text1.length;   
var show="你还可以输入"+len+"个字";   
document.getElementById("msg4").innerText=show;   
if(parseInt(len)<0) {
document.getElementById("msg4").innerText="已超过最大字数";
return false;
}
}   
</script>

</head>
<body style="overflow:-Scroll;overflow-x:hidden">
<div id="div1">
<table>
<c:forEach var="fun" items="${funList}" varStatus="vs">
              <td><input name="function" type="checkbox" id="function" value="${fun.id}"/>${fun.name}</td>
             <c:if test="${vs.count % 3== 0}">
</tr>
</c:if>
       </c:forEach>
</table>
   <a href="javascript:CloseDiv();">确认</a>
</div>
<div class="title" ><h2 id="title">版本添加</h2></div>
<form name="myform">
<input type="hidden" name="operName1" value=""> 
<input type="hidden" name="funList"  id="funList" value="">
<input type="hidden" name="funList1"  id="funList1" value="">
<input type="hidden" name="userid" id="userid" value="${userid}">
<table class="version" id="version">
<tr id="versioncode">
<td>版本号</td>
<td><input name="verCode" type="text" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg1').innerHTML=''"/>
<div style="display: inline" id="msg1"></div></td>
</tr>
<tr>
<td>版本名称</td>
<td><input name="versionname" type="text" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg2').innerHTML=''"/>
<div style="display: inline" id="msg2"></div></td></tr>
<tr>
<td>操作说明</td>
<!--  <td><input type="file" id="alais"  name="alais" /onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg3').innerHTML=''"  onchange="fileChange(this);"/>
<input type="file" id="alais"  name="alais" /onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg3').innerHTML=''"/>
<input type="file" id="alais"  name="alais" /onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg3').innerHTML=''"/>
<div style="display: inline" id="msg3"></div></td>-->
<td><input type="file" name="file1" id="file1" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg3').innerHTML=''"  onchange="fileChange(this);"/> 
<!--  <input type="text" name="operName" /><br />  -->
<div style="display: inline" id="msg3"></div> </td>
</tr>
<tr>
<!--  <td>安装程序</td>
<td>
<select name="program" id="program" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg5').innerHTML=''"/>
<option value="0" selected="selected">请选择</option>
<c:forEach var="version" items="${requestScope.installAllList}" varStatus="vs">
  <option value="${version.program.id}">${version.program.pgName}</option>          
       </c:forEach>
</select>
<div style="display: inline" id="msg5"></div></td>
-->
</tr>
 <tr>
<div class="fundiv" id="fundiv"></div>
<tr id="funtr">
<c:forEach var="fun" items="${funList}" varStatus="vs">
              <td><input name="function" type="checkbox" id="function" value="${fun.id}"/>${fun.name}</td>
             <c:if test="${vs.count % 3 == 0}">

</c:if>
       </c:forEach>
</tr>
<!-- <td>
<select name="function" id="function" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg6').innerHTML=''"/>
<option value="0" selected="selected">请选择</option>
<c:forEach var="version" items="${requestScope.installAllList}" varStatus="vs">
  <option value="${version.functionmodule.id}">${version.functionmodule.name}</option>          
       </c:forEach>
</select>
<div style="display: inline" id="msg6"></div></td>-->
</tr>
<tr>
<td>版本描述</td>
<td>
<textarea name="description" id="description" rows="15" cols="30" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg4').innerHTML=''"   onblur="keypress()"/>  </textarea>
<div style="display: inline" id="msg4"></div></td>
</tr>
<!-- <tr><td><input type="button" value="点击显示功能列表" onclick="javascript:OpenDiv();" id="open"><div style="display: inline" id="msg6"></td></tr>-->
<tr><td><input type="button" value="点击显示功能列表" onclick="javascript:OpenWin1();" id="open"  target="_blank" ><div style="display: inline" id="msg6">勾选的功能为</td>
<td><input " name="funList2"  id="funList2" size="40" value="" readonly="readonly"></td></tr>
<tr><td><input type="button"  value="添加" onclick="addVersion();" ></td>
 <td><input type="button" value="返回版本列表" onclick="backList()"></td>
 </tr>
</table>
</form>
 <div class="modal fade" id="myModal" tabindex="-1" role="dialog"  
        aria-labelledby="myModalLabel" aria-hidden="true">  
        <div class="modal-dialog">  
            <div class="modal-content">  
                <div class="modal-header">  
                    <h4 class="modal-title" id="myModalLabel"  >文件上传进度(若文件过大可能会有几秒延迟,请耐心等待)</h4>  
                </div>  
                <div class="modal-body">  
                    <progress id="progressBar" value="0" 
                       > </progress>  
                    <span id="percentage"  class="percentage" style="color:blue;" ></span> <br>  
                    <br>  
                 
</body>
</html>