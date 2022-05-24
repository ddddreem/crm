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
<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

	<%-- bs_typeahead自动补全插件 --%>
	<script type="text/javascript" src="jquery/bs_typeahead/bootstrap3-typeahead.min.js"></script>
	<script type="text/javascript">

		function queryActivityForCreateTran(activityName){
		    $.ajax({
				url:'workbench/transaction/queryActivitiesForCreateTran.do',
				type:'post',
				data:{
				    activityName:activityName
				},
				dataType:'json',
				success:function (data) {
					if(data.code == '1'){
					    var htmlStr = "";
						$.each(data.extend.activitiesForTran, function (index, obj) {
                            htmlStr += "<tr>";
                            htmlStr += "<td><input value=\"" + obj.id + "\" type=\"radio\" activityName=\"" + obj.name + "\" name=\"activity\"/></td>";
                            htmlStr += "<td>" + obj.name + "</td>";
                            htmlStr += "<td>" + obj.startDate + "</td>";
                            htmlStr += "<td>" + obj.endDate + "</td>";
                            htmlStr += "<td>" + obj.owner + "</td>";
                            htmlStr += "</tr>";
                        });
					    $("#searchActivityTBody").html(htmlStr);
					}else{
					    alert(data.msg);
					}
                }
			});
		};

		function queryContactForCreateTran(contactName){
		    $.ajax({
                url:'workbench/transaction/queryContactsForCreateTran.do',
                type:'post',
                data:{
                    contactName:contactName
                },
                dataType:'json',
                success:function (data) {
                    if(data.code == '1'){
                        var htmlStr = "";
                        $.each(data.extend.contactsForTran, function (index, obj) {
                            htmlStr += "<tr>";
                            htmlStr += "<td><input value=\"" + obj.id + "\" type=\"radio\" contactName=\"" + obj.fullname + "\" name=\"activity\"/></td>";
                            htmlStr += "<td>" + obj.fullname + "</td>";
                            htmlStr += "<td>" + (obj.website == null ? '未添加邮箱' : obj.website) + "</td>";
                            htmlStr += "<td>" + (obj.mphone == null ? '未添加联系电话' : obj.mphone) + "</td>";
                            htmlStr += "</tr>";
                        });
                        $("#searchContactTBody").html(htmlStr);
                    }else{
                        alert(data.msg);
                    }
                }
			});
		};

		$(function () {

		    $("#cancelSaveTranBtn").click(function () {
				window.history.back();
            });

		    $("#create-expectedDate").datetimepicker({
                language:'zh-CN', // 语言
                format:'yyyy-mm-dd', // 日期的格式
                minView:'month', // 可以选择的最小视图
                initialDate:new Date(), // 初始化显示的日期
                autoclose:true, // 设置选择完日期或者时间之后，是否自动关闭日历
                todayBtn:true, // 设置是否显示"今天"按钮，默认设置为false
                clearBtn:true // 设置是否显示"清空"按钮，默认是false
			});

		    $("#create-nextContactTime").datetimepicker({
                language:'zh-CN', // 语言
                format:'yyyy-mm-dd', // 日期的格式
                minView:'month', // 可以选择的最小视图
                initialDate:new Date(), // 初始化显示的日期
                autoclose:true, // 设置选择完日期或者时间之后，是否自动关闭日历
                todayBtn:true, // 设置是否显示"今天"按钮，默认设置为false
                clearBtn:true, // 设置是否显示"清空"按钮，默认是false
                pickerPosition:'top-right' // 设置datetimepicker从上面弹出
			});

		    $("#create-stage").change(function () {
				// 获取阶段value值
				var stageValue = $(this).find("option:selected").text();
				if(stageValue == ""){
				    $("#create-possibility").val("");
				    return ;
				}
				$.ajax({
					url:'workbench/transaction/getPossibilityByStage.do',
					type:'post',
					data:{
					    stageValue:stageValue
					},
					dataType:'json',
					success:function (data) {
						$("#create-possibility").val(data.extend.possibility);
                    }
				});
            });

            // 为客户名称设置自动补全,可优化
            $("#create-customerName").typeahead({
                source: function (jquery, process) {
                    $.ajax({
                        url: 'workbench/transaction/typeaheadPlugin.do',
                        type: 'post',
                        data: {
                            customerName: jquery
                        },
                        dataType: 'json',
                        success: function (data) {
                            process(data.extend.customerNames);
                        }
                    });
                }
            });

            // 查询市场活动源
			$("#searchActivityA").click(function () {
				$("#findMarketActivity").modal("show");
                $("#searchActivityTBody").html("");
				$("#searchActivityInput").val("");
            });

			// 为搜索活动源绑定焦点事件
            $("#searchActivityInput").focus(function () {
				if($.trim($("#searchActivityInput").val()) == ""){
                    queryActivityForCreateTran("");
				}
            });

            // 为搜索市场活动输入框绑定单击事件
            $("#searchActivityInput").keyup(function () {
                var activityName = $.trim($("#searchActivityInput").val());
                queryActivityForCreateTran(activityName);
            });

            // 为搜索出来的市场活动单选框绑定单击事件
            $("#searchActivityTBody").on("click", "input[type='radio']", function () {
				var activityId = this.value;
				var activityName = $(this).attr("activityName");
				$("#selectedActivityHiIn").val(activityId);
				$("#create-activitySrc").val(activityName);
                $("#findMarketActivity").modal("hide");
            });

            // 为搜索联系人超链接绑定单击事件
            $("#searchContactA").click(function () {
                $("#findContacts").modal("show");
                $("#searchContactTBody").html("");
                $("#searchContactInput").val("");
            });

            // 为搜索框绑定焦点事件
            $("#searchContactInput").focus(function () {
                $("#create-contactName").change();
                if($.trim($("#searchContactInput").val()) == ""){
                    queryContactForCreateTran("");
                }
            });

            // 为搜索框绑定键盘弹起事件
            $("#searchContactInput").keyup(function () {
                var contactName = $.trim($("#searchContactInput").val());
                queryContactForCreateTran(contactName);
            });


            // 为搜索出来的联系人单选框绑定单击事件
            $("#searchContactTBody").on("click", "input[type='radio']", function () {
                var contactId = this.value;
                var contactName = $(this).attr("contactName");
                $("#selectedContactHiIn").val(contactId);
                $("#create-contactName").val(contactName);
                $("#findContacts").modal("hide");
            });

            // 联系人输入框绑定弹起事件，重置隐藏域中的联系人id
			// $("#create-contactName").keyup(function () {
			//     if($("#create-selectedContactHiIn").val())
            //     $("#create-selectedContactHiIn").val("");
            // });

            // 为保存按钮绑定单击事件
			$("#saveCreateTranBtn").click(function () {
				var owner = $("#create-owner").val();
			    var money = $.trim($("#create-money").val());
			    var name = $.trim($("#create-name").val());
			    var expectedDate = $("#create-expectedDate").val();
			    var stage = $("#create-stage").val();
			    var type = $("#create-type").val();
				var source = $("#create-source").val();
			    var activityId = $("#selectedActivityHiIn").val();
			    var contactsId = $("#selectedContactHiIn").val();
			    var contactName = $.trim($("#create-contactName").val());
			    var description = $.trim($("#create-description").val());
			    var contactSummary = $.trim($("#create-contactSummary").val());
				var nextContactTime = $("#create-nextContactTime").val();
			    var customerName = $.trim($("#create-customerName").val());

			    // 添加前端验证
				if(customerName == ""){
				    alert("客户名称不能为空...");
				    return ;
				}
				if(owner == ""){
				    alert("所有者不能为空...");
				    return ;
				}
				if(name == ""){
				    alert("名称不能为空...");
				    return ;
				}
				if(expectedDate == ""){
				    alert("预计成交时间不能为空...");
				    return ;
				}
				if(stage == ""){
				    alert("阶段不能为空...");
				    return ;
				}

				// 发送保存请求
			    $.ajax({
					url:'workbench/transaction/saveCreateTran.do',
					type:'post',
					data:{
					   owner:owner,
					   money:money,
					   name:name,
					   expectedDate:expectedDate,
					   stage:stage,
					   type:type,
					   source:source,
					   activityId:activityId,
					   contactsId:contactsId,
					   contactName:contactName,
					   description:description,
					   contactSummary:contactSummary,
					   nextContactTime:nextContactTime,
					   customerName:customerName
					},
					dataType:'json',
					success:function (data) {
						if(data.code == '1'){
						    alert("创建成功！");
						    window.location.href = "workbench/transaction/tranIndex.do";
						}else{
						    alert(data.msg);
						}
                    }
				});
            });
        });
	</script>
