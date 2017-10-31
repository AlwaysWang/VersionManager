<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
System.out.println(basePath);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <link rel="stylesheet" href="style.css" />
<link href='http://fonts.googleapis.com/css?family=Oleo+Script' rel='stylesheet' type='text/css'>
<script type="text/javascript" src="<%=basePath%>jquery/jquery-1.8.0min.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-base.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-all.js"></script>
<script language="javascript" src="<%=basePath%>extjs/ext-lang-zh_CN.js"></script>
<script type="text/javascript">
	function login(){
		var userAccount = document.getElementsByName("userAccount")[0].value;
		var userPass = document.getElementsByName("userPass")[0].value;
		if(userAccount.trim().length==0){
			document.getElementById("msg1").innerHTML = "<font color='red'> 用户名不能为空</font>";
			document.getElementsByName("userAccount")[0].focus();
			document.getElementsByName("userAccount")[0].style.borderColor="red";
			document.getElementsByName("userAccount")[0].style.borderStyle="dotted";
			return false;
		}
		if(userPass.trim().length==0){
			document.getElementById("msg2").innerHTML = "<font color='red'> 密码不能为空</font>";
			document.getElementsByName("userPass")[0].focus();
			document.getElementsByName("userPass")[0].style.borderColor="red";
			document.getElementsByName("userPass")[0].style.borderStyle="dotted";
			return false;
			}
			//var form = document.forms[0]; 
			 //form.action = "${pageContext.request.contextPath}/user/loginon"; 
			 //form.method = "post";  
		    //form.submit();  
	
		Ext.Ajax.request({  
		    url:"<%=basePath%>user/loginon",  
		    method:"POST",  
		   params:{
		    	'userAccount':userAccount,
		    	'userPass':userPass
	    	},  
		    success:function(obj,action){  
		      var jsonData = Ext.util.JSON.decode(obj.responseText);  
		      //  数据请求成功  
		        if(jsonData.success){  
		           window.location.href = "<%=basePath%>user/index";
		      }
		        if(jsonData.success1){  
			           window.location.href = "<%=basePath%>user/index1";
			      }
		        if(jsonData.success2){  
			           window.location.href = "<%=basePath%>user/index2";
			      }
		        if(jsonData.success3){  
		        	document.getElementById("down_center").innerHTML = "<br><font color='red'>该用户还没有拥有登录权限</font>";
			      }
		        else{
				document.getElementById("down_center").innerHTML = "<br><font color='red'>用户名和密码输入错误！</font>";
		        }  
		   },  
		    failure:function(){  
		    document.getElementById("down_center").innerHTML = "<br><font color='red'>用户名和密码输入错误！</font>";
		   }  
	}); 
	}
</script>
<style type="text/css">
body{
	background-image:url(bg.png);
	font-family: 'Oleo Script', cursive;
}

.lg-container{
	width:300px;
	padding:20px 40px;
	border:1px solid #f4f4f4;
	background:rgba(255,255,255,.5);
	-webkit-border-radius:10px;
	-moz-border-radius:10px;

	-webkit-box-shadow: 0 0 2px #aaa;
	-moz-box-shadow: 0 0 2px #aaa;
	position: absolute;
	top:220px;
	left:850px;
	
	
}
.lg-container h1{
	font-size:40px;
	text-align:center;
}
#lg-form > div {
	margin:10px 5px;
	padding:5px 0;

}
#lg-form label{
	display: none;
	font-size: 20px;
	line-height: 25px;
}
#lg-form input[type="text"],
#lg-form input[type="password"]{
	border:1px solid rgba(51,51,51,.5);
	-webkit-border-radius:10px;
	-moz-border-radius:10px;
	padding: 5px;
	font-size: 16px;
	line-height: 20px;
	width: 100%;
	font-family: 'Oleo Script', cursive;
	text-align:center;
}
#lg-form div:nth-child(3) {
	text-align:center;
}
#lg-form button{
	font-family: 'Oleo Script', cursive;
	font-size: 18px;
	border:1px solid #000;
	padding:5px 10px;
	border:1px solid rgba(51,51,51,.5);
	-webkit-border-radius:10px;
	-moz-border-radius:10px;

	-webkit-box-shadow: 2px 1px 1px #aaa;
	-moz-box-shadow: 2px 1px 1px #aaa;
	cursor:pointer;
}
#lg-form button:active{
	-webkit-box-shadow: 0px 0px 1px #aaa;
	-moz-box-shadow: 0px 0px 1px #aaa;
}
#lg-form button:hover{
	background:#f4f4f4;
}
#message{width:100%;text-align:center}
.success {
	color: green;
}
.error {
	color: red;
}
a{
text-decoration: none;
font-size: 35px;
color: black;

}
.head {
margin: 0px opx;


}
.head h1{
text-align: center;
font-size: 40px;}
.remark{
position: absolute;
top: 200px;
left: 30px;
right:750px;
}
.remark p{
font-family: inherit;
font-size: 20px;
}
</style>
    <base href="<%=basePath%>">
    <title>登录页面</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
  </head>
  
  <body>
  <div class="head" style="background-color: gray; height: 100px;" >
  <h1>金硕信息技术有限公司</h1>
   </div>
  <div class="remark" >
  <p>杭州金硕公司创建于1999年，是一家专业从事通信、信息、语音教学等高新技术产品的软件开发、硬件开发、生产和销售的高新技术企业。总部位于“天堂硅谷”——杭州高新技术开发区东部软件园。　　杭州金硕致力于通信IT技术和产品的开发，力求为用户提供从通信自动化到信息自动化的整体解决方案。集团公司浙江杭州金硕科技发展有限公司（控股金世纪房地产公司等多家企业）成立于1993年，是浙江省高新技术企业，在通信领域经营多年，在客户中具有很高的知名度，实力雄厚。 　　公司凝聚了业界一流人才，引进了浙江大学教授、硕士研究生多名，拥有一支年轻、敬业、富有朝气的专业软、硬件开发队伍。同时吸收了浙江大学电教中心、中心实验室、光电系的多位教授参加研究中心的技术开发工作。成功研制、开发与生产了多种通信、信息、语音类等产品。　　公司在通信领域经营多年，产品在客户中具有很高的知名度， 以其功能全、技术优、性能强，遍布国内三十一个省、市、自治区，在同类产品中拥有较高的市场占有。　　我们的经营宗旨是："诚实信用，追求卓越，服务大众，回报社会"。　　公司将以"一流的管理，一流的信誉，一流的产品，一流的服务"，全心全意满足客户的要求，致力在高新领域里不断发展。</p>
</div>
   <div class="lg-container" style="background-color: gray; ">
	<h1>金硕项目登录</h1>
	<form id="lg-form" name="lg-form" method="post">

		<div id="user" style="display: inline-table;">
		    用户名
			<input type="text" name="userAccount" id="userAccount" placeholder="用户名"  onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg1').innerHTML=''"/>
			<div style="display: inline" id="msg1"></div>
		</div>
       <div id="password" style="display: inline-table; " >
       密   码
		<input type="password" name="userPass" id="userPass"     placeholder="用户密码"  onkeydown="this.style.borderColor='';this.style.borderStyle='';document.getElementById('msg2').innerHTML=''" />
		<div style="display: inline" id="msg2"></div>
	</div>
		<div>
			<!-- <button type="submit" id="login" onclick="login()">Login</button> -->
		 <a href="javascript:login()" >登录</a>
		</div>

	</form>
	<div id="down_center"></div>		 
</div>
  </body>
</html>
