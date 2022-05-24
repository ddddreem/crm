<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
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

		function queryClue(pn, ps){
			var fullname = $.trim($("#query-fullname").val());
			var company = $.trim($("#query-company").val());
			var phone = $.trim($("#query-phone").val());
			var owner = $.trim($("#query-owner").val());
			var state = $("#query-state").val();
			var source = $("#query-source").val();
            var mphone = $.trim($("#query-mphone").val());
            $.ajax({
                url: 'workbench/clue/queryAllClues.do',
                type: 'post',
                data: {
                    fullname: fullname,
                    company: company,
                    phone: phone,
                    owner: owner,
                    state: state,
                    source: source,
                    mphone: mphone,
                    pn: pn,
                    ps: ps
                },
				dataType:'json',
				success:function (data) {
					if(data.code=='1'){
						var htmlStr = "";
						$.each(data.extend.pageInfo.list, function (index, obj) {
                        	htmlStr+="<tr>";
                            htmlStr+="<td><input value=\""+ obj.id + "\" type=\"checkbox\" /></td>";
                            htmlStr+="<td><a style=\"text-decoration: none; cursor: pointer;\" onclick=\"window.location.href='workbench/clue/detailClue.do?id=" + obj.id +"'\">"+ obj.fullname + obj.appellation + "</a></td>";
                            htmlStr+="<td>"+ obj.company +"</td>";
                            htmlStr+="<td>"+ obj.phone +"</td>";
                            htmlStr+="<td>"+ obj.mphone +"</td>";
                            htmlStr+="<td>"+ obj.source +"</td>";
                            htmlStr+="<td>"+ obj.owner +"</td>";
                            htmlStr+="<td>"+ obj.state +"</td>";
                            htmlStr+="</tr>";
                        });
						$("#clueTBody").html(htmlStr);

						// 将全选按钮置为不选中
                        $("#checkAll").prop("checked", false);

						$("#navigationBar").bs_pagination({
                            currentPage:pn, // 当前页号，相当于pageNo
                            rowsPerPage:ps, // 每页显示的条数，即pageSize
                            totalRows:data.extend.pageInfo.total, // 总条数
                            totalPages:data.extend.pageInfo.pages, // 总页数，必填参数

                            visiblePageLinks:5, // 最多可以显示的卡片数
                            showGoToPage:true, // 是否显示"跳转到"部分，默认true--显示
                            showRowsPerPage:true, // 是否显示"每页显示条数"部分，默认true--显示
                            showRowsInfo:true, // 是否显示记录的信息，默认true--显示

                            // 用户每次切换页号，都自动触发页面切换函数，是插件的提供的内部函数
                            // 每次返回切换页号之后的pageNo和pageSize
                            onChangePage:function (event, pageObj) {
                                queryClue(pageObj.currentPage, pageObj.rowsPerPage);
                            }
						});
					}else{
					    alert(data.msg);
					}
                }
			});
		}
        $(function () {
            // 页面加载完毕，在页面上显示数据
            queryClue(1, 5);

            // 为事件选择
			$(".calendarPlugin").datetimepicker({
                language:'zh-CN', // 语言
                format:'yyyy-mm-dd', // 日期的格式
                minView:'month', // 可以选择的最小视图
                initialDate:new Date(), // 初始化显示的日期
                autoclose:true, // 设置选择完日期或者时间之后，是否自动关闭日历
                todayBtn:true, // 设置是否显示"今天"按钮，默认设置为false
                clearBtn:true, // 设置是否显示"清空"按钮，默认是false
                pickerPosition:'top-right' // 设置datetimepicker从上面弹出
			});

			// 给创建线索按钮绑定单击事件
			$("#createClueBtn").click(function () {
			    // 刷新表单
				$("#createClueForm")[0].reset();
				// 显示线索添加模态框
				$("#createClueModal").modal("show");
            });
			// $("#navigationBar").bs_pagination();
			// 保存线索按钮绑定单击事件
            $("#saveCreateClue").click(function () {
                var owner = $("#create-clueOwner").val();
                var company = $.trim($("#create-company").val());
                var appellation = $("#create-appellation").val();
                var fullname = $.trim($("#create-fullname").val());
                var job = $.trim($("#create-job").val());
                var email = $.trim($("#create-email").val());
                var phone = $.trim($("#create-phone").val());
                var website = $.trim($("#create-website").val());
                var mphone = $.trim($("#create-mphone").val());
                var state = $("#create-state").val();
                var source = $("#create-source").val();
                var description = $.trim($("#create-description").val());
                var contactSummary = $.trim($("#create-contactSummary").val());
                var nextContactTime = $("#create-nextContactTime").val();
                var address = $.trim($("#create-address").val());
                // 验证邮箱是否合法
                var emailReg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
                // 验证手机号码是否合法
                var mphoneReg = /^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/;
                // 验证座机号码是否合法
                var phoneReg = /\d{3}-\d{8}|\d{4}-\d{7}/;
                // 验证网站是否合法
                var websiteReg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
                if (!emailReg.test(email)) {
                    alert("邮箱格式不正确,请重新输入...");
                    return;
                }
                if (!mphoneReg.test(mphone)) {
                    alert("手机号码格式不正确,请重新输入...");
                    return;
                }
                if (!phoneReg.test(phone)) {
                    alert("公司座机号码格式不正确,请重新输入...");
                    return;
                }
                // if (!websiteReg.test(website)) {
                //     alert("公司网站格式不正确,请重新输入...");
                //     return;
                // }
                $.ajax({
                    url: 'workbench/clue/saveCreateClue.do',
                    type: 'post',
                    data: {
                        owner: owner,
                        company: company,
                        appellation: appellation,
                        fullname: fullname,
                        job: job,
                        email: email,
                        phone: phone,
                        website: website,
                        mphone: mphone,
                        state: state,
                        source: source,
                        description: description,
                        contactSummary: contactSummary,
                        nextContactTime: nextContactTime,
                        address: address
                    },
                    dataType: 'json',
                    success: function (data) {
						if(data.code=='1'){
						    // 刷新当前页面
                            queryClue(1, $("#navigationBar").bs_pagination('getOption', 'rowsPerPage'));
							//关闭模态窗口
							$("#createClueModal").modal("hide");
						}else{
						    alert(data.msg);
						    // 模态窗口不关闭
							$("#createClueModal").modal("show");
						}
                    }
                });
            });

            // 给查询按钮绑定单击事件,根据条件查询并更新显示
            $("#queryByConditionBtn").click(function () {
                queryClue(1, $("#navigationBar").bs_pagination('getOption', 'rowsPerPage'));
            });

            // 为全选按钮绑定单击事件
            $("#checkAll").click(function () {
                $("#clueTBody input[type='checkbox']").prop("checked", this.checked);
            });

            // 为各个单元按钮绑定单击事件
            $("#clueTBody").on("click", "  input[type='checkbox']", function () {
                if($("#clueTBody input[type='checkbox']").size() == $("#clueTBody input[type='checkbox']:checked").size()) $("#checkAll").prop("checked", true);
                else $("#checkAll").prop("checked", false);
            });

            // 为修改按钮添加单击事件
            $("#editClueBtn").click(function () {
                var checkedList = $("#clueTBody input[type='checkbox']:checked");
                if(checkedList.size() > 1 || checkedList.size() == 0){
                    alert("请选择一条记录...");
                    return;
                }
                var id = checkedList[0].value;
                $.ajax({
                    url:'workbench/clue/queryClueById.do',
                    type:'post',
                    data:{
                        id:id
                    },
                    dataType:'json',
                    success:function (data) {
                        if(data.code == '1'){
                            $("#edit-id").val(id);
                            $("#edit-clueOwner").val(data.extend.qClue.owner);
                            $("#edit-company").val(data.extend.qClue.company);
                            $("#edit-appellation").val(data.extend.qClue.appellation);
                            $("#edit-fullname").val(data.extend.qClue.fullname);
                            $("#edit-job").val(data.extend.qClue.job);
                            $("#edit-email").val(data.extend.qClue.email);
                            $("#edit-phone").val(data.extend.qClue.phone);
                            $("#edit-website").val(data.extend.qClue.website);
                            $("#edit-mphone").val(data.extend.qClue.mphone);
                            $("#edit-state").val(data.extend.qClue.state);
                            $("#edit-source").val(data.extend.qClue.source);
                            $("#edit-description").val(data.extend.qClue.description);
                            $("#edit-contactSummary").val(data.extend.qClue.contactSummary);
                            $("#edit-nextContactTime").val(data.extend.qClue.nextContactTime);
                            $("#edit-address").val(data.extend.qClue.address);
                            $("#editClueModal").modal("show");
                        }else{
                            alert(data.msg);
                        }
                    }
                });
            });

            // 为删除按钮添加单击事件
            $("#deleteClueBtn").click(function () {
                var checkedList = $("#clueTBody input[type='checkbox']:checked");
                if(checkedList.size() == 0){
                    alert("至少删除一条线索...");
                    return ;
                }
                if(window.confirm("是否要删除这" + checkedList.size() + "条记录？")){
                    var ids = "";
                    $.each(checkedList, function (index, obj) {
                        ids += "id=" + obj.value + "&";
                    });
                    ids = ids.substr(0, ids.length - 1);
                    $.ajax({
                        url:'workbench/clue/deleteCluesByIds.do',
                        type:'post',
                        data:ids,
                        dataType:'json',
                        success:function (data) {
                            if(data.code == '1'){
                                alert("共有" + data.extend.count + "条记录受影响");
                                queryClue(1, $("#navigationBar").bs_pagination('getOption', 'rowsPerPage'));
                            }else{
                                alert(data.msg);
                            }
                        }
                    });
                }
            });

            // 为更新线索按钮绑定单击事件
            $("#updateClueBtn").click(function () {
                var id = $("#edit-id").val();
                var owner = $("#edit-clueOwner").val();
                var company = $.trim($("#edit-company").val());
                var appellation = $("#edit-appellation").val();
                var fullname = $.trim($("#edit-fullname").val());
                var job = $("#edit-job").val();
                var email = $("#edit-email").val();
                var phone = $("#edit-phone").val();
                var website = $("#edit-website").val();
                var mphone = $("#edit-mphone").val();
                var state = $("#edit-state").val();
                var source = $("#edit-source").val();
                var description = $.trim($("#edit-description").val());
                var contactSummary = $.trim($("#edit-contactSummary").val());
                var nextContactTime = $("#edit-nextContactTime").val();
                var address = $.trim($("#edit-address").val());
                // 验证邮箱是否合法
                var emailReg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
                // 验证手机号码是否合法
                var mphoneReg = /^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/;
                // 验证座机号码是否合法
                var phoneReg = /\d{3}-\d{8}|\d{4}-\d{7}/;
                // 验证网站是否合法
                var websiteReg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
                if (!emailReg.test(email)) {
                    alert("邮箱格式不正确,请重新输入...");
                    return;
                }
                if (!mphoneReg.test(mphone)) {
                    alert("手机号码格式不正确,请重新输入...");
                    return;
                }
                if (!phoneReg.test(phone)) {
                    alert("公司座机号码格式不正确,请重新输入...");
                    return;
                }
                $.ajax({
					url:'workbench/clue/updateClueByCondition.do',
					type:'post',
					data:{
					      id:id,
					      owner:owner,
					      company:company,
					      appellation:appellation,
					      fullname:fullname,
					      job:job,
					      email:email,
					      phone:phone,
					      website:website,
					      mphone:mphone,
					      state:state,
					      source:source,
					      description:description,
					      contactSummary:contactSummary,
					      nextContactTime:nextContactTime,
						  address:address
					},
					dataType:'json',
					success:function (data) {
						if(data.code == '1'){
						    alert("更新成功...");
						    // 关闭模态窗口
							$("#editClueModal").modal("hide");
							// 刷新页面
							queryClue($("#navigationBar").bs_pagination('getOption', 'currentPage'), $("#navigationBar").bs_pagination('getOption', 'rowsPerPage'))
						}else{
						    alert(data.msg);
						    // 提示错误信息，不关闭模态窗口
                            $("#editClueModal").modal("show");
						}
                    }
				});
            });
        });
