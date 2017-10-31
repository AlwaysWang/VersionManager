<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
        <%
String  path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<style type="text/css">  
.file-box {  
    position: relative;  
    width: 340px  
}  
  
.txt {  
    height: 22px;  
    border: 1px solid #cdcdcd;  
    width: 180px;  
    vertical-align: middle;  
    margin: 0;  
    padding: 0  
}  
  
.btn {  
    border: 1px solid #CDCDCD;  
    height: 24px;  
    width: 70px;  
    vertical-align: middle;  
    margin: 0;  
    padding: 0  
}  
  
.file {  
    position: absolute;  
    top: 0;  
    right: 80px;  
    height: 24px;  
    filter: alpha(opacity :   0);  
    opacity: 0;  
    width: 260px;  
    vertical-align: middle;  
    margin: 0;  
    padding: 0  
}  
</style>  
<script type="text/javascript"  src="<%=basePath%>js/showdate.js"></script>
<script type="text/javascript">
function insertFun(){
	 var form = document.forms[0];  
	 //功能名称
	 var functionname= document.getElementsByName("functionname")[0].value;
	 //调试手册
	 var debugFile= document.getElementsByName("debugFile")[0].value;
	 //var dubugFile=document.getElementById("upload").value;
	 //功能描述
	 var description= document.getElementById("description").value;
	 //测试类别
	 var typetest=$("#typetest").find("option:selected").text();
	 //var typetest= document.getElementsByName("typetest")[0].value;
	 //测试类型
	// var testCode= document.getElementsByName("testCode")[0].value;
	 var testCode=$("#testCode").find("option:selected").text();
	 /*var chk_value =[];//定义一个数组  
     $('input[name="program"]:checked').each(function(){//遍历每一个名字为interest的复选框，其中选中的执行函数  
     chk_value.push($(this).val());//将选中的值添加到数组chk_value中  
     });*/
	 var r = new RegExp("^[1-2]\\d{3}-(0?[1-9]||1[0-2])-(0?[1-9]||[1-2][1-9]||3[0-1])$");
	 if(functionname.trim().length==0){
		document.getElementById("msg1").innerHTML = "<font color='red'> 功能名称不能为空</font>";
		return false;
	}
	 if(functionname.trim().length!=0){
			document.getElementById("msg1").innerHTML = "";
			
		}
			if(functionname.length>25){
			document.getElementById("msg1").innerHTML = "<font color='red'> 功能名称字数不能超过25</font>";
				return false;
		}
	 if(typetest=="请选择"){
			document.getElementById("msg4").innerHTML = "<font color='red'>测试类别不能为空</font>";
			return false;
		} if(typetest!="请选择"){
			document.getElementById("msg4").innerHTML = "";
		}
			if(testCode==""){
			document.getElementById("msg4").innerHTML = "<font color='red'>测试类别没有具体测试类型</font>";
		return false;
		}
	  if(debugFile==""){
		document.getElementById("msg2").innerHTML = "<font color='red'> 调试手册不能为空</font>";
		return false;
	}
	  if(debugFile!=""){
			document.getElementById("msg2").innerHTML ="";
			
		}
	  var chk_value=document.forms.myform.programlist1.value;
if(chk_value==""){
	document.getElementById("msg7").innerHTML = "<font color='red'>对应程序不能为空</font>";
	return false;
}
if(chk_value!=""){
	document.getElementById("msg7").innerHTML = "";
	document.forms.myform.programlist.value =chk_value;
}

	 if(description.trim().length==0){
		document.getElementById("msg3").innerHTML = "<font color='red'> 功能描述不能为空</font>";
		return false;
	}
	 if(description.trim().length!=0){
			document.getElementById("msg3").innerHTML = "";
			
		}
			 if(description.length>50){
	document.getElementById("msg3").innerHTML = "<font color='red'> 功能描述字数不能超过50</font>";
		return false;	
		}
			alert("功能添加成功");
	     form.enctype="multipart/form-data";
	 	 form.action = "${pageContext.request.contextPath}/function/functionprotect/insertFunction"; 
	 	 form.method = "post";  
	     form.submit(); 					
}
function selectChecked(){
document.getElementById("msg4").innerHTML = "";
	var typename=$("#typetest option:checked").text();
	  $("#testCode").empty();
	$.ajax({
	   type: "POST",
	   url: "${pageContext.request.contextPath}/function/typetest",
	   data: "typename="+typename+"",
	 // dateType:"json",
	   success: function(value){
	
	  
	  msg=value.list;
	  msg1=value.list1;
	  var obj = document.getElementById("testCode");
	  for(var i=0;i<msg.length;i++){
	  obj.options[i]= new Option(msg[i],msg1[i]);
	
	  }
	  } 
	});
	}
