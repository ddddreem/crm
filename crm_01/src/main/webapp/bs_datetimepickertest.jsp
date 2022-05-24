<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<html>
<head>
    <base href="<%=basePath%>"/>
    <meta charset="UTF-8"/>
    <title>演示bs_datetimepicker插件</title>

    <%--引入jQuery--%>
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <%--引入bootstarp框架--%>
    <link rel="stylesheet" type="text/css" href="jquery/bootstrap_3.3.0/css/bootstrap.min.css">
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <%--引入插件所需的.css和.js文件--%>
    <link rel="stylesheet" type="text/css" href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css">
    <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
    <script type="text/javascript">
        var jsonData;
        $(function () {
            // var pageInfo = {};
            // var list = [];
            var owner = '';
            var activityName = '';
            var startTime = '';
            var endTime = '';
            var ps = '5';
            $.ajax({
                type: 'post',
                url: 'workbench/activity/queryActivitiesSelective.do',
                data: {
                    owner: owner,
                    name: activityName,
                    startTime: startTime,
                    endTime:endTime,
                    pn:'1',
                    ps:ps
                },
                dataType: 'json',
                success: function (data) {
                    jsonData = data;
                    // this.pageInfo = data.extend.pageInfo;
                    // this.list = data.extend.pageInfo.list;
                    //alert(jsonData.msg);
                }
            });
            $("#myText").datetimepicker({
                language:'zh-CN', // 语言
                format:'yyyy-mm-dd', // 日期的格式
                minView:'month', // 可以选择的最小视图
                initialDate:new Date(), // 初始化显示的日期
                autoclose:true, // 设置选择完日期或者时间之后，是否自动关闭日历
                todayBtn:true, // 设置是否显示"今天"按钮，默认设置为false
                clearBtn:true // 设置是否显示"清空"按钮，默认是false
            });

        });
    </script>
</head>
<body>
<input type="text" id="myText" readonly/>
<input type="text" id="msg" value="${jsonData.msg}">
</body>
</html>