</script>
</head>
<body>

	<!-- 创建线索的模态窗口 -->
	<div class="modal fade" id="createClueModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">创建线索</h4>
				</div>
				<div class="modal-body">
					<form id="createClueForm" class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="create-clueOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-clueOwner">
								  <c:forEach items="${users}" var="u">
									  <option value="${u.id}">${u.name}</option>
								  </c:forEach>
								</select>
							</div>
							<label for="create-company" class="col-sm-2 control-label">公司<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-company">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-appellation" class="col-sm-2 control-label">称呼</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-appellation">
								  <option></option>
								  <c:forEach items="${appellation}" var="a">
									  <option value="${a.id}">${a.value}</option>
								  </c:forEach>
								</select>
							</div>
							<label for="create-fullname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-fullname">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-job">
							</div>
							<label for="create-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-email">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-phone" class="col-sm-2 control-label">公司座机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-phone">
							</div>
							<label for="create-website" class="col-sm-2 control-label">公司网站</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-website">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-mphone">
							</div>
							<label for="create-state" class="col-sm-2 control-label">线索状态</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-state">
								  <option></option>
								  <c:forEach items="${clueState}" var="c">
									  <option value="${c.id}">${c.value}</option>
								  </c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-source" class="col-sm-2 control-label">线索来源</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-source">
								  <option></option>
									<c:forEach items="${source}" var="s">
										<option value="${s.id}">${s.value}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						

						<div class="form-group">
							<label for="create-description" class="col-sm-2 control-label">线索描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-description"></textarea>
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
									<input type="text" class="form-control calendarPlugin" id="create-nextContactTime" readonly>
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
					<button type="button" class="btn btn-primary" id="saveCreateClue">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改线索的模态窗口 -->
	<div class="modal fade" id="editClueModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">修改线索</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
                        <input type="hidden" id="edit-id"/>
						<div class="form-group">
							<label for="edit-clueOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-clueOwner">
                                    <c:forEach items="${users}" var="u">
                                        <option value="${u.id}">${u.name}</option>
                                    </c:forEach>
								</select>
							</div>
							<label for="edit-company" class="col-sm-2 control-label">公司<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-company">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-appellation" class="col-sm-2 control-label">称呼</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-appellation">
								  <option></option>
									<c:forEach items="${appellation}" var="a">
										<option value="${a.id}">${a.value}</option>
									</c:forEach>
								</select>
							</div>
							<label for="edit-fullname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-fullname">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-job">
							</div>
							<label for="edit-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-email">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-phone">
							</div>
							<label for="edit-website" class="col-sm-2 control-label">公司网站</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-website">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-mphone">
							</div>
							<label for="edit-state" class="col-sm-2 control-label">线索状态</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-state">
								  <option></option>
									<c:forEach items="${clueState}" var="c">
										<option value="${c.id}">${c.value}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-source" class="col-sm-2 control-label">线索来源</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-source">
								  <option></option>
								  <c:forEach items="${source}" var="s">
									  <option value="${s.id}">${s.value}</option>
								  </c:forEach>
								</select>
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
									<input type="text" class="form-control calendarPlugin" id="edit-nextContactTime" readonly>
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
					<button type="button" class="btn btn-primary" id="updateClueBtn">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>线索列表</h3>
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
                            <input class="form-control" type="text" id="query-fullname">
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="input-group">
                            <div class="input-group-addon">公司</div>
                            <input class="form-control" type="text" id="query-company">
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="input-group">
                            <div class="input-group-addon">公司座机</div>
                            <input class="form-control" type="text" id="query-phone">
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="input-group">
                            <div class="input-group-addon">线索来源</div>
                            <select class="form-control" id="query-source">
                                <option></option>
                                <c:forEach items="${source}" var="s">
                                    <option id="${s.id}">${s.value}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <br>

                    <div class="form-group">
                        <div class="input-group">
                            <div class="input-group-addon">所有者</div>
                            <input class="form-control" type="text" id="query-owner">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                            <div class="input-group-addon">手机</div>
                            <input class="form-control" type="text" id="query-mphone">
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="input-group">
                            <div class="input-group-addon">线索状态</div>
                            <select class="form-control" id="query-state">
                                <option></option>
                                <c:forEach items="${clueState}" var="c">
                                    <option id="${c.id}">${c.value}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <button type="button" class="btn btn-default" id="queryByConditionBtn">查询</button>

                </form>
            </div>
            <div class="btn-toolbar" role="toolbar"
                 style="background-color: #F7F7F7; height: 50px; position: relative;top: 40px;">
                <div class="btn-group" style="position: relative; top: 18%;">
                    <button type="button" class="btn btn-primary" id="createClueBtn"><span
                            class="glyphicon glyphicon-plus"></span> 创建
                    </button>
                    <button type="button" class="btn btn-default" id="editClueBtn"><span
                            class="glyphicon glyphicon-pencil"></span> 修改
                    </button>
                    <button type="button" class="btn btn-danger" id="deleteClueBtn"><span
                            class="glyphicon glyphicon-minus"></span> 删除
                    </button>
                </div>

            </div>
            <div style="position: relative;top: 50px;">
                <table class="table table-hover">
                    <thead>
                    <tr style="color: #B3B3B3;">
                        <td><input id="checkAll" type="checkbox"/></td>
                        <td>名称</td>
                        <td>公司</td>
                        <td>公司座机</td>
                        <td>手机</td>
                        <td>线索来源</td>
                        <td>所有者</td>
                        <td>线索状态</td>
                    </tr>
                    </thead>
                    <tbody id="clueTBody">
                    <%--<tr>--%>
                    <%--<td><input type="checkbox" /></td>--%>
                    <%--<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detdetail.jsp>李四先生</a></td>--%>
                    <%--<td>动力节点</td>--%>
                    <%--<td>010-84846003</td>--%>
                    <%--<td>12345678901</td>--%>
                    <%--<td>广告</td>--%>
                    <%--<td>zhangsan</td>--%>
                    <%--<td>已联系</td>--%>
                    <%--</tr>--%>
                    <%--<tr class="active">--%>
                    <%--<td><input type="checkbox" /></td>--%>
                    <%--<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detdetail.jsp>李四先生</a></td>--%>
                    <%--<td>动力节点</td>--%>
                    <%--<td>010-84846003</td>--%>
                    <%--<td>12345678901</td>--%>
                    <%--<td>广告</td>--%>
                    <%--<td>zhangsan</td>--%>
                    <%--<td>已联系</td>--%>
                    <%--</tr>--%>
                    </tbody>
                </table>
                <div id="navigationBar"></div>
            </div>
        </div>
    </div>
			

				<%--<div>--%>
					<%--<button type="button" class="btn btn-default" style="cursor: default;">共<b>50</b>条记录</button>--%>
				<%--</div>--%>
				<%--<div class="btn-group" style="position: relative;top: -34px; left: 110px;">--%>
					<%--<button type="button" class="btn btn-default" style="cursor: default;">显示</button>--%>
					<%--<div class="btn-group">--%>
						<%--<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">--%>
							<%--10--%>
							<%--<span class="caret"></span>--%>
						<%--</button>--%>
						<%--<ul class="dropdown-menu" role="menu">--%>
							<%--<li><a href="#">20</a></li>--%>
							<%--<li><a href="#">30</a></li>--%>
						<%--</ul>--%>
					<%--</div>--%>
					<%--<button type="button" class="btn btn-default" style="cursor: default;">条/页</button>--%>
				<%--</div>--%>
				<%--<div style="position: relative;top: -88px; left: 285px;">--%>
					<%--<nav>--%>
						<%--<ul class="pagination">--%>
							<%--<li class="disabled"><a href="#">首页</a></li>--%>
							<%--<li class="disabled"><a href="#">上一页</a></li>--%>
							<%--<li class="active"><a href="#">1</a></li>--%>
							<%--<li><a href="#">2</a></li>--%>
							<%--<li><a href="#">3</a></li>--%>
							<%--<li><a href="#">4</a></li>--%>
							<%--<li><a href="#">5</a></li>--%>
							<%--<li><a href="#">下一页</a></li>--%>
							<%--<li class="disabled"><a href="#">末页</a></li>--%>
						<%--</ul>--%>
					<%--</nav>--%>
				<%--</div>--%>
			<%--</div>--%>
			<%----%>
</body>
</html>