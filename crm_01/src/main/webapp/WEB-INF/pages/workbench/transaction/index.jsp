<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
	<base href="<%=basePath%>">
	<meta charset="UTF-8">

	<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
	<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css"
		  rel="stylesheet"/>

	<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
	<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript"
			src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

	<%-- pagination 插件--%>
	<link rel="stylesheet" type="text/css" href="jquery/bs_pagination-master/css/jquery.bs_pagination.min.css"/>
	<script type="text/javascript" src="jquery/bs_pagination-master/js/jquery.bs_pagination.min.js"></script>
	<script type="text/javascript" src="jquery/bs_pagination-master/localization/en.js"></script>
	<script type="text/javascript">

        function queryTransByCondition(pn, ps) {
            var owner = $.trim($("#condition-owner").val());
            var name = $.trim($("#condition-name").val());
            var customerId = $.trim($("#condition-customer").val());
            var stage = $("#condition-stage").val();
            var type = $("#condition-type").val();
            var source = $("#condition-source").val();
            var contactsId = $.trim($("#condition-contact").val());
            $.ajax({
                url: 'workbench/transaction/queryAllTrans.do',
                type: 'post',
                data: {
                    owner: owner,
                    name: name,
                    customerId: customerId,
                    stage: stage,
                    type: type,
                    source: source,
                    contactsId: contactsId,
                    pn: pn,
                    ps: ps
                },
                dataType: 'json',
                success: function (data) {
                    if (data.code == '1') {
                        var htmlStr = "";
                        $.each(data.extend.pageInfo.list, function (index, obj) {
                            htmlStr += "<tr>";
                            htmlStr += "<td><input type=\"checkbox\" value=\"" + obj.id + "\"/></td>";
                            htmlStr += "<td><a style=\"text-decoration: none; cursor: pointer;\" onclick=\"window.location.href='workbench/transaction/tranDetail.do?tranId="+ obj.id +"'\">" + obj.name + "</a></td>";
                            htmlStr += "<td>" + obj.customerId + "</td>";
                            htmlStr += "<td>" + obj.stage + "</td>";
                            htmlStr += "<td>" + (obj.type == null ? '未选择类型' : obj.type) + "</td>";
                            htmlStr += "<td>" + obj.owner + "</td>";
                            htmlStr += "<td>" + (obj.source == null ? '未选择来源' : obj.source) + "</td>";
                            htmlStr += "<td>" + obj.contactsId + "</td>";
                            htmlStr += "</tr>";
                        });
                        $("#transTBody").html(htmlStr);

                        // 设置全选按钮不选中
                        $("#checkAllBtn").prop("checked", false);

                        $("#transNaviBar").bs_pagination({
                            currentPage: pn, // 当前页号，相当于pageNo
                            rowsPerPage: ps, // 每页显示的条数，即pageSize
                            totalRows: data.extend.pageInfo.total, // 总条数
                            totalPages: data.extend.pageInfo.pages, // 总页数，必填参数

                            visiblePageLinks: 5, // 最多可以显示的卡片数
                            showGoToPage: true, // 是否显示"跳转到"部分，默认true--显示
                            showRowsPerPage: true, // 是否显示"每页显示条数"部分，默认true--显示
                            showRowsInfo: true, // 是否显示记录的信息，默认true--显示

                            // 用户每次切换页号，都自动触发页面切换函数，是插件的提供的内部函数
                            // 每次返回切换页号之后的pageNo和pageSize
                            onChangePage: function (event, pageObj) {
                                queryTransByCondition(pageObj.currentPage, pageObj.rowsPerPage);
                            }
                        });
                    } else {
                        alert(data.mag);
                    }
                }
            });
        };

        $(function () {

            queryTransByCondition(1, 5);

            // 为全选按钮绑定单击事件
            $("#checkAllBtn").click(function () {
                $("#transTBody input[type='checkbox']").prop("checked", this.checked);
            });

            // 为每一个客户的复选框绑定单击事件
            $("#transTBody").on("click", "input[type='checkbox']", function () {
                if ($("#transTBody input[type='checkbox']").size() == $("#transTBody input[type='checkbox']:checked").size()) $("#checkAllBtn").prop("checked", true);
                else $("#checkAllBtn").prop("checked", false);
            });

            $("#transTBody").on("click", "a", function () {

            });

            $("#createTranBtn").click(function () {
				window.location.href = "workbench/transaction/toSaveTranPage.do";
            });

        });

	</script>
</head>
<body>
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>交易列表</h3>
			</div>
		</div>
	</div>
	
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
	
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="condition-owner">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" type="text" id="condition-name">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">客户名称</div>
				      <input class="form-control" type="text" id="condition-customer">
				    </div>
				  </div>
				  
				  <br>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">阶段</div>
					  <select class="form-control" id="condition-stage">
					  	<option></option>
						  <c:forEach items="${stage}" var="st">
							  <option value="${st.id}">${st.value}</option>
						  </c:forEach>
					  </select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">类型</div>
					  <select class="form-control" id="condition-type">
					  	<option></option>
						  <c:forEach items="${type}" var="t">
							  <option value="${t.id}">${t.value}</option>
						  </c:forEach>
					  </select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">来源</div>
				      <select class="form-control" id="condition-source">
						  <option></option>
						  <c:forEach items="${source}" var="s">
							  <option value="${s.id}">${s.value}</option>
						  </c:forEach>
						</select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">联系人名称</div>
				      <input class="form-control" type="text" id="condition-contact">
				    </div>
				  </div>
				  
				  <button id="queryTranBtn" type="button" class="btn btn-default">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 10px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="createTranBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" onclick="window.location.href='edit.html';"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="checkAllBtn"/></td>
							<td>名称</td>
							<td>客户名称</td>
							<td>阶段</td>
							<td>类型</td>
							<td>所有者</td>
							<td>来源</td>
							<td>联系人名称</td>
						</tr>
					</thead>
					<tbody id="transTBody">
					</tbody>
				</table>
				<div id="transNaviBar"></div>
			</div>
		</div>
	</div>
</body>
</html>