<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<html>
<head>
    <base href="<%=basePath%>"/>
    <meta charset="UTF-8"/>
    <%--引入jQuery--%>
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <title>文件下载</title>
    <%-- 所有文件下载的请求只能发同步请求，也就是说不能发ajax或axios请求 --%>
    <script type="text/javascript">
        $(function () {
            $("#file-download").click(function () {
                window.location.href = "filedownloadtest.do";
            });
        });
    </script>
</head>
<body>
<input type="button" value="下载" id="file-download"/>
</body>
</html>
