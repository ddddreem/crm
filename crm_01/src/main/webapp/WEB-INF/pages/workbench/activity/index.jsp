<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8"/>
    <%--引入jQuery--%>
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <%--引入bootstarp框架--%>
    <link rel="stylesheet" type="text/css" href="jquery/bootstrap_3.3.0/css/bootstrap.min.css">
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <%--引入插件所需的.css和.js文件--%>
    <link rel="stylesheet" type="text/css" href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css">
    <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

    <%-- pagination 插件--%>
    <link rel="stylesheet" type="text/css" href="jquery/bs_pagination-master/css/jquery.bs_pagination.min.css"/>
    <script type="text/javascript" src="jquery/bs_pagination-master/js/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript" src="jquery/bs_pagination-master/localization/en.js"></script>
    <script type="text/javascript">

        function queryActivitySelective(pn, ps){
            var name = $("#query-name").val();
            var owner = $("#query-owner").val();
            var startTime = $("#query-startDate").val();
            var endTime = $("#query-endDate").val();
            $.ajax({
                type: 'post',
                url: 'workbench/activity/queryActivitiesSelective.do',
                data: {
                    owner: owner,
                    name: name,
                    startTime: startTime,
                    endTime:endTime,
                    pn:pn,
                    ps:ps
                },
                dataType: 'json',
                success: function (data) {
                    // 获取总页数
                    // $("#totalActivitiesB").html(data.extend.pageInfo.total);
                    // 显示市场活动列表
                    // 遍历activityList，拼接所有行数据
                    var htmlStr="";
                    $.each(data.extend.pageInfo.list, function (index, obj) {
                        htmlStr += "<tr class=\"active\">";
                        htmlStr += "<td><input type=\"checkbox\" value=\""+ obj.id + "\"/></td>";
                        htmlStr += "<td><a style=\"text-decoration: none; cursor: pointer;\" onclick=\"window.location.href='workbench/activity/detailActivity.do?id="+ obj.id +"'\">" + obj.name + "</a></td>";
                        htmlStr += "<td>" + obj.owner + "</td>";
                        htmlStr += "<td>" + obj.startDate + "</td>";
                        htmlStr += "<td>" + obj.endDate + "</td>";
                        htmlStr += "</tr>";
                    });
                    $("#tBody").html(htmlStr);

                    // 设置全选按钮为不选中，因为每次刷新调用success回调方法的时候都会刷新显示数据
                    $("#checkAll").prop("checked", false);

                    // 分页插件
                    $("#pagination").bs_pagination({
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
                            queryActivitySelective(pageObj.currentPage, pageObj.rowsPerPage);
                        }
                    });
                }
            });
        };
        $(function () {
            queryActivitySelective(1, 5);

            // 给全选单选框绑定单击事件
            $("#checkAll").click(function () {
                $("#tBody input[type='checkbox']").prop("checked", this.checked);
            });

            // 为页面中的所有除全选按钮以外的单击事件绑定单击事件
            $("#tBody").on("click", "input[type='checkbox']", function () {
                if($("#tBody input[type='checkbox']").size() == $("#tBody input[type='checkbox']:checked").size()) $("#checkAll").prop("checked", true);
                else $("#checkAll").prop("checked", false);
            });

            // 给修改市场活动按钮添加单击事件
            $("#updateActivityBtn").click(function () {
                var number = $("#tBody input[type='checkbox']:checked").size();
                if(number > 1 || number == 0){
                    alert("请选择一条记录");
                    return ;
                }
                var id = $("#tBody input[type='checkbox']:checked")[0].value;
                $.ajax({
                    url:'workbench/activity/queryActivityByID.do',
                    type:'post',
                    data:{
                        id: id
                    },
                    dataType:'json',
                    success:function (data) {
                        if(data.code == "0"){
                            alert(data.msg);
                        }else{
                            $("#edit-id").val(id);
                            // 为修改模态框中的数据赋值
                            $("#edit-marketActivityOwner").val(data.extend.activity.owner);
                            $("#edit-marketActivityName").val(data.extend.activity.name);
                            $("#edit-startDate").val(data.extend.activity.startDate);
                            $("#edit-endDate").val(data.extend.activity.endDate);
                            $("#edit-cost").val(data.extend.activity.cost);
                            $("#edit-description").val(data.extend.activity.description);
                            // 弹出模态框
                            $("#editActivityModal").modal("show");
                        }

                    }
                });
            });

            // 给更新市场活动按钮添加单击事件
            $("#update-activity").click(function () {
                if(window.confirm("是否要更新该条数据？")){
                    var id = $("#edit-id").val();
                    var owner = $("#edit-marketActivityOwner").val();
                    var name = $.trim($("#edit-marketActivityName").val());
                    var startDate = $("#edit-startDate").val();
                    var endDate = $("#edit-endDate").val();
                    var cost = $.trim($("#edit-cost").val());
                    var description = $.trim($("#edit-description").val());
                    // 表单验证
                    if (owner == null || name == null || name == "" || owner == "") {
                        alert("所有者或名称不能为空...");
                        return ;
                    }
                    if (startDate != "" && endDate != "") {
                        // 使用字符串比较大小代替日期的大小
                        if(endDate < startDate){
                            alert("结束日期不能比开始日期小...")
                            return ;
                        }
                    }
                    var regExp = /^(([1-9]\d*)|0)$/;
                    if(!regExp.test(cost)){
                        alert("成本只能为非负整数");
                        return ;
                    }
                    $.ajax({
                        url:'workbench/activity/updateActivityByID.do',
                        type:'post',
                        data:{
                            id:id,
                            owner:owner,
                            name:name,
                            startDate:startDate,
                            endDate:endDate,
                            cost:cost,
                            description:description
                        },
                        dataType:'json',
                        success:function (data) {
                            if(data.code == "0"){
                                alert(data.msg);
                                $("#editActivityModal").modal("show");
                                // return ;
                            }else{
                                alert("更新成功！");
                                $("#editActivityModal").modal("hide");
                                queryActivitySelective($("#pagination").bs_pagination('getOption', 'currentPage'), $("#pagination").bs_pagination('getOption', 'rowsPerPage'))
                            }
                        }
                    });
                }
            });

            // 给删除按钮绑定单击事件
            $("#deleteActivityBtn").click(function () {
                var checkedRecords = $("#tBody input[type='checkbox']:checked");
                if(checkedRecords.size() == 0){
                    alert("最少删除一条记录...");
                    return ;
                }
                if (window.confirm("确定要删除这" + checkedRecords.size() + "条数据吗？")) {
                    var ids = "";
                    $.each(checkedRecords, function () {
                        ids += "id=" + this.value + "&";
                    });
                    ids = ids.substr(0, ids.length - 1);
                    $.ajax({
                        url: 'workbench/activity/removeActivitiesByIds.do',
                        type: 'post',
                        data: ids,
                        dataType: 'json',
                        success: function (data) {
                            if (data.code == "0") {
                                alert(data.msg);
                            } else {
                                alert(data.msg);
                                queryActivitySelective($("#pagination").bs_pagination('getOption', 'currentPage'), $("#pagination").bs_pagination('getOption', 'rowsPerPage'));
                            }
                        }
                    });
                }
            });

            $(".calenderPlugin").datetimepicker({
                language:'zh-CN', // 语言
                format:'yyyy-mm-dd', // 日期的格式
                minView:'month', // 可以选择的最小视图
                initialDate:new Date(), // 初始化显示的日期
                autoclose:true, // 设置选择完日期或者时间之后，是否自动关闭日历
                todayBtn:true, // 设置是否显示"今天"按钮，默认设置为false
                clearBtn:true // 设置是否显示"清空"按钮，默认是false
            });
            // 给创建按钮添加单击事件
            $("#createActivityBtn").click(function () {
                // 初始化工作
                // 清空表单
                $("#createActivityForm")[0].reset();
                // 任意js代码

                // 弹出创建市场活动的模态窗口
                $("#createActivityModal").modal("show");
            });

            $("#query-selective").click(function () {
                queryActivitySelective(1, $("#pagination").bs_pagination('getOption', 'rowsPerPage'));
            });

            // 给保存按钮添加单击事件
            $("#saveActivity").click(function () {

                // 收集参数
                var owner = $("#create-marketActivityOwner").val();
                var activityName = $.trim($("#create-marketActivityName").val());
                var startDate = $("#create-startDate").val();
                var endDate = $("#create-endDate").val();
                var cost = $.trim($("#create-cost").val());
                var description = $.trim($("#create-description").val());
                // 表单验证
                if (owner == null || activityName == null || activityName == "" || owner == "") {
                    alert("所有者或名称不能为空...");
                    return ;
                }
                if (startDate != "" && endDate != "") {
                    // 使用字符串比较大小代替日期的大小
                    if(endDate < startDate){
                        alert("结束日期不能比开始日期小...")
                        return ;
                    }
                }
                var regExp = /^(([1-9]\d*)|0)$/;
                if(!regExp.test(cost)){
                    alert("成本只能为非负整数");
                    return ;
                }
                /*
                正则表达式：
                    1.语言，语法：定义字符串的匹配模式，可以用来判断指定的具体字符串是否符合匹配模式
                    2.语法通则：
                        1)// :在js中表示在js中定义一个正则表达式    var reg = /....../
                        2)[] :匹配字符集中的一位字符    var regExp = /^[abc]$/  表示字符串中只能包含abc中的一个字符
                                                    var regExp = /[a-z0-9]/
                        3)^ : 匹配字符串的开头位置
                          $ : 匹配字符串的结尾
                        4){} : 匹配次数    var regExp = /^[abc]{5}$/
                                {m} : 表示匹配m次
                                {m, n} : 表示匹配m次到n次
                                {m, } : 表示匹配m次或更多次
                        5)特殊符号：
                            \d : 匹配一位数字， 相当于[0-9]
                ​			\D : 匹配一位非数字
                ​			\w : 匹配所有字符，包括字母、数字、下划线
                ​			\W : 匹配非字符，除了字母、数字、下划线之外的字符

                ​			\* : 匹配0次或者多次，相当于{0, }
                ​			\+ : 匹配1次或者多次，相当于{1, }
                            \? : 匹配0次或者1次，相当于{0, 1}
                 */
                // 发送请求
                $.ajax({
                    type: 'post',
                    url: 'workbench/activity/saveCreateActivity.do',
                    data: {
                        owner: owner,
                        name: activityName,
                        startDate: startDate,
                        endDate:endDate,
                        cost:cost,
                        description:description
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data.code == '0') {
                            alert(data.msg);
                        } else {
                            // 保存成功则关闭模态框
                            $("#createActivityModal").modal("hide");
                            // 刷新市场活动列，显示第一页数据，保存每页显示条数不变
                            queryActivitySelective(1, $("#pagination").bs_pagination('getOption', 'rowsPerPage'));
                        }
                    }
                });
            });

            // 为批量导出按钮添加单击事件
            $("#exportActivityAllBtn").click(function () {
                window.location.href = "workbench/activity/exportAllActivities.do";
            });

            // 为选择导出按钮添加单击事件
            $("#exportActivityXzBtn").click(function () {
                var checkedRecords = $("#tBody input[type='checkbox']:checked");
                if(checkedRecords.size() == 0){
                    alert("至少选择一条数据导出...");
                    return ;
                }
                var ids = "";
                $.each(checkedRecords, function () {
                    ids += "id=" + this.value + "&";
                });
                ids = ids.substr(0, ids.length - 1);
                if(window.confirm("是否需要导出这" + checkedRecords.size() + "条数据？")){
                    window.location.href = "workbench/activity/queryActivitiesByIDs.do" + "?" + ids;
                }
                // $.ajax({
                //     url:'workbench/activity/queryActivitiesByIDs.do',
                //     type:'post',
                //     async:false,
                //     data:ids
                // });
            });

            // 用户导入市场活动
            $("#importModalBtn").click(function () {
                $("#importActivityModal").modal("show");
            });

            // 下载导入市场活动的excel模板
            $("#downloadModelBtn").click(function () {
                window.location.href = "workbench/activity/getActivityModal.do";
            });

            // 给导入按钮绑定单击事件
            $("#importActivityBtn").click(function () {
                var activityFileName = $("#activityFile").val();
                var suffix = activityFileName.substr(activityFileName.lastIndexOf(".")+ 1).toLowerCase();
                if(suffix != "xls"){
                    alert("仅支持上传.xls文件格式");
                    return ;
                }
                var activityFile = $("#activityFile")[0].files[0];
                if(activityFile.size >= 5*1024*1024){
                    alert("上传的文件过大,文件大小需控制在5M以内~");
                    return ;
                }
                // FormData是ajax提供的接口，可以模拟键值对向后台提交参数
                // FormData最大的优势是不但能提交文本数据（即普通的字符串），还能提交二进制数据
                var formDate = new FormData();
                formDate.append("activityFile", activityFile);
                // 修改传输的编码格式
                $.ajax({
                    url:'workbench/activity/importActivitiesByExcel.do',
                    type:'post',
                    data: formDate,
                    processData: false, // 默认情况下，设置ajax向后台提交参数之前，是否把参数统一转换成字符串，true---是，false---不是，默认是true
                    contentType: false, // 设置ajax向后台提交参数之前，是否把
                    dataType:'json',
                    success:function (data) {
                        if(data.code == "1"){
                            // 导入成功提示导入成功信息
                            alert("成功导入" + data.extend.count + "条记录");
                            // 关闭模态窗口
                            $("#importActivityModal").modal("hide");
                            // 刷新页面显示的内容
                            queryActivitySelective(1, $("#pagination").bs_pagination('getOption', 'rowsPerPage'));
                        }else{
                            //提示失败信息
                            alert("导入失败,请稍后重试...")
                            $("#importActivityModal").modal("show");
                        }
                    }
                });
            });
        });

    </script>
