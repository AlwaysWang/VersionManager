<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
     <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
System.out.println(basePath);
%>
<script type="text/javascript" src="<%=basePath%>jquery/jquery-1.8.0.min.js"></script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
function selectChecked(){
	$("input[name='module']").each(function () {
       
            $(this).attr("checked",false);
        
    });
	var op=document.getElementById("usertype");
	var userType=op.options[op.selectedIndex].text;
	$.ajax({
		   type: "POST",
		   url: "${pageContext.request.contextPath}/user/getModuleList",
		   data: "usertype="+userType+"",
		  dateType:"json",
		   success: function(value){
		   var msg=eval("("+value+")");
		   //alert(value);
		  // alert(msg);
		  // var items = value.split(/[,，]/g);
		 
		  
		  //var items = $("#hidTags").val().split(/[,，]/g);
		
          $.each(msg, function (index, item) {
              $("input[name='module']").each(function () {
                  if ($(this).val() == item) {
                      $(this).attr("checked",true);
                  }
              });
          });
		  
		  
		  } 
	
		});
	  
 
	//var items = msg.split(/[,，]/g);
    $.each(items, function (index, item) {
        $("input[name='module']").each(function () {
            if ($(this).val() == item) {
                $(this).attr("checked",true);
            }
        });
    });
	
	
}
window.onload=function(){ 
    var opts=document.getElementById('usertype').options;
    var obj=new Object(),index=0;
    while(index<opts.length){
    	if(opts[index].text in obj) opts[index]=null;
    	else{
    		obj[opts[index].text]=opts[index].text;
    		index++;
    	}
    }
    obj=null;
}
/*function confirm(){
	 var moduleName= document.getElementsByName("usertype")[0].value;
	// alert(moduleName);
	// var op=document.getElementById("usertype");
		//var module=op.options[op.selectedIndex].text;
		//alert(module);
	  if(moduleName==0){
			document.getElementById("msg1").innerHTML = "<font color='red'> 用户类别不能为空</font>";
			//document.getElementsByName("module")[0].focus();
			//document.getElementsByName("module")[0].style.borderColor="red";
			//document.getElementsByName("module")[0].style.borderStyle="dotted";
			return false;
		}
	 
	  if(moduleName!=0){
			document.getElementById("msg1").innerHTML = "";
			//document.getElementsByName("moduleName")[0].focus();
			//document.getElementsByName("moduleName")[0].style.borderColor="";
			//document.getElementsByName("moduleName")[0].style.borderStyle="";
			
		}
	
	  var chk_value =[];//定义一个数组  
      $('input[name="module"]:checked').each(function(){//遍历每一个名字为interest的复选框，其中选中的执行函数  
      chk_value.push($(this).val());//将选中的值添加到数组chk_value中  
      });

      $.ajax({
		   type: "POST",
		   url: "${pageContext.request.contextPath}/user/giveuserright",
		   data: {
			    "userid":userId,
			    "username":username,
			    "roleid":roleId,
			    "usertype":userType,
			   // "modulelist": chk_value
		   },
		  //traditional:true,
		  //dateType:"json",
		   success: function(value){
			
		 alert("hello");
		  } 
		   
		});
		
		
	 
	
}*/
</script>
</script>
<style type="text/css">
table.userright {
position:absolute;
 font-family: verdana,arial,sans-serif;
 font-size:20px;
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
 left:160px;
width:1100px;

}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body  style="overflow:-Scroll;overflow-x:hidden">
<div class="title"><h1>权限管理</h1></div>
<table class="userright">
<tr><td>请选择用户的登录类别：</td>
<td><select id="usertype"  onchange="selectChecked()" name="usertype" onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg2').innerHTML=''"/>
<option selected="selected" value="0">请选择</option>
<c:forEach var="user" items="${userList}" varStatus="vs">
             <option value="${user.roleId}">${user.remark}</option>
       </c:forEach>
</select>
<div style="display: inline" id="msg1"></div></td>
</tr>
<tr><td>以下打勾的模块为该类用户可以使用的模块</td></tr>
<c:forEach var="module" items="${moduleList}" varStatus="vs">
             <td><input name="module" type="checkbox" id="module" value="${module.mdId}"/>${module.mdName}</td>
             <c:if test="${vs.count % 2 == 0}">
</tr>

</c:if>
       </c:forEach>
</tr>
  <!--  <tr><td><input type="button" id="confirm" class="confirm" value="查看角色权限" onclick="confirm();"></td>-->
</table>
</body>
</html>