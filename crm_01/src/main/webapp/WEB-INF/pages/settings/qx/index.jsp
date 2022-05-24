<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
	<base href="<%=basePath%>">
<meta charset="UTF-8">
<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript">

	//页面加载完毕
	$(function(){
		
		//导航中所有文本颜色为黑色
		$(".liClass > a").css("color" , "black");
		
		//默认选中导航菜单中的第一个菜单项
		$(".liClass:first").addClass("active");
		
		//第一个菜单项的文字变成白色
		$(".liClass:first > a").css("color" , "white");
		
		//给所有的菜单项注册鼠标单击事件
		$(".liClass").click(function(){
			//移除所有菜单项的激活状态
			$(".liClass").removeClass("active");
			//导航中所有文本颜色为黑色
			$(".liClass > a").css("color" , "black");
			//当前项目被选中
			$(this).addClass("active");
			//当前项目颜色变成白色
			$(this).children("a").css("color","white");
		});
		
		//展示市场活动页面
		window.open("permission/index.jsp","workareaFrame");


        // 跳转工作台
        $("#workbenchIndexA").click(function () {
            window.location.href="workbench/index.do";
        });

        // 为退出的模态框中的确定按钮绑定单击事件
        $("#safeLogout").click(function () {
            window.location.href = "settings/qx/user/safeLogout.do";
        });

        // 为修改密码超链接绑定单击事件
        $("#changePasswordA").click(function () {
            $("#editPwdModal").modal("show");
            $("#changePasswordForm")[0].reset();
        });

        // 为保存更新密码绑定单击事件
        $("#updatePasswordBtn").click(function () {
            var newPwd = $.trim($("#newPwd").val());
            var oldPwd = $.trim($("#oldPwd").val());
            var confirmPwd =  $.trim($("#confirmPwd").val());
            if(newPwd != confirmPwd){
                alert("新密码与确认密码不一致...")
                return ;
            }
            $.ajax({
                url:'settings/qx/user/updatePassword.do',
                type:'post',
                data:{
                    oldPwd:oldPwd,
                    newPwd:newPwd
                },
                dataType:'json',
                success:function (data) {
                    if(data.code == '1'){
                        alert("修改成功!");
                        window.location.href = "settings/qx/user/toLogin.do";
                    }else{
                        alert(data.msg);
                    }
                }
            });
        });

        $("#systemSettingsA").click(function () {
            window.location.href = "settings/systemSettingsIndex.do";
        });

        $("#safeLogoutA").click(function () {
            $("#exitModal").modal("show");
        });

        $("#myInfoA").click(function () {
            $("#myInformation").modal("show");
        });

        $("#userAuthorityManageA").click(function () {
            window.open("settings/qx/user/userAuthority.do", "workareaFrame");
        });
	});
	
</script>

</head>
<body>

	<!-- 我的资料 -->
	<div class="modal fade" id="myInformation" role="dialog">
		<div class="modal-dialog" role="document" style="width: 30%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">我的资料</h4>
				</div>
				<div class="modal-body">
					<div style="position: relative; left: 40px;">
						员工ID：<b>${sessionScope.sessionUser.id}</b><br><br>
						姓名：<b>${sessionScope.sessionUser.name}</b><br><br>
						登录帐号：<b>${sessionScope.sessionUser.loginAct}</b><br><br>
						组织机构：<b>${sessionScope.sessionUser.deptno}</b><br><br>
						邮箱：<b>${sessionScope.sessionUser.email}</b><br><br>
						创建时间：<b>${sessionScope.sessionUser.createtime}</b><br><br>
						失效时间：<b>${sessionScope.sessionUser.expireTime}</b><br><br>
						允许访问IP：<b>${sessionScope.sessionUser.allowIps}</b>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 修改密码的模态窗口 -->
	<div class="modal fade" id="editPwdModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 70%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">修改密码</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="oldPwd" class="col-sm-2 control-label">原密码</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="oldPwd" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="newPwd" class="col-sm-2 control-label">新密码</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="newPwd" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="confirmPwd" class="col-sm-2 control-label">确认密码</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="confirmPwd" style="width: 200%;">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="updatePasswordBtn">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 退出系统的模态窗口 -->
	<div class="modal fade" id="exitModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 30%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">离开</h4>
				</div>
				<div class="modal-body">
					<p>您确定要安全退出系统吗？</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="safeLogout">确定</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 顶部 -->
	<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
		<div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">CRM &nbsp;<span style="font-size: 12px;">&copy;2022&nbsp;dreem</span></div>
		<div style="position: absolute; top: 15px; right: 40px;">
			<ul>
				<li class="dropdown user-dropdown">
					<a href="javascript:void(0)" style="text-decoration: none; color: white;" class="dropdown-toggle" data-toggle="dropdown">
						<span class="glyphicon glyphicon-user"></span> ${sessionScope.sessionUser.name} <span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="javascript:void(0);" id="workbenchIndexA"><span class="glyphicon glyphicon-home"></span> 工作台</a></li>
						<li><a href="javascript:void(0);" id="systemSettingsA"><span class="glyphicon glyphicon-wrench"></span> 系统设置</a></li>
						<li><a href="javascript:void(0);" id="myInfoA"><span class="glyphicon glyphicon-file"></span> 我的资料</a></li>
						<li><a href="javascript:void(0);" id="changePasswordA"><span class="glyphicon glyphicon-edit"></span> 修改密码</a></li>
						<li><a href="javascript:void(0);" id="safeLogoutA"><span class="glyphicon glyphicon-off"></span> 安全退出</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- 中间 -->
	<div id="center" style="position: absolute;top: 50px; bottom: 30px; left: 0px; right: 0px;">
	
		<!-- 导航 -->
		<div id="navigation" style="left: 0px; width: 18%; position: relative; height: 100%; overflow:auto;">
		
			<ul id="no1" class="nav nav-pills nav-stacked">
				<li class="liClass"><a href="javascript:void(0);" target="workareaFrame" id="permissionAuthorityManageA"><span class="glyphicon glyphicon-user"></span> 许可维护</a></li>
				<li class="liClass"><a href="javascript:void(0);" target="workareaFrame" id="roleAuthorityManageA"><span class="glyphicon glyphicon-user"></span> 角色维护</a></li>
				<li class="liClass"><a href="javascript:void(0);" target="workareaFrame" id="userAuthorityManageA"><span class="glyphicon glyphicon-user"></span> 用户维护</a></li>
			</ul>
			
			<!-- 分割线 -->
			<div id="divider1" style="position: absolute; top : 0px; right: 0px; width: 1px; height: 100% ; background-color: #B3B3B3;"></div>
		</div>
		
		<!-- 工作区 -->
		<div id="workarea" style="position: absolute; top : 0px; left: 18%; width: 82%; height: 100%;">
			<iframe style="border-width: 0px; width: 100%; height: 100%;" name="workareaFrame"></iframe>
		</div>
		
	</div>
	
	<div id="divider2" style="height: 1px; width: 100%; position: absolute;bottom: 30px; background-color: #B3B3B3;"></div>
	
	<!-- 底部 -->
	<div id="down" style="height: 30px; width: 100%; position: absolute;bottom: 0px;"></div>
	
</body>
</html>