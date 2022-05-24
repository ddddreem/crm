<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<html>
<head>
    <base href="<%=basePath%>"/>
	<meta charset="UTF-8"/>
	<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
	<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(function (){
            // 判断cookie中是否保存账号密码
            if($("#loginAct").val() != null && $("#loginAct").val() != ""){
                // 如果cookie中存在数据，则设置单选框为选中状态
                $("#isRemPwd").prop("checked", true);
			}
            $(window).keydown(function (event) {
                // 给整个浏览器窗口添加键盘按下事件
                if(event.keyCode == 13){
                    // 如果是回车键，则提交登陆请求
                    $("#loginBtn").click();
                }
            });

            // 给登陆按钮绑定单击事件
            $("#loginBtn").click(function () {
                var loginAct = $("#loginAct").val().replace(/^\s+|\s+$/g,'');
                var loginPwd = $("#loginPwd").val().replace(/\s+/g,'');
                var isRemPwd = $("#isRemPwd").prop("checked");
                if(loginAct == '' || loginPwd == ''){
                    // alert("请输入用户名和密码");
                    $("#msg").html("请输入用户名和密码!");
                    return ;
                }
                $("#msg").html("正在玩命加载...");
                $.ajax({
                    type:"post",
                    url: "settings/qx/user/login.do",
                    data:{
                        loginAct:loginAct,
                        loginPwd:loginPwd,
                        isRemPwd:isRemPwd
                    },
                    dataType: "json",
                    success:function (data) {
                        if(data.code == '0'){
                            $("#msg").html(data.message);
                        }else{
                            // 成功则跳转页面
                            window.location.href = "workbench/index.do";
                        }
                    }
                });
            });
        });
    </script>
</head>
<body>
	<div style="position: absolute; top: 0px; left: 0px; width: 60%;">
		<img src="image/IMG_7114.JPG" style="width: 100%; height: 90%; position: relative; top: 50px;">
	</div>
	<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
		<div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">CRM &nbsp;<span style="font-size: 12px;">&copy;2022&nbsp;dreem</span></div>
	</div>
	
	<div style="position: absolute; top: 120px; right: 100px;width:450px;height:400px;border:1px solid #D5D5D5">
		<div style="position: absolute; top: 0px; right: 60px;">
			<div class="page-header">
				<h1>登录</h1>
			</div>
			<form action="workbench/index.html" class="form-horizontal" role="form">
				<div class="form-group form-group-lg">
					<div style="width: 350px;">
						<input class="form-control" id="loginAct" type="text" value="${cookie.loginAct.value}" placeholder="用户名">
					</div>
					<div style="width: 350px; position: relative;top: 20px;">
						<input class="form-control" id="loginPwd" type="password" value="${cookie.loginPwd.value}" placeholder="密码">
					</div>
					<div class="checkbox"  style="position: relative;top: 30px; left: 10px;">
						<label>
							<input id="isRemPwd" type="checkbox"> 十天内免登录
						</label>
						&nbsp;&nbsp;
						<span id="msg" style="color: red"></span>
					</div>
					<button type="button" id="loginBtn" class="btn btn-primary btn-lg btn-block"  style="width: 350px; position: relative;top: 45px;">登录</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>