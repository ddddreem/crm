<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

	//默认情况下取消和保存按钮是隐藏的
	var cancelAndSaveBtnDefault = true;
	
	$(function(){
		$("#remark").focus(function(){
			if(cancelAndSaveBtnDefault){
				//设置remarkDiv的高度为130px
				$("#remarkDiv").css("height","120px");
				//显示
				$("#cancelAndSaveBtn").show("2000");
				cancelAndSaveBtnDefault = false;
			}
		});
		// 文本输入框失去焦点事件,隐藏保存和取消按钮
		$("#remark").blur(function(){
		    var noteContent = $("#remark").val();
		    if(noteContent == ""){
                //显示
                $("#cancelAndSaveBtn").hide();
                //设置remarkDiv的高度为90px
                $("#remarkDiv").css("height","80px");
                cancelAndSaveBtnDefault = true;
			}
		});
		
		$("#cancelBtn").click(function(){
			//显示
			$("#cancelAndSaveBtn").hide();
			//设置remarkDiv的高度为130px
			$("#remarkDiv").css("height","80px");
			cancelAndSaveBtnDefault = true;
		});
		
		// $(".remarkDiv").mouseover(function(){
		// 	$(this).children("div").children("div").show();
		// });
		$("#remarkDivList").on("mouseover", ".remarkDiv", function(){
			$(this).children("div").children("div").show();
		});
		$("#remarkDivList").on("mouseout", ".remarkDiv", function(){
            $(this).children("div").children("div").hide();
		});
		$("#remarkDivList").on("mouseover", ".myHref", function(){
            $(this).children("span").css("color","red");
		});
		$("#remarkDivList").on("mouseout", ".myHref", function(){
            $(this).children("span").css("color","#E6E6E6");
		});
		
		// $(".remarkDiv").mouseout(function(){
		// 	$(this).children("div").children("div").hide();
		// });
		//
		// $(".myHref").mouseover(function(){
		// 	$(this).children("span").css("color","red");
		// });
		//
		// $(".myHref").mouseout(function(){
		// 	$(this).children("span").css("color","#E6E6E6");
		// });

        $("#saveActivityRemarkBtn").click(function () {
            var noteContent = $.trim($("#remark").val());
            if(noteContent == ""){
                alert("备注不能为空...");
                return ;
            }
            var activityId = '${activityDetail.id}';
            $.ajax({
                url:'workbench/activity/saveCreateActivityRemark.do',
                type:'post',
                data:{
                    noteContent:noteContent,
                    activityId:activityId
                },
                dataType:'json',
                success:function (data) {
                    if(data.code == "1"){
                        $("#remark").val("");
                        var htmlStr = "";
                        // 刷新备注列表
                        htmlStr+="<div id=\"div_"+ data.extend.createRemark.id +"\" class=\"remarkDiv\" style=\"height: 60px;\">";
                        htmlStr+="<img title=\"${sessionScope.sessionUser.name}\" src=\"image/user-thumbnail.png\" style=\"width: 30px; height:30px;\">";
                        htmlStr+="<div style=\"position: relative; top: -40px; left: 40px;\" >";
                        htmlStr+="<h5>"+ noteContent +"</h5>";
                        htmlStr+="<font color=\"gray\">市场活动</font> <font color=\"gray\">-</font> <b>${activityDetail.name}</b> <small style=\"color: gray;\"> " + data.extend.createRemark.createTime + " 由&nbsp;${sessionScope.sessionUser.name}&nbsp;创建</small>";
                        htmlStr+="<div style=\"position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;\">";
                        htmlStr+="<a class=\"myHref\" name=\"editA\" remarkId=\"" + data.extend.createRemark.id + "\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-edit\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>";
                        htmlStr+="&nbsp;&nbsp;&nbsp;&nbsp;";
                        htmlStr+="<a class=\"myHref\" name=\"deleteA\" remarkId=\"" + data.extend.createRemark.id + "\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-remove\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>";
                        htmlStr+="</div>";
                        htmlStr+="</div>";
                        htmlStr+="</div>";
                        $("#remarkDiv").before(htmlStr);
                        // 隐藏保存取消按钮
                        $("#cancelAndSaveBtn").hide();
                        $("#remarkDiv").css("height","80px");
                        cancelAndSaveBtnDefault = true;
                    }else{
                        alert(data.msg);
                    }
                }
            });
        });
        $("#remarkDivList").on("click", "a[name='deleteA']", function () {
			var id = $(this).attr("remarkId");
			$.ajax({
				url:'workbench/activity/deleteActivityRemarkById.do',
				type:'post',
				data: {
                    id:id
				},
				dataType:'json',
				success:function (data) {
					if(data.code == '1'){
					    // 删除所选备注
                        $("#div_"+id).remove();
					}else{
					    alert(data.msg);
					}
                }
			});
        });
        $("#remarkDivList").on("click", "a[name='editA']", function () {
			var id = $(this).attr("remarkId");
			$("#edit-remarkId").val(id);
			var noteContent = $("#div_"+id+" h5").html();
            $("#edit-noteContent").val(noteContent);
            $("#editRemarkModal").modal("show");
        });
        $("#updateRemarkBtn").click(function () {
			var id = $("#edit-remarkId").val();
			var noteContentBefore = $("#div_"+id+" h5").html();
            var noteContentAfter = $.trim($("#edit-noteContent").val());
            if(noteContentAfter == noteContentBefore){
                alert("备注信息没发生修改, 无需更新...");
                $("#editRemarkModal").modal("show");
                return ;
            }
			$.ajax({
				url:'workbench/activity/updateActivityRemarkById.do',
				type:'post',
				data:{
				    id:id,
					noteContent:noteContentAfter
				},
				dataType:'json',
				success:function (data) {
					if(data.code=='1'){
					    // 成功则更新备注信息,并关闭模态框
                        $("#div_"+id+" h5").text(noteContentAfter);
                        $("#div_"+id+" small").text(""+data.extend.updateRemark.editTime + " 由 ${sessionScope.sessionUser.name} 修改");
                        $("#editRemarkModal").modal("hide");
					}else{
					    // 失败提示失败信息，模态框不关闭
					    alert(data.msg);
                        $("#editRemarkModal").modal("show");
					}
                }
			});
        });
	});
	