</head>
<body>

	<!-- 查找市场活动 -->	
	<div class="modal fade" id="findMarketActivity" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">查找市场活动</h4>
				</div>
				<div class="modal-body">
					<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
						<form class="form-inline" role="form">
						  <div class="form-group has-feedback">

						    <input id="searchActivityInput" type="text" class="form-control" style="width: 300px;" placeholder="请输入市场活动名称，支持模糊查询">
						    <span class="glyphicon glyphicon-search form-control-feedback"></span>
						  </div>
						</form>
					</div>
					<table id="activityTable3" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td></td>
								<td>名称</td>
								<td>开始日期</td>
								<td>结束日期</td>
								<td>所有者</td>
							</tr>
						</thead>
						<tbody id="searchActivityTBody">
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<!-- 查找联系人 -->	
	<div class="modal fade" id="findContacts" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">查找联系人</h4>
				</div>
				<div class="modal-body">
					<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
						<form class="form-inline" role="form">
						  <div class="form-group has-feedback">
						    <input id="searchContactInput" type="text" class="form-control" style="width: 300px;" placeholder="请输入联系人名称，支持模糊查询">
						    <span class="glyphicon glyphicon-search form-control-feedback"></span>
						  </div>
						</form>
					</div>
					<table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td></td>
								<td>名称</td>
								<td>邮箱</td>
								<td>手机</td>
							</tr>
						</thead>
						<tbody id="searchContactTBody">
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	
	
	<div style="position:  relative; left: 30px;">
		<h3>创建交易</h3>
	  	<div style="position: relative; top: -40px; left: 70%;">
			<button id="saveCreateTranBtn" type="button" class="btn btn-primary">保存</button>
			<button id="cancelSaveTranBtn" type="button" class="btn btn-default">取消</button>
		</div>
		<hr style="position: relative; top: -40px;">
	</div>
	<form class="form-horizontal" role="form" style="position: relative; top: -30px;">
		<div class="form-group">
			<label for="create-owner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<select class="form-control" id="create-owner">
				  <c:forEach items="${users}" var="u">
					  <option value="${u.id}">${u.name}</option>
				  </c:forEach>
				</select>
			</div>
			<label for="create-money" class="col-sm-2 control-label">金额</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-money">
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-name" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-name">
			</div>
			<label for="create-expectedDate" class="col-sm-2 control-label">预计成交日期<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-expectedDate" readonly>
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-customerName" class="col-sm-2 control-label">客户名称<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-customerName" placeholder="支持自动补全，输入客户不存在则新建">
			</div>
			<label for="create-stage" class="col-sm-2 control-label">阶段<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
			  <select class="form-control" id="create-stage">
			  	<option></option>
			  	<c:forEach items="${stage}" var="s">
					<option value="${s.id}">${s.value}</option>
				</c:forEach>
			  </select>
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-type" class="col-sm-2 control-label">类型</label>
			<div class="col-sm-10" style="width: 300px;">
				<select class="form-control" id="create-type">
				  <option></option>
					<c:forEach items="${type}" var="t">
						<option value="${t.id}">${t.value}</option>
					</c:forEach>
				</select>
			</div>
			<label for="create-possibility" class="col-sm-2 control-label">可能性</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-possibility" readonly>
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-source" class="col-sm-2 control-label">来源</label>
			<div class="col-sm-10" style="width: 300px;">
				<select class="form-control" id="create-source">
				  <option></option>
					<c:forEach items="${source}" var="src">
						<option value="${src.id}">${src.value}</option>
					</c:forEach>
				</select>
			</div>
			<label for="create-activitySrc" class="col-sm-2 control-label">市场活动源&nbsp;&nbsp;<a href="javascript:void(0);" id="searchActivityA"><span class="glyphicon glyphicon-search"></span></a></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="hidden" id="selectedActivityHiIn"/>
				<input type="text" class="form-control" id="create-activitySrc" readonly>
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-contactName" class="col-sm-2 control-label">联系人名称&nbsp;&nbsp;<a href="javascript:void(0);" id="searchContactA"><span class="glyphicon glyphicon-search"></span></a></label>
			<div class="col-sm-10" style="width: 300px;">
                <input type="hidden" id="selectedContactHiIn"/>
				<input type="text" class="form-control" id="create-contactName">
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-description" class="col-sm-2 control-label">描述</label>
			<div class="col-sm-10" style="width: 70%;">
				<textarea class="form-control" rows="3" id="create-description"></textarea>
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
			<div class="col-sm-10" style="width: 70%;">
				<textarea class="form-control" rows="3" id="create-contactSummary"></textarea>
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-nextContactTime" readonly>
			</div>
		</div>
		
	</form>
</body>
</html>