</head>
<body>

<!-- 创建市场活动的模态窗口 -->
<div class="modal fade" id="createActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
            </div>
            <div class="modal-body">

                <form id="createActivityForm" class="form-horizontal" role="form">

                    <div class="form-group">
                        <label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-marketActivityOwner">
                                <c:forEach items="${userList}" var="u">
                                    <option value="${u.id}">${u.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-marketActivityName">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-startDate" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control calenderPlugin" id="create-startDate" readonly>
                        </div>
                        <label for="create-endDate" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control calenderPlugin" id="create-endDate" readonly>
                        </div>
                    </div>
                    <div class="form-group">

                        <label for="create-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-cost">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-description" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="create-description"></textarea>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="saveActivity">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改市场活动的模态窗口 -->
<div class="modal fade" id="editActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" role="form">
                    <input type="hidden" id="edit-id"/>

                    <div class="form-group">
                        <label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-marketActivityOwner">
                                <c:forEach items="${userList}" var="u">
                                    <option value="${u.id}">${u.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-marketActivityName">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-startDate" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control calenderPlugin" id="edit-startDate" readonly>
                        </div>
                        <label for="edit-endDate" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control calenderPlugin" id="edit-endDate" readonly>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-cost">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-description" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="edit-description"></textarea>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="update-activity">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 导入市场活动的模态窗口 -->
<div class="modal fade" id="importActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">导入市场活动</h4>
            </div>
            <div class="modal-body" style="height: 350px;">
                <div style="position: relative;top: 20px; left: 50px;">
                    请选择要上传的文件：
                    <small style="color: gray;">[仅支持.xls]</small>
                </div>
                <div style="position: relative;top: 40px; left: 50px;">
                    <input type="file" id="activityFile">
                </div>
                <div style="position: relative;top: 60px; left: 50px;">
                    <input type="button" id="downloadModelBtn" value="下载模板">
                </div>
                <div style="position: relative; width: 400px; height: 320px; left: 45% ; top: -40px;">
                    <h3>重要提示</h3>
                    <ul>
                        <li>操作仅针对Excel，仅支持后缀名为XLS的文件。</li>
                        <li>给定文件的第一行将视为字段名。</li>
                        <li>请确认您的文件大小不超过5MB。</li>
                        <li>日期值以文本形式保存，必须符合yyyy-MM-dd格式。</li>
                        <li>日期时间以文本形式保存，必须符合yyyy-MM-dd HH:mm:ss的格式。</li>
                        <li>默认情况下，字符编码是UTF-8 (统一码)，请确保您导入的文件使用的是正确的字符编码方式。</li>
                        <li>建议您在导入真实数据之前用测试文件测试文件导入功能。</li>
                    </ul>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="importActivityBtn" type="button" class="btn btn-primary">导入</button>
            </div>
        </div>
    </div>
</div>


<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>市场活动列表</h3>
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
                        <input class="form-control" type="text" id="query-name"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">所有者</div>
                        <input class="form-control" type="text" id="query-owner"/>
                    </div>
                </div>


                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">开始日期</div>
                        <input class="form-control calenderPlugin" type="text" id="query-startDate" readonly/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">结束日期</div>
                        <input class="form-control calenderPlugin" type="text" id="query-endDate" readonly/>
                    </div>
                </div>

                <button type="button" class="btn btn-default" id="query-selective">查询</button>

            </form>
        </div>
        <div class="btn-toolbar" role="toolbar"
             style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-primary" id="createActivityBtn"><span
                        class="glyphicon glyphicon-plus"></span> 创建
                </button>
                <button type="button" class="btn btn-default" id="updateActivityBtn"><span
                        class="glyphicon glyphicon-pencil"></span> 修改
                </button>
                <button type="button" class="btn btn-danger" id="deleteActivityBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
            </div>
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-default" id="importModalBtn">
                    <span class="glyphicon glyphicon-import"></span> 上传列表数据（导入）
                </button>
                <button id="exportActivityAllBtn" type="button" class="btn btn-default"><span
                        class="glyphicon glyphicon-export"></span> 下载列表数据（批量导出）
                </button>
                <button id="exportActivityXzBtn" type="button" class="btn btn-default"><span
                        class="glyphicon glyphicon-export"></span> 下载列表数据（选择导出）
                </button>
            </div>
        </div>
        <div style="position: relative;top: 10px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input type="checkbox" id="checkAll"/></td>
                    <td>名称</td>
                    <td>所有者</td>
                    <td>开始日期</td>
                    <td>结束日期</td>
                </tr>
                </thead>
                <tbody id="tBody">
                <%--<tr class="active">--%>
                    <%--<td><input type="checkbox"/></td>--%>
                    <%--<td><a style="text-decoration: none; cursor: pointer;"--%>
                           <%--onclick="window.location.href='detail.jsp';">发传单</a></td>--%>
                    <%--<td>zhangsan</td>--%>
                    <%--<td>2020-10-10</td>--%>
                    <%--<td>2020-10-20</td>--%>
                <%--</tr>--%>
                <%--<tr class="active">--%>
                    <%--<td><input type="checkbox"/></td>--%>
                    <%--<td><a style="text-decoration: none; cursor: pointer;"--%>
                           <%--onclick="window.location.href='detail.jsp';">发传单</a></td>--%>
                    <%--<td>zhangsan</td>--%>
                    <%--<td>2020-10-10</td>--%>
                    <%--<td>2020-10-20</td>--%>
                <%--</tr>--%>
                </tbody>
            </table>
            <div id="pagination"></div>
        </div>

        <%--<div style="height: 50px; position: relative;top: 30px; left: 200px;">--%>
            <%--<div>--%>
                <%--<button type="button" class="btn btn-default" style="cursor: default;">共<b id="totalActivitiesB">50</b>条记录</button>--%>
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
    <%--</div>--%>
<%--</div>--%>
</body>
</html>