</script>

</head>
<body>
	
	<!-- 修改市场活动备注的模态窗口 -->
	<div class="modal fade" id="editRemarkModal" role="dialog">
        <div class="modal-dialog" role="document" style="width: 40%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">修改备注</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form">
						<%-- 备注的id --%>
						<input type="hidden" id="edit-remarkId">
                        <div class="form-group">
                            <label for="edit-noteContent" class="col-sm-2 control-label">内容</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" id="edit-noteContent"></textarea>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="updateRemarkBtn">更新</button>
                </div>
            </div>
        </div>
    </div>

    

	<!-- 返回按钮 -->
	<div style="position: relative; top: 35px; left: 10px;">
		<a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span></a>
	</div>
	
	<!-- 大标题 -->
	<div style="position: relative; left: 40px; top: -30px;">
		<div class="page-header">
			<h3>市场活动-${activityDetail.name} <small>${activityDetail.startDate} ~ ${activityDetail.endDate}</small></h3>
		</div>
		
	</div>
	
	<br/>
	<br/>
	<br/>

	<!-- 详细信息 -->
	<div style="position: relative; top: -70px;">
		<div style="position: relative; left: 40px; height: 30px;">
			<div style="width: 300px; color: gray;">所有者</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${activityDetail.owner}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">名称</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${activityDetail.name}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>

		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">开始日期</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${activityDetail.startDate}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">结束日期</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${activityDetail.endDate}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">成本</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${activityDetail.cost}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 30px;">
			<div style="width: 300px; color: gray;">创建者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${activityDetail.createBy}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">${activityDetail.createTime}</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 40px;">
			<div style="width: 300px; color: gray;">修改者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${activityDetail.editBy}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">${activityDetail.editTime}</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 50px;">
			<div style="width: 300px; color: gray;">描述</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					${activityDetail.description}
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
	</div>
	
	<!-- 备注 -->
	<div id="remarkDivList" style="position: relative; top: 30px; left: 40px;">
		<div class="page-header">
			<h4>备注</h4>
		</div>
        <c:forEach var="remark" items="${activityRemarks}">
            <div id="div_${remark.id}" class="remarkDiv" style="height: 60px;">
                <img title="${remark.createBy}" src="image/user-thumbnail.png"
                     style="width: 30px; height:30px;">
                <div style="position: relative; top: -40px; left: 40px;">
                    <h5>${remark.noteContent}</h5>
                    <font color="gray">市场活动</font> <font color="gray">-</font> <b>${activityDetail.name}</b>
                    <small style="color: gray;"> ${remark.editFlag == '1'?remark.editTime:remark.createTime} 由&nbsp;${remark.editFlag == '1'?remark.editBy:remark.createBy}&nbsp;${remark.editFlag == '1'?"修改":"创建"}</small>
                    <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
                        <a class="myHref" name="editA" remarkId="${remark.id}" href="javascript:void(0);"><span class="glyphicon glyphicon-edit"
                                                                           style="font-size: 20px; color: #E6E6E6;"></span></a>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <a class="myHref" name="deleteA" remarkId="${remark.id}" href="javascript:void(0);"><span class="glyphicon glyphicon-remove"
                                                                           style="font-size: 20px; color: #E6E6E6;"></span></a>
                    </div>
                </div>
            </div>
        </c:forEach>
		<%--<!-- 备注1 -->--%>
		<%--<div class="remarkDiv" style="height: 60px;">--%>
			<%--<img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">--%>
			<%--<div style="position: relative; top: -40px; left: 40px;" >--%>
				<%--<h5>哎呦！</h5>--%>
				<%--<font color="gray">市场活动</font> <font color="gray">-</font> <b>发传单</b> <small style="color: gray;"> 2017-01-22 10:10:10 由zhangsan</small>--%>
				<%--<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">--%>
					<%--<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>--%>
					<%--&nbsp;&nbsp;&nbsp;&nbsp;--%>
					<%--<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>--%>
				<%--</div>--%>
			<%--</div>--%>
		<%--</div>--%>
		<%----%>
		<%--<!-- 备注2 -->--%>
		<%--<div class="remarkDiv" style="height: 60px;">--%>
			<%--<img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">--%>
			<%--<div style="position: relative; top: -40px; left: 40px;" >--%>
				<%--<h5>呵呵！</h5>--%>
				<%--<font color="gray">市场活动</font> <font color="gray">-</font> <b>发传单</b> <small style="color: gray;"> 2017-01-22 10:20:10 由zhangsan</small>--%>
				<%--<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">--%>
					<%--<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>--%>
					<%--&nbsp;&nbsp;&nbsp;&nbsp;--%>
					<%--<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>--%>
				<%--</div>--%>
			<%--</div>--%>
		<%--</div>--%>
		
		<div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
			<form role="form" style="position: relative;top: 10px; left: 10px;">
				<textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"  placeholder="添加备注..."></textarea>
				<p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
					<button id="cancelBtn" type="button" class="btn btn-default">取消</button>
					<button type="button" class="btn btn-primary" id="saveActivityRemarkBtn">保存</button>
				</p>
			</form>
		</div>
	</div>
	<div style="height: 200px;"></div>
</body>
</html>