window.onload=function(){ 
	 var opts=document.getElementById('testCode').options;
	    var obj=new Object(),index=0;
	    while(index<opts.length){
	    	if(opts[index].text in obj) opts[index]=null;
	    	else{
	    		obj[opts[index].text]=opts[index].text;
	    		index++;
	    	}
	    }
	    obj=null;
		
	var opts1=document.getElementById('typetest').options;
	var obj1=new Object(),index=0;
	while(index<opts1.length){
		if(opts1[index].text in obj1) opts1[index]=null;
		else{
			obj1[opts1[index].text]=opts1[index].text;
			index++;
		}
	}
	obj1=null;
		
}
function backList(){
	 var form = document.forms[0];
	 form.action = "${pageContext.request.contextPath}/function/queryAllFun/${userid}"; 
	 form.method = "post";  
    form.submit();    
}
	function  OpenWin1(){
		window.open ("pgList.jsp","","top=250,left=650,width=277,height=500");
	}
	function fileChange(target) {
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
      if(size>500000){  
     	document.getElementById("msg2").innerHTML = "<font color='red'> 文件大小不能超过500</font>";
       target.value="";
       return
      }
      else{
      document.getElementById("msg2").innerHTML ="";
      }
      var name=target.value;
      var fileName = name.substring(name.lastIndexOf(".")+1).toLowerCase();
      if(fileName !="xls" && fileName !="xlsx"&&fileName !="txt"&&fileName !="docx"&&fileName !="zip"&&fileName !="rar"&&fileName !="doc"){
     	document.getElementById("msg2").innerHTML = "<font color='red'> 只支持xls,xlsx,txt,docx,zip,rar,doc格式文件上传</font>";
          target.value="";
          return
      }
      else{
      document.getElementById("msg2").innerHTML ="";
      }
    } 
    function keypress() //textarea输入长度处理   
{   
var text1=document.getElementById("description").value;   
var len;//记录剩余字符串的长度   
len=50-text1.length;   
var show="你还可以输入"+len+"个字";   
document.getElementById("msg3").innerText=show;   
if(parseInt(len)<0) {
document.getElementById("msg3").innerText="已超过最大字数";
return false;
}
}   
  function UpladFile() {  
        var fileObj = document.getElementById("debugFile").files[0]; // js 获取文件对象  
        var FileController = "${pageContext.request.contextPath}/function/progress"; // 接收上传文件的后台地址   
        // FormData 对象---进行无刷新上传  
        var form = new FormData();  
        form.append("author", "hooyes"); // 可以增加表单数据  
        form.append("file", fileObj); // 文件对象  
        // XMLHttpRequest 对象  
        var xhr = new XMLHttpRequest();  
        xhr.open("post", FileController, true);  
        xhr.onload = function() {  
            alert("上传完成!");   
        };  

        xhr.upload.addEventListener("progress", progressFunction, false);  
        xhr.send(form);  
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
</script>
</head>
<body style="width: 80%;height: 80%;margin: 0px auto;">  
<div class="title"><h2 id="title">功能添加</h2></div>
<form name="myform">
<input type="hidden" name="programlist"  id="programlist" value="">
<input type="hidden" name="programlist1"  id="programlist1" value="">
<input type="hidden" name="userid"  id="userid" value="${userid}">
<table class="function" id="function">
<tr>
<td>功能名称</td>
<td><input name="functionname" type="text"/>
<div style="display: inline" id="msg1"></div></td>
</tr>
<tr>
<td>测试类别</td>
<td>
<select name="typetest" id="typetest"  onchange="selectChecked();" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg4').innerHTML=''"/>
<option value="0" selected="selected">请选择</option>
<c:forEach var="testType" items="${testTypeAllList}" varStatus="vs">
             <option value="${testType.typeId}">${testType.typeName}</option>
       </c:forEach>
</select>
<div style="display: inline" id="msg4"></div>
</td>
</tr>
<tr>
<td>测试类型</td>
<td>
<select name="testCode" id="testCode"   onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg5').innerHTML=''"/>
<option value="0" selected="selected">请选择</option>
</select>
<div style="display: inline" id="msg5"></div>
</td>
</tr>
  <tr>
<td>调试手册</td>
<td><input type="file" id="upload" name="debugFile" onchange="fileChange(this);"/>
<div style="display: inline" id="msg2"></div></td>
</tr>
<tr>
</tr>
<tr><td><input type="button" value="点击显示程序列表" onclick="javascript:OpenWin1();" id="open"  target="_blank" ><div style="display: inline" id="msg7">勾选的程序为</td>
<td><input  name="programlist2"  id="programlist2"  size="40" value="" readonly="readonly"></td></tr>
<!--<tr><td><input type="button" value="点击显示程序列表" onclick="javascript:OpenDiv();" id="open"><div style="display: inline" id="msg7"></td></tr>-->
<tr>
<td>功能描述</td>
<td>
<textarea name="descripton" rows="15" cols="20" id="description"  onblur="keypress()"/>  </textarea>
<div style="display: inline" id="msg3"></div></td>
</tr>
<tr><td><input type="button" value="确认添加" onclick="insertFun();"></td>
<td><input type="button" value="返回功能列表" onclick="backList()"></td>
</tr>
</table>



</form>


    <!-- 模态框（Modal） -->  
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog"  
        aria-labelledby="myModalLabel" aria-hidden="true">  
        <div class="modal-dialog">  
            <div class="modal-content">  
                <div class="modal-header">  
                    <button type="button" class="close" data-dismiss="modal"  
                        aria-hidden="true">×</button>  
                    <h4 class="modal-title" id="myModalLabel">文件上传进度</h4>  
                </div>  
                <div class="modal-body">  
                    <progress id="progressBar" value="0" max="100"  
                        style="width: 100%;height: 20px; "> </progress>  
                    <span id="percentage" style="color:blue;"></span> <br>  
                    <br>  
                    <div class="file-box">  
                        <input type='text' name='textfield' id='textfield' class='txt' />  
                        <input type='button' class='btn' value='浏览...' /> <input  
                            type="file" name="debugFile" class="debugFile" id="debugFile" size="28"  
                            onchange="document.getElementById('textfield').value=this.value" />  
                        <input type="submit" name="submit" class="btn" value="上传"  
                            onclick="UpladFile()" />  
                          
                    </div>  
                </div>  
                <div class="modal-footer">  
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭  
                    </button>  
                </div>  
            </div>  
        </div>  
    </div>   
</body>  
</html>