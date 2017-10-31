<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%
String path =request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
System.out.println(basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>系统公告维护</title>
<script type="text/javascript"  src="<%=basePath%>js/showdate.js"></script>
	<script type="text/javascript" src="<%=basePath%>lhgcalendar/lhgcore.js"></script>
	<script type="text/javascript" src="<%=basePath%>lhgcalendar/lhgcalendar.js"></script>
	<script type="text/javascript" src="<%=basePath%>jquery/jquery-1.8.0.min.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-base.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-all.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-lang-zh_CN.js"></script>
<script type="text/javascript">
function insertNews(){
	 var form = document.forms[0]; 
	 var newstitle= document.getElementsByName("newstitle")[0].value;
	 // var newsdate= document.getElementsByName("newsdate")[0].value;
	 var newscontent= document.getElementsByName("newscontent")[0].value;
	// var newstime = document.getElementById("newstime").value;
	 function checkDate(d){
		   var ds=d.match(/\d+/g),ts=['getFullYear','getMonth','getDate'];
		     var d=new Date(d.replace(/-/g,'/')),i=3;
		     ds[1]--;
		     while(i--)if( ds[i]*1!=d[ts[i]]()) return false;
		     return true;
		    }
	  if(newstitle.trim().length==0){
		document.getElementById("msg1").innerHTML = "<font color='red'> 公告标题不能为空</font>";
		return false;
	}
	if(newstitle.length>100){
	document.getElementById("msg1").innerHTML = "<font color='red'> 公告标题字数不能超过50</font>";
		return false;
	}
	if(newstitle.length<=100){
	document.getElementById("msg1").innerHTML = "";
		
	}
	/*if( newsdate.trim().length==0){
		document.getElementById("msg2").innerHTML = "<font color='red'>公告时间不能为空</font>";
		return false;
	}
	if(newsdate.trim().length!=0){
		 if(checkDate(newstime)==false){
			 document.getElementById("msg2").innerHTML = "<font color='red'> 请输入正确的时间格式</font>";
			 return false;
		 }
		 if(checkDate(newstime)==true){
			 document.getElementById("msg2").innerHTML = "";
		 }
		 
	 }*/
	if(newscontent.trim().length==0){
		document.getElementById("msg3").innerHTML = "<font color='red'> 公告内容不能为空</font>";
		return false;
	}
	if(newscontent.length>1003){
		document.getElementById("msg3").innerHTML = "<font color='red'> 公告内容超过最大字数</font>";
		return false;
	}
		if(newscontent.length<=1003){
		document.getElementById("msg3").innerHTML = "";
	}
	  $.ajax({
    	  //dateType:"json",
			type:"post",
		    url: "${pageContext.request.contextPath}/news/insertnews",
		    data:{newstitle:newstitle,newscontent:newscontent},
		    success:function(value){
		    	document.getElementById("pagebottom").innerHTML = "<font color='black'>公告信息添加成功</font>";
		    	 $("input[name='newstitle']").val("").focus();
		    	 $("textarea[name='newscontent']").val("");
		    }		  
		});	
	
}
function backtNewsList(){
	 var form = document.forms[0]; 
	 form.action = "${pageContext.request.contextPath}/news/querynews/${userid}"; 
	 form.method = "post";  
     form.submit(); 
	
}
function keypress1() //text输入长度处理   
{   
var reg = new RegExp("[\\u4E00-\\u9FFF]+","g");
var text1=document.getElementById("newstitle").value; 
var len=100-text1.length;   
var show="你还可以输入"+len+"个字";   
document.getElementById("msg1").innerText=show;  
if(parseInt(len)<0) {
document.getElementById("msg1").innerText="已超过最大字数";
return false;
}
}   
function keypress2() //textarea输入长度处理   
{   
var text1=document.getElementById("newscontent").value;   
var len;//记录剩余字符串的长度   
len=1000-text1.length;   
var show="你还可以输入"+len+"个字";   
document.getElementById("msg3").innerText=show;   
if(parseInt(len)<0) {
document.getElementById("msg3").innerText="已超过最大字数";
return false;
}
}   
</script>
<style type="text/css">
table.news {
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
top:280px;

}
</style>
</head>
<body style="overflow:-Scroll;overflow-x:hidden">
<form>
<div class="title"><h2>公告维护</h2></div>
<table class="news">
<tr>
<td>公告标题</td>
<td><input name="newstitle" id="newstitle" type="text" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg1').innerHTML=''" />
<div style="display: inline" id="msg1"></div></td>
</tr>
<tr>
<!--  <tr>
<td>公告时间</td>
<td><input name="newsdate" type="text" id="newstime" onclick="J.calendar.get({dir:'right'});"  onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg2').innerHTML=''"/>
<div style="display: inline" id="msg2"></div></td>
</tr>
-->
<tr>
<tr>
<td>公告内容</td>
<td>
<textarea rows="22" cols="22" name="newscontent" id="newscontent" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg3').innerHTML=''" onblur="keypress2()"/>
</textarea>
<div style="display: inline" id="msg3"></div>
</td>
</tr>
<tr>

</tr>
<tr>
<td><input type="button" value="添加" onclick="insertNews()"></td>
<td><input type="button" value="返回公告信息列表" onclick="backtNewsList()"></td>
</tr>
</table>
</form>
<div id="pagebottom"></div>
</body>
</html>