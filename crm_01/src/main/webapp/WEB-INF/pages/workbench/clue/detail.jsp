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

	//默认情况下取消和保存按钮是隐藏的
	var cancelAndSaveBtnDefault = true;

	function queryUnbundActivity(activityName, clueId){
        $.ajax({
            url:'workbench/clue/queryActivityForDetailByNameClueId.do',
            type:'post',
            data:{
                activityName:activityName,
                clueId:clueId
            },
            dataType:'json',
            success:function (data) {
                if(data.code='1'){
					var htmlStr = "";
                    $.each(data.extend.unbundActivities, function (index, obj) {
                        htmlStr += "<tr>";
                        htmlStr += "<td><input type=\"checkbox\" value=\"" + obj.id + "\"/></td>";
                        htmlStr += "<td>" + obj.name + "</td>";
                        htmlStr += "<td>" + obj.startDate + "</td>";
                        htmlStr += "<td>" + obj.endDate + "</td>";
                        htmlStr += "<td>" + obj.owner + "</td>";
                        htmlStr += "</tr>";
                    });
                    $("#unbundActivitiesTBody").html(htmlStr);
                }else{
                    alert(data.msg);
				}
            }
        });
	}
	
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

        // 为保存备注按钮绑定单击事件
		$("#saveClueremarkBtn").click(function () {
			var noteContent = $.trim($("#remark").val());
            if(noteContent == ""){
                alert("备注不能为空...");
                return ;
            }
			var clueId = '${clueDetail.id}';

			// 发送保存请求
			$.ajax({
				url:'workbench/clue/saveClueRemark.do',
				type:'post',
				data:{
				    noteContent:noteContent,
					clueId:clueId
				},
				dataType:'json',
				success:function (data) {
					if(data.code='1'){
                        $("#remark").val("");
					    var htmlStr = "";
                    	htmlStr += "<div id=\"div_"+ data.extend.createdClueRemark.id +"\" class=\"remarkDiv\" style=\"height: 60px;\">";
                        htmlStr += "<img title=\"${sessionScope.sessionUser.name}\" src=\"image/user-thumbnail.png\" style=\"width: 30px; height:30px;\">";
                        htmlStr += "<div style=\"position: relative; top: -40px; left: 40px;\" >";
                        htmlStr += "<h5>" + noteContent + "</h5>";
                        htmlStr += "<font color=\"gray\">线索</font> <font color=\"gray\">-</font> <b>${clueDetail.fullname}${clueDetail.appellation}-${clueDetail.company}</b> <small style=\"color: gray;\"> " + data.extend.createdClueRemark.createTime + " 由&nbsp;${sessionScope.sessionUser.name}&nbsp;创建</small>";
                        htmlStr += "<div style=\"position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;\">";
                        htmlStr += "<a class=\"myHref\" name=\"editA\" remarkId=\"" + data.extend.createdClueRemark.id + "\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-edit\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>";
                        htmlStr += "&nbsp;&nbsp;&nbsp;&nbsp;";
                        htmlStr += "<a class=\"myHref\" name=\"deleteA\" remarkId=\"" + data.extend.createdClueRemark.id + "\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-remove\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>";
                        htmlStr += "</div>";
                        htmlStr += "</div>";
                        htmlStr += "</div>";
                        $("#remarkDiv").before(htmlStr);
                        // 隐藏保存取消按钮
                        $("#cancelAndSaveBtn").hide();
                        $("#remarkDiv").css("height","90px");
                        cancelAndSaveBtnDefault = true;
					}else{
					    alert(data.msg);
					}
                }
			});
        });

		// 为关联市场活动按钮绑定单击事件
		$("#bundActivityBtn").click(function () {
		    $("#queryRelationActivityInput").val("");
            $("#unbundActivitiesTBody").html("");
			$("#bundModal").modal("show");
        });

		// 为全选按钮绑定单击事件
		$("#checkAll").click(function () {
            $("#unbundActivitiesTBody input[type='checkbox']").prop("checked", this.checked);
        });

        // 为页面中的所有除全选按钮以外的单击事件绑定单击事件
        $("#unbundActivitiesTBody").on("click", "input[type='checkbox']", function () {
            if($("#unbundActivitiesTBody input[type='checkbox']").size() == $("#unbundActivitiesTBody input[type='checkbox']:checked").size()) $("#checkAll").prop("checked", true);
            else $("#checkAll").prop("checked", false);
        });

		// 为查询关联市场活动绑定焦点事件
		$("#queryRelationActivityInput").focus(function () {
            $("#checkAll").prop("checked", false);
		    var activityName = $.trim($("#queryRelationActivityInput").val());
			var clueId = '${clueDetail.id}';
			if(activityName == ""){
                queryUnbundActivity(activityName, clueId);
			}
        });

		// 为查询关联市场活动的输入框绑定键盘弹起事件
        $("#queryRelationActivityInput").keyup(function () {
            $("#checkAll").prop("checked", false);
            var activityName = $.trim($("#queryRelationActivityInput").val());
            var clueId = '${clueDetail.id}';
            queryUnbundActivity(activityName, clueId);
        });

        // 为线索关联市场活动
        $("#bundActivitiesBtn").click(function () {
            var activityIdList = $("#unbundActivitiesTBody input[type='checkbox']:checked");
            var clueId = '${clueDetail.id}';
            if(activityIdList.size() == 0){
                alert("最少关联一条市场活动...");
                $("#bundModal").modal("show");
                return;
            }
            var clueActivity = "";
            $.each(activityIdList, function () {
                clueActivity += "activityId=" + this.value + "&";
            });
            clueActivity += "clueId=" + clueId;
            $.ajax({
                url:'workbench/clue/saveByActivityClueIdList.do',
                type:'post',
                data:clueActivity,
                dataType:'json',
                success:function (data) {
                    if(data.code=='1'){
                        var htmlStr = "";
                        $.each(data.extend.relationActivities, function (index, obj) {
                            htmlStr += "<tr id='tr_" + obj.id + "'>";
                            htmlStr += "<td>" + obj.name + "</td>";
                            htmlStr += "<td>" + obj.startDate + "</td>";
                            htmlStr += "<td>" + obj.endDate + "</td>";
                            htmlStr += "<td>" + obj.owner + "</td>";
                            htmlStr +="<td><a href=\"javascript:void(0);\" relationActivityId=\"" + obj.id + "\" style=\"text-decoration: none;\"><span class=\"glyphicon glyphicon-remove\"></span>解除关联</a></td>;"
                            htmlStr += "</tr>";
                        });
                        $("#clueRemarkTBody").append(htmlStr);
                        $("#bundModal").modal("hide");
                    }else{
                        alert(data.msg);
                    }
                }
            });
        });

        // 为编辑线索备注图标添加单击事件, 弹出修改线索备注模态框
        $("#remarkDivList").on("click", "a[name='editA']", function () {
			var remarkId = $(this).attr("remarkId");
			$("#edit-remarkId").val(remarkId);
			$("#editRemarkModal").modal("show");
            var noteContent = $("#div_" + remarkId + " h5").html();
            $("#edit-noteContent").val(noteContent);
        });

        // 为删除线索备注图标添加单击事件
        $("#remarkDivList").on("click", "a[name='deleteA']", function () {
            var remarkId = $(this).attr("remarkId");
            if(window.confirm("确定要删除该条备注吗？")){
                $.ajax({
					url:'workbench/clue/deleteClueRemarkById.do',
					type:'post',
					data:{
					    id:remarkId
					},
					dataType:'json',
					success:function (data) {
						if(data.code=='1'){
						    $("#div_" + remarkId).remove();
						}else{
						    alert(data.msg);
						}
                    }
				});
			}
        });

        // 为更新线索备注添加单击事件
		$("#updateRemarkBtn").click(function () {
            var remarkId = $("#edit-remarkId").val();
			var noteContentBefore = $("#div_" + remarkId + " h5").html();
			var noteContentAfter = $.trim($("#edit-noteContent").val());
			if(noteContentAfter == "" && window.confirm("是否要删除该条备注信息？")){
                $.ajax({
                    url:'workbench/clue/deleteClueRemarkById.do',
                    type:'post',
                    data:{
                        id:remarkId
                    },
                    dataType:'json',
                    success:function (data) {
                        if(data.code=='1'){
                            $("#div_" + remarkId).remove();
                            $("#editRemarkModal").modal("hide");
                        }else{
                            alert(data.msg);
                        }
                    }
                });
                return ;
			}
			if(noteContentBefore == noteContentAfter){
			    alert("备注信息未发生修改...");
			    return ;
			}
			$.ajax({
				url:'workbench/clue/updateClueRemarkById.do',
				type:'post',
				data:{
				    id:remarkId,
					noteContent:noteContentAfter
				},
				dataType:'json',
				success:function (data) {
				    if(data.code=='1'){
                        // 更新标签中的备注信息
                        $("#div_" + remarkId + " h5").text(noteContentAfter);
                        // 更新修改者信息
                        $("#div_" + remarkId + " small").text("" + data.extend.updateClueRemark.editTime + " 由 ${sessionScope.sessionUser.name} 修改");
                        $("#editRemarkModal").modal("hide");
					}else{
						alert(data.msg);
                        $("#editRemarkModal").modal("show");
					}
                }
			});
        });

		// 为接触关联活动按钮添加单击事件
		$("#clueRemarkTBody").on("click", "a", function () {
			if(window.confirm("确定要解除活动？")){
                var activityId = $(this).attr("relationActivityId");
                var clueId = '${clueDetail.id}';
                $.ajax({
					url:'workbench/clue/deleteRelationByActivityIdAndClueId.do',
					type:'post',
					data:{
					    clueId:clueId,
						activityId:activityId
					},
					success:function (data) {
						if(data.code=='1'){
							$("#tr_" + activityId).remove();
						}else{
						    alert(data.msg);
						}
                    }
				});
			}
        });

		// 为转换按钮绑定单击事件
		$("#convertBtn").click(function () {
			var clueId = '${clueDetail.id}';
			window.location.href = "workbench/clue/convertIndex.do?id=" + clueId;
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

	<!-- 关联市场活动的模态窗口 -->
	<div class="modal fade" id="bundModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">关联市场活动</h4>
				</div>
				<div class="modal-body">
					<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
						<form class="form-inline" role="form">
						  <div class="form-group has-feedback">
						    <input type="text" id="queryRelationActivityInput" class="form-control" style="width: 300px;" placeholder="请输入市场活动名称，支持模糊查询">
						    <span class="glyphicon glyphicon-search form-control-feedback"></span>
						  </div>
						</form>
					</div>
					<table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td><input type="checkbox" id="checkAll"/></td>
								<td>名称</td>
								<td>开始日期</td>
								<td>结束日期</td>
								<td>所有者</td>
								<td></td>
							</tr>
						</thead>
						<tbody id="unbundActivitiesTBody">
						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="bundActivitiesBtn">关联</button>
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
			<h3>${clueDetail.fullname}${clueDetail.appellation} <small>${clueDetail.company}</small></h3>
		</div>
		<div style="position: relative; height: 50px; width: 500px;  top: -72px; left: 700px;">
			<button id="convertBtn" type="button" class="btn btn-default"><span class="glyphicon glyphicon-retweet"></span> 转换</button>
		</div>
	</div>
	
	<br/>
	<br/>
	<br/>

	<!-- 详细信息 -->
	<div style="position: relative; top: -70px;">
		<div style="position: relative; left: 40px; height: 30px;">
			<div style="width: 300px; color: gray;">名称</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${clueDetail.fullname}${clueDetail.appellation}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">所有者</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${clueDetail.owner}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">公司</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${clueDetail.company}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">职位</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${clueDetail.job}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">邮箱</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${clueDetail.email}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">公司座机</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${clueDetail.phone}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 30px;">
			<div style="width: 300px; color: gray;">公司网站</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${clueDetail.company}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">手机</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${clueDetail.mphone}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 40px;">
			<div style="width: 300px; color: gray;">线索状态</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${clueDetail.state}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">线索来源</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${clueDetail.source}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 50px;">
			<div style="width: 300px; color: gray;">创建者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${clueDetail.createBy}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">${clueDetail.createTime}</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 60px;">
			<div style="width: 300px; color: gray;">修改者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${clueDetail.editBy}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">${clueDetail.editTime}</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 70px;">
			<div style="width: 300px; color: gray;">描述</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					${clueDetail.description}
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 80px;">
			<div style="width: 300px; color: gray;">联系纪要</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					${clueDetail.contactSummary}
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 90px;">
			<div style="width: 300px; color: gray;">下次联系时间</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${clueDetail.nextContactTime}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px; "></div>
		</div>
        <div style="position: relative; left: 40px; height: 30px; top: 100px;">
            <div style="width: 300px; color: gray;">详细地址</div>
            <div style="width: 630px;position: relative; left: 200px; top: -20px;">
                <b>
					${clueDetail.address}
                </b>
            </div>
            <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
        </div>
	</div>
	
	<!-- 备注 -->
	<div id="remarkDivList" style="position: relative; top: 40px; left: 40px;">
		<div class="page-header">
			<h4>备注</h4>
		</div>
		<c:forEach items="${clueRemarks}" var="clueRemark">
			<%--备注--%>
			<div id="div_${clueRemark.id}" class="remarkDiv" style="height: 60px;">
				<img title="${clueRemark.createBy}" src="image/user-thumbnail.png" style="width: 30px; height:30px;">
				<div style="position: relative; top: -40px; left: 40px;" >
					<h5>${clueRemark.noteContent}</h5>
					<font color="gray">线索</font> <font color="gray">-</font> <b>${clueDetail.fullname}${clueDetail.appellation}-${clueDetail.company}</b> <small style="color: gray;"> ${clueRemark.editFlag == '1' ? clueRemark.editTime : clueRemark.createTime} 由&nbsp;${clueRemark.editFlag == '1' ? clueRemark.editBy : clueRemark.createBy}&nbsp;${clueRemark.editFlag == '1' ? "修改" : "创建"}</small>
					<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
						<a class="myHref" name="editA" remarkId="${clueRemark.id}" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a class="myHref" name="deleteA" remarkId="${clueRemark.id}" href="javascript:void(0);"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>
					</div>
				</div>
			</div>
		</c:forEach>
		<div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
			<form role="form" style="position: relative;top: 10px; left: 10px;">
				<textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"  placeholder="添加备注..."></textarea>
				<p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
					<button id="cancelBtn" type="button" class="btn btn-default">取消</button>
					<button type="button" class="btn btn-primary" id="saveClueremarkBtn">保存</button>
				</p>
			</form>
		</div>
	</div>
	
	<!-- 市场活动 -->
	<div>
		<div style="position: relative; top: 60px; left: 40px;">
			<div class="page-header">
				<h4>市场活动</h4>
			</div>
			<div style="position: relative;top: 0px;">
				<table class="table table-hover" style="width: 900px;">
					<thead>
						<tr style="color: #B3B3B3;">
							<td>名称</td>
							<td>开始日期</td>
							<td>结束日期</td>
							<td>所有者</td>
							<td></td>
						</tr>
					</thead>
					<tbody id="clueRemarkTBody">
					<c:forEach items="${relationActivities}" var="relationActivity">
						<tr id="tr_${relationActivity.id}">
							<td>${relationActivity.name}</td>
							<td>${relationActivity.startDate}</td>
							<td>${relationActivity.endDate}</td>
							<td>${relationActivity.owner}</td>
							<td><a href="javascript:void(0);" relationActivityId="${relationActivity.id}" style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>解除关联</a></td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
			
			<div>
				<a href="javascript:void(0);" id="bundActivityBtn" style="text-decoration: none;"><span class="glyphicon glyphicon-plus"></span>关联市场活动</a>
			</div>
		</div>
	</div>
	
	
	<div style="height: 200px;"></div>
</body>
</html>