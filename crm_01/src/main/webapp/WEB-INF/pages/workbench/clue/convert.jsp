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


<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

<script type="text/javascript">
	function queryRelationActivity(activityName, clueId){
        $.ajax({
            url:'workbench/clue/queryRelationActivitiesByNameClueId.do',
            type:'post',
            data:{
                activityName:activityName,
                clueId:clueId
            },
            dataType:'json',
            success:function (data) {
                if(data.code='1'){
                    var htmlStr = "";
                    $.each(data.extend.relationActivities, function (index, obj) {
                       htmlStr += "<tr>";
                       htmlStr += "<td><input type=\"radio\" value=\"" + obj.id + "\" activityName=\"" + obj.name + "\" name=\"activity\"/></td>";
                       htmlStr += "<td>" + obj.name + "</td>";
                       htmlStr += "<td>" + obj.startDate + "</td>";
                       htmlStr += "<td>" + obj.endDate + "</td>";
                       htmlStr += "<td>" + obj.owner + "</td>";
                       htmlStr += "</tr>";
                    });
                    $("#relationActivityTBody").html(htmlStr);
                }else{
                    alert(data.msg);
                }
            }
        });
	};
	$(function(){

		$("#isCreateTran").click(function(){
			if(this.checked){
				$("#create-transaction2").show(200);
			}else{
				$("#create-transaction2").hide(200);
			}
		});

		// 为日期绑定日期插件
		$("#expectedDate").datetimepicker({
            language:'zh-CN', // 语言
            format:'yyyy-mm-dd', // 日期的格式
            minView:'month', // 可以选择的最小视图
            initialDate:new Date(), // 初始化显示的日期
            autoclose:true, // 设置选择完日期或者时间之后，是否自动关闭日历
            todayBtn:true, // 设置是否显示"今天"按钮，默认设置为false
            clearBtn:true, // 设置是否显示"清空"按钮，默认是false
            pickerPosition:'top-right'
		});

		// 为搜索市场活动源添加单击事件
		$("#searchSourceA").click(function () {
		    $("#searchTextI").val("");
            $("#relationActivityTBody").html("");
			$("#searchActivityModal").modal("show");
        });

		// 为搜索输入框绑定焦点事件
        $("#searchTextI").focus(function () {
            var activityName = $.trim($("#searchTextI").val());
            var clueId = '${clue.id}';
            if(activityName == ""){
                queryRelationActivity("", clueId);
			}
        });

        // 为搜索输入框绑定键盘抬起事件
        $("#searchTextI").keyup(function () {
            var activityName = $.trim($("#searchTextI").val());
            var clueId = '${clue.id}';
            queryRelationActivity(activityName, clueId);
        });

        // 为转换按钮绑定单击事件
		$("#convertClueBtn").click(function () {
			var isCreateTran = $("#isCreateTran").prop("checked");
			var clueId = '${clue.id}';
			var money = $.trim($("#money").val());
			var name = $.trim($("#name").val());
			var expectedDate = $("#expectedDate").val();
			var stage = $("#stage").val();
			var activityId = $("#activityIdForTran").val();
			var moneyReg = /^[1-9]\d*$/;
			if(moneyReg.test(money)){
			    $.ajax({
					url:'workbench/clue/convertClue.do',
					type:'post',
					data:{
					    isCreateTran:isCreateTran,
					    clueId:clueId,
					    money:money,
					    name:name,
					    expectedDate:expectedDate,
					    stage:stage,
					    activityId:activityId
					},
					dataType:'json',
					success:function (data) {
						if(data.code == '1'){
						    alert("转换成功！")
							// 跳转线索首页
							window.location.href = "workbench/clue/clueIndex.do";
						}else{
						    alert(data.msg);
						}
                    }
				});
			}
        });

		// 为搜索市场活动的单选框绑定单击事件
		$("#relationActivityTBody").on("click", "input[type='radio']", function () {
			var activityId = this.value;
			var activityName = $(this).attr("activityName");
			$("#activityIdForTran").val(activityId);
			$("#activityNameForTran").val(activityName);
            $("#searchTextI").val("");
            $("#searchActivityModal").modal("hide");
        });

		$("#cancelConvertBtn").click(function () {
            window.history.back();
        });
	});
</script>

</head>
<body>
	
	<!-- 搜索市场活动的模态窗口 -->
	<div class="modal fade" id="searchActivityModal" role="dialog" >
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">搜索市场活动</h4>
				</div>
				<div class="modal-body">
					<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
						<form class="form-inline" role="form">
						  <div class="form-group has-feedback">
						    <input id="searchTextI" type="text" class="form-control" style="width: 300px;" placeholder="请输入市场活动名称，支持模糊查询">
						    <span class="glyphicon glyphicon-search form-control-feedback"></span>
						  </div>
						</form>
					</div>
					<table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td></td>
								<td>名称</td>
								<td>开始日期</td>
								<td>结束日期</td>
								<td>所有者</td>
								<td></td>
							</tr>
						</thead>
						<tbody id="relationActivityTBody">
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<div id="title" class="page-header" style="position: relative; left: 20px;">
		<h4>转换线索 <small>${clue.fullname}${clue.appellation}-${clue.company}</small></h4>
	</div>
	<div id="create-customer" style="position: relative; left: 40px; height: 35px;">
		新建客户：${clue.company}
	</div>
	<div id="create-contact" style="position: relative; left: 40px; height: 35px;">
		新建联系人：${clue.fullname}${clue.appellation}
	</div>
	<div id="create-transaction1" style="position: relative; left: 40px; height: 35px; top: 25px;">
		<input type="checkbox" id="isCreateTran"/>
		为客户创建交易
	</div>
	<div id="create-transaction2" style="position: relative; left: 40px; top: 20px; width: 80%; background-color: #F7F7F7; display: none;" >
	
		<form>
		  <div class="form-group" style="width: 400px; position: relative; left: 20px;">
		    <label for="money">金额</label>
		    <input type="text" class="form-control" id="money">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="name">交易名称</label>
		    <input type="text" class="form-control" id="name" value="${clue.company}-">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="expectedDate">预计成交日期</label>
		    <input type="text" class="form-control" id="expectedDate" readonly>
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="stage">阶段</label>
		    <select id="stage"  class="form-control">
		    	<option></option>
		    	<c:forEach items="${stage}" var="s">
					<option value="${s.id}">${s.value}</option>
				</c:forEach>
		    </select>
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
			  <input type="hidden" id="activityIdForTran"/>
		    <label for="activityNameForTran">市场活动源&nbsp;&nbsp;<a href="javascript:void(0);" id="searchSourceA" style="text-decoration: none;"><span class="glyphicon glyphicon-search"></span></a></label>
		    <input type="text" class="form-control" id="activityNameForTran" placeholder="点击上面搜索" readonly>
		  </div>
		</form>
		
	</div>
	
	<div id="owner" style="position: relative; left: 40px; height: 35px; top: 50px;">
		记录的所有者：<br>
		<b>${clue.owner}</b>
	</div>
	<div id="operation" style="position: relative; left: 40px; height: 35px; top: 100px;">
		<input id="convertClueBtn" class="btn btn-primary" type="button" value="转换">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input id="cancelConvertBtn" class="btn btn-default" type="button" value="取消">
	</div>
</body>
</html>