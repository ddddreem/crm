<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <!-- 引入jQuery -->
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/echarts/echarts.min.js"></script>
    <style type="text/css">
        #main{
            width: 600px;
            height: 400px;
            position: absolute;
            left: 25%;
            top: 10%;
        }
    </style>
</head>
<body>
<div id="main"></div>
</body>
</html>