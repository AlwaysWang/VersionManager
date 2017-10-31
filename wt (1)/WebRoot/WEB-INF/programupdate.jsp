<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
     <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
System.out.println(basePath);
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<script type="text/javascript" src="<%=basePath%>jquery/jquery-1.8.0.min.js"></script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript">
function doupdate(id){
if(document.getElementById("msg7").innerHTML ==""&&document.getElementById("msg3").innerHTML ==""){
	//var Sys = {};
        //var ua = navigator.userAgent.toLowerCase();
       /* window.ActiveXObject ? Sys.ie = ua.match(/msie ([\d.]+)/)[1] :
        document.getBoxObjectFor ? Sys.firefox = ua.match(/firefox\/([\d.]+)/)[1] :
        window.MessageEvent && !document.getBoxObjectFor ? Sys.chrome = ua.match(/chrome\/([\d.]+)/)[1] :
        window.opera ? Sys.opera = ua.match(/opera.([\d.]+)/)[1] :
        window.openDatabase ? Sys.safari = ua.match(/version\/([\d.]+)/)[1] : 0;*/
	 var form = document.forms[0]; 
   //程序名称
	var programname= document.getElementsByName("programname")[0].value;
   //程序支持语言类型
   var languagetype=document.getElementsByName("languagetype")[0].value;
   //程序支持系统类型
   var systemtype=document.getElementsByName("systemtype")[0].value;
   //最后版本信息
	var pgedition= document.getElementsByName("pgEdition")[0].value;
   //配置文件说明
	 var progdisc= document.getElementsByName("files")[0].value;
   //程序存放位置
   var storagepath=document.getElementsByName("files")[1].value;
   //程序描述
	  var descripton= document.getElementsByName("descripton")[0].value;
	  if(programname.trim().length==0){
		document.getElementById("msg1").innerHTML = "<font color='red'> 程序名称不能为空</font>";
		return false;
	}
		  if(programname.length>50){
		document.getElementById("msg1").innerHTML = "<font color='red'> 程序名称字数不能超过50</font>";
		return false;
	}
	  if(languagetype==0){
			document.getElementById("msg5").innerHTML = "<font color='red'> 程序支持语言类型不能为空</font>";
			return false;
		}
	  if(languagetype!=0){
			document.getElementById("msg5").innerHTML = "";
		}
	  if(systemtype==0){
			document.getElementById("msg6").innerHTML = "<font color='red'> 程序支持系统不能为空</font>";
			return false;
		}
	  if(systemtype!=0){
			document.getElementById("msg6").innerHTML = "";
		}
	  if(pgedition==0){
			document.getElementById("msg2").innerHTML = "<font color='red'> 最后版本信息不能为空</font>";
			return false;
		}
		 if(pgedition.length>50){
			document.getElementById("msg2").innerHTML = "<font color='red'> 最后版本信息字数不能超过50</font>";
			return false;
		}
	  if(pgedition!=0){
			document.getElementById("msg2").innerHTML = "";
		}
	if(descripton.trim().length==0){
		document.getElementById("msg4").innerHTML = "<font color='red'> 程序描述不能为空</font>";
		return false;
	}
	if(descripton.length>50){
		document.getElementById("msg4").innerHTML = "<font color='red'> 程序描述字数不能超过200</font>";
		return false;
	}
	if(storagepath==""&&progdisc==""){
	alert("修改成功");
	form.enctype="multipart/form-data"; 
	 form.action = "${pageContext.request.contextPath}/program/doupdateprogram"; 
	 document.forms.myform.id.value = id;
	 form.method = "post";  
     form.submit(); 
     }
     else{
		  document.getElementById("percentage").style.display="block";
          document.getElementById("progressBar").style.display="block";
          document.getElementById("myModalLabel").style.display="block";
		  form.enctype="multipart/form-data";
	 	 form.action = "${pageContext.request.contextPath}/program/doupdateprogram"; 
	 	  alert("如果上传文件过大，请耐心等待，勿重复点击");
	 	  document.forms.myform.id.value = id;
	 	 form.method = "post";  
	     form.submit(); 
	     var fileObj;
	      var fileObj1= document.getElementById("progdisc").files[0];
   var fileObj2= document.getElementById("storagepath").files[0]; 
	     if(storagepath!=""&&progdisc!=""){
 var size1=document.getElementById("progdisc").files[0].size;
    var size2=document.getElementById("storagepath").files[0].size;
   if( size1>  size2){
   fileObj=fileObj1;
   }
   else{
     fileObj=fileObj2;
   }
      
   }
      if(storagepath==""){
        fileObj=fileObj1;
   }
   if(progdisc==""){
   fileObj=fileObj2;
   }
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

window.onload=function(){ 
	    var opts=document.getElementById('languagetype').options;
	    var obj=new Object(),index=0;
	    while(index<opts.length){
	    	if(opts[index].text in obj) opts[index]=null;
	    	else{
	    		obj[opts[index].text]=opts[index].text;
	    		index++;
	    	}
	    }
	    obj=null;
	    
	    
	     var opts1=document.getElementById('systemtype').options;
	    var obj1=new Object(),index=0;
	    while(index<opts1.length){
	    	if(opts1[index].text in obj1) opts1[index]=null;
	    	else{
	    		obj1[opts1[index].text]=opts1[index].text;
	    		index++;
	    	}
	    }
	    obj1=null;
	    
	    var opts2=document.getElementById('pgEdition').options;
	    var obj2=new Object(),index=0;
	    while(index<opts2.length){
	    	if(opts2[index].text in obj2) opts2[index]=null;
	    	else{
	    		obj2[opts2[index].text]=opts2[index].text;
	    		index++;
	    	}
	    }
	    obj2=null;
	    
	}
function backList(){
	 var form = document.forms[0];
	 form.action = "${pageContext.request.contextPath}/program/queryAllProgram/${userid}"; 
	 form.method = "post";  
     form.submit();    
}
 function fileChange(target) {
 			var str=$("#progdisc").val();
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
      document.getElementById("msg7").innerHTML = "<font color='red'>文件名称个数不能超过50</font>";
      }   
      if(size>500000){  
     	document.getElementById("msg7").innerHTML = "<font color='red'> 文件大小不能超过500</font>";
       target.value="";
       return
      }
          if(size<=500000&&my.length<=50){
      document.getElementById("msg7").innerHTML ="";
      }
      var name=target.value;
      var fileName = name.substring(name.lastIndexOf(".")+1).toLowerCase();
      if(fileName !="xls" && fileName !="xlsx"&&fileName !="txt"&&fileName !="docx"&&fileName !="zip"&&fileName !="rar"&&fileName !="doc"){
     	document.getElementById("msg7").innerHTML = "<font color='red'> 只支持xls,xlsx,txt,docx,zip,rar,doc格式文件上传</font>";
          target.value="";
          return;
      }
    } 
 function fileChange1(target) {
 	var str=$("#storagepath").val();
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
       return
      }
        if(size<=500000&&my.length<=50){
      document.getElementById("msg3").innerHTML ="";
      }
      var name=target.value;
      var fileName = name.substring(name.lastIndexOf(".")+1).toLowerCase();
      if(fileName !="xls" && fileName !="xlsx"&&fileName !="txt"&&fileName !="docx"&&fileName !="zip"&&fileName !="rar"&&fileName !="doc"){
     	document.getElementById("msg3").innerHTML = "<font color='red'> 只支持xls,xlsx,txt,docx,zip,rar,doc格式文件上传</font>";
          target.value="";
          return
      }
    } 
function keypress() //textarea输入长度处理   
{   
var text1=document.getElementById("descripton").value;   
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
<style type="text/css">
table.program {
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
#progressBar{
position: relative;
left:160px;
width:600px;
top:360px;
display: none;


}
.modal-title{
position: relative;
left:160px;
width:750px;
top:366px;
display: none;

}
.percentage{
position: relative;
left:760px;
width:600px;
top:366px;
display: none;

}
</style>


</head>
<body style="overflow:-Scroll;overflow-x:hidden">
<div class="title"><h2>程序维护</h2>
<h4>(提示：未选择文件则默认原来程序和程序配置文件）</h4>
</div>
<form name="myform">
<input   type="hidden" name="id" value="">
<input   type="hidden" name="userid" value="${userid}">  
<table class="program">
<tr>
<td>程序名称</td>
<td><input name="programname" id="programname" type="text" value=${program.pgName} />
<div style="display: inline" id="msg1"></div></td>
</tr>
<tr>
<td>程序支持语言类型</td>
<td>
<select name="languagetype" id="languagetype">
<option value="${program.languageType}" selected="selected">${program.languageType}</option>
<!--<c:forEach items="${requestScope.pgAllList}" var="pg" varStatus="vs">-->
<!--<c:forEach items="${pg.funList}" var="fun" varStatus="vs">
 <option value="${fun.testCode}">${fun.testCode}</option>
</c:forEach>
</c:forEach>-->
<option value="c语言">c语言</option>
<option value="java语言">Java语言</option>
</select>
<div style="display: inline" id="msg5"></div>
</td>
</tr>
<td>程序支持系统类型</td>
<td>
<select name="systemtype" id="systemtype">
<option value="${program.systemType}" selected="selected">${program.systemType}</option>
<option value="windows系统">windows系统</option>
<option value="linux系统">linux系统</option>
<option value="linux系统">通用</option>
</select>
<div style="display: inline" id="msg6"></td>
</tr>
<tr>
<td>最后版本信息</td>
<td><input name="pgEdition" id="pgEdition" type="text" value=${program.pgEdition} />
<!--  <td onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg2').innerHTML=''"/ >-->
<!--  <select name="pgEdition" id="pgEdition">
<option value="${program.pgEdition} " selected="selected">${program.pgEdition}</option>
  <c:forEach var="version" items="${versionList}" varStatus="vs">
             <option value="${version.remark}">${version.remark}</option>
       </c:forEach>
</select>-->
<div style="display: inline" id="msg2"></div></td>
</tr>
<tr>
<td>程序配置说明文件</td>
  <td><input type="file" id="progdisc" name="files" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg3').innerHTML=''"
   onchange="fileChange(this);"/>
<div style="display: inline" id="msg7"></div></td></tr>
</tr>
<tr>
<td>上传程序</td>
<td><input type="file" id="storagepath" name="files" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg3').innerHTML=''"
 onchange="fileChange1(this);"/>
<div style="display: inline" id="msg3"></div></td></tr>
</tr>
<tr>
<td>程序描述</td>
<td>
<textarea name="descripton"  id="descripton" rows="15" cols="30"  onblur="keypress()"> ${program.remark} </textarea>
<div style="display: inline" id="msg4"></div></td>
</tr>
<tr><td><input type="button" value="确认修改" onclick="doupdate('${ requestScope.program.id}')"></td>
<td><input type="button" value="返回程序列表" onclick="backList()"></td>
</tr>
</table>
</form>
<div id="down_center"></div>	
<div id="pagebottom"></div>
<div id="pro" class="pro" align="left">
 <img alt="" src="photo/progress.png" width="0" height="15" id="imgpro">
</div>
 <span id="prop" style="width:15px;height:15px;display: none;">0%</span>
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