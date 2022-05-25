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
	<script type="text/javascript"
			src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript"
			src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

	<%-- pagination 插件--%>
	<link rel="stylesheet" type="text/css" href="jquery/bs_pagination-master/css/jquery.bs_pagination.min.css"/>
	<script type="text/javascript" src="jquery/bs_pagination-master/js/jquery.bs_pagination.min.js"></script>
	<script type="text/javascript" src="jquery/bs_pagination-master/localization/en.js"></script>
	<script type="text/javascript">

        function queryAllCustomersByCondition(pn, ps) {
            var name = $.trim($("#condition-name").val());
            var owner = $.trim($("#condition-owner").val());
            var phone = $.trim($("#condition-phone").val());
            var website = $.trim($("#condition-website").val());
            $.ajax({
                url: 'workbench/customer/queryAllCustomers.do',
                type: 'post',
                data: {
                    name: name,
                    owner: owner,
                    phone: phone,
                    website: website,
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
                            htmlStr += "<td><a style=\"text-decoration: none; cursor: pointer;\" onclick=\"window.location.href=ddetail.jsp\">" + obj.name + "</a></td>";
                            htmlStr += "<td>" + obj.owner + "</td>";
                            htmlStr += "<td>" + obj.phone + "</td>";
                            htmlStr += "<td>" + obj.website + "</td>";
                            htmlStr += "</tr>";
                        });
                        $("#customersTBody").html(htmlStr);

                        // 设置全选按钮不选中
                        $("#checkAllBtn").prop("checked", false);

                        $("#customerNavi").bs_pagination({
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
                                queryAllCustomersByCondition(pageObj.currentPage, pageObj.rowsPerPage);
                            }
                        });
                    } else {
                        alert(data.msg);
                    }
                }
            });
        };

        $(function () {

            queryAllCustomersByCondition(1, 5);

            //定制字段
            $("#definedColumns > li").click(function (e) {
                //防止下拉菜单消失
                e.stopPropagation();
            });

            // 为全选按钮绑定单击事件
            $("#checkAllBtn").click(function () {
                $("#customersTBody input[type='checkbox']").prop("checked", this.checked);
            });

            // 为每一个客户的复选框绑定单击事件
            $("#customersTBody").on("click", "input[type='checkbox']", function () {
                if ($("#customersTBody input[type='checkbox']").size() == $("#customersTBody input[type='checkbox']:checked").size()) $("#checkAllBtn").prop("checked", true);
                else $("#checkAllBtn").prop("checked", false);

            });
            // 为查询按钮绑定单击事件
            $("#queryCustomersBtn").click(function () {
                queryAllCustomersByCondition(1, $("#customerNavi").bs_pagination('getOption', 'rowsPerPage'));
            });

            // 设置日历插件
			$(".timeSelecter").datetimepicker({
                language:'zh-CN', // 语言
                format:'yyyy-mm-dd', // 日期的格式
                minView:'month', // 可以选择的最小视图
                initialDate:new Date(), // 初始化显示的日期
                autoclose:true, // 设置选择完日期或者时间之后，是否自动关闭日历
                todayBtn:true, // 设置是否显示"今天"按钮，默认设置为false
                clearBtn:true, // 设置是否显示"清空"按钮，默认是false
                pickerPosition:'top-right' // 设置datetimepicker从上面弹出
			});

            // 为修改客户信息按钮绑定单击事件
			$("#editCustomerBtn").click(function () {
				var customerList = $("#customersTBody input[type='checkbox']:checked"); // 这样获取的只是js对象，需要转换成jQuery对象才能使用val()函数
				if(customerList.size() > 1 || customerList.size() == 0){
				    alert("请选择一条记录...");
				    return ;
				}
				var customerId = customerList[0].value; // 只有jQuery对象才能使用val()函数，普通的对象只能使用value
				$.ajax({
					url:'workbench/customer/queryCustomerForEditByCustomerId.do',
					type:'post',
					dataType:'json',
					data:{
					    customerId:customerId
					},
					success:function (data) {
                        if (data.code == '1') {
                            // window.location.href = "workbench/customer/customerIndex.do";
                            $("#edit-owner").val(data.extend.editCustomer.owner);
                            $("#edit-name").val(data.extend.editCustomer.name);
                            $("#edit-website").val(data.extend.editCustomer.website);
                            $("#edit-phone").val(data.extend.editCustomer.phone);
                            $("#edit-description").val(data.extend.editCustomer.description);
                            $("#edit-contactSummary").val(data.extend.editCustomer.contactSummary);
                            $("#edit-nextContactTime").val(data.extend.editCustomer.nextContactTime);
                            $("#edit-address").val(data.extend.editCustomer.address);
                            $("#edit-id").val(customerId);
                            $("#editCustomerModal").modal("show");
						}else{
						    alert(data.msg);
						}
                    }
				});
            });

			// 为更新按钮绑定单击事件
			$("#updateCustomerBtn").click(function () {
				var owner = $("#edit-owner").val();
			    var name = $.trim($("#edit-name").val());
			    var website = $.trim($("#edit-website").val());
			    var phone = $("#edit-phone").val();
			    var description = $.trim($("#edit-description").val());
			    var contactSummary = $.trim($("#edit-contactSummary").val());
				var nextContactTime = $("#edit-nextContactTime").val();
			    var address = $.trim($("#edit-address").val());
			    var id = $("#edit-id").val();
                var websiteReg = /^([hH][tT]{2}[pP]:\/\/|[hH][tT]{2}[pP][sS]:\/\/)(([A-Za-z0-9-~]+)\.)+([A-Za-z0-9-~\/])+$/;
                // 验证座机号码是否合法
                var phoneReg = /\d{3}-\d{8}|\d{4}-\d{7}/;
				if(name == ""){
				    alert("名称不能为空...");
				    return ;
				}
				if(nextContactTime == ""){
				    alert("下次联系时间不能为空...");
				    return ;
				}
				if(!phoneReg.test(phone)){
                    alert("联系电话格式有误...(eg:086-11111111)");
                    return ;
				}
                if (!websiteReg.test(website)) {
                    alert("公司网站格式不正确,请重新输入...(eg:https://gitee.com/dreem_12/ssm-crm)");
                    return ;
                }
                $.ajax({
					url:'workbench/customer/saveCustomerByModifiedCustomer.do',
					type:'post',
					data:{
					    owner:owner,
						name:name,
						website:website,
						phone:phone,
						description:description,
						contactSummary:contactSummary,
						nextContactTime:nextContactTime,
						address:address,
						id:id
					},
					dataType:'json',
					success:function (data) {
						if(data.code == '1'){
						    alert("更新成功...");
                            queryAllCustomersByCondition(1, $("#customerNavi").bs_pagination('getOption', 'rowsPerPage'));
                            $("#editCustomerModal").modal("hide");
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

	<!-- 创建客户的模态窗口 -->
	<div class="modal fade" id="createCustomerModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建客户</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="create-customerOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-customerOwner">
								  <c:forEach items="${users}" var="u">
									  <option value="${u.id}">${u.name}</option>
								  </c:forEach>
								</select>
							</div>
							<label for="create-customerName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-customerName">
							</div>
						</div>
						
						<div class="form-group">
                            <label for="create-website" class="col-sm-2 control-label">公司网站</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-website">
                            </div>
							<label for="create-phone" class="col-sm-2 control-label">公司座机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-phone">
							</div>
						</div>
						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-describe"></textarea>
							</div>
						</div>
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                        <div style="position: relative;top: 15px;">
                            <div class="form-group">
                                <label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="3" id="create-contactSummary"></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control timeSelecter" id="create-nextContactTime" readonly>
                                </div>
                            </div>
                        </div>

                        <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="create-address" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="create-address"></textarea>
                                </div>
                            </div>
                        </div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改客户的模态窗口 -->
	<div class="modal fade" id="editCustomerModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改客户</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
						<input id="edit-id" type="hidden">
						<div class="form-group">
							<label for="edit-owner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-owner">
									<c:forEach items="${users}" var="u">
										<option value="${u.id}">${u.name}</option>
									</c:forEach>
								</select>
							</div>
							<label for="edit-name" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-name">
							</div>
						</div>
						
						<div class="form-group">
                            <label for="edit-website" class="col-sm-2 control-label">公司网站</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-website">
                            </div>
							<label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-phone">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-description" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-description"></textarea>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                        <div style="position: relative;top: 15px;">
                            <div class="form-group">
                                <label for="edit-contactSummary" class="col-sm-2 control-label">联系纪要</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="3" id="edit-contactSummary"></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="edit-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control timeSelecter" id="edit-nextContactTime" readonly>
                                </div>
                            </div>
                        </div>

                        <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="edit-address" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="edit-address"></textarea>
                                </div>
                            </div>
                        </div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateCustomerBtn">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>客户列表</h3>
			</div>
		</div>
	</div>
	
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
	
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" type="text" id="condition-name">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="condition-owner">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">公司座机</div>
				      <input class="form-control" type="text" id="condition-phone">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">公司网站</div>
				      <input class="form-control" type="text" id="condition-website">
				    </div>
				  </div>
				  
				  <button id="queryCustomersBtn" type="button" class="btn btn-default">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="createCustomerBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editCustomerBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteCustomerBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="checkAllBtn"/></td>
							<td>名称</td>
							<td>所有者</td>
							<td>公司座机</td>
							<td>公司网站</td>
						</tr>
					</thead>
					<tbody id="customersTBody">
					</tbody>
				</table>
				<div id="customerNavi"></div>
			</div>
		</div>
		
	</div>
</body>
</html>