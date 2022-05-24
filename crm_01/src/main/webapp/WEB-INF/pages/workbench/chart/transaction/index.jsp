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
            width: 800px;
            height: 600px;
            position: absolute;
            left: 10%;
            top: 10%;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            $.ajax({
                url:'workbench/chart/transaction/queryCountOfTranGroupByStage.do',
                type:'post',
                dataType:'json',
                success:function (data) {
                    var chart = echarts.init(document.getElementById('main'));
                    var option = {
                        title:{
                            text:'交易统计图表',
                            subtext:'交易表中各个阶段的数量'
                        },
                        tooltip:{
                            trigger:'item',
                            formatter:'{a} <br />{b} : {c}'
                        },
                        toolbox:{
                            feature:{
                                dataView:{
                                    readOnly:false
                                },
                                restore:{},
                                saveAsImage:{}
                            }
                        },
                        legend:{
                            data:data.extend.stage
                        },
                        series:[{
                            name:'数据量',
                            type:'funnel',
                            left:'10%',
                            width:'80%',
                            label:{
                                formatter:'{b}'
                            },
                            labelLine:{
                                show:true
                            },
                            itemStyle:{
                                opacity:0.7
                            },
                            emphasis:{
                                label:{
                                    position:'inside',
                                    formatter:'{b}: {c}'
                                }
                            },
                            data:data.extend.funnels
                        }]
                    };
                    chart.setOption(option);
                }
            });
        });
    </script>
</head>
<body>
<div id="main"></div>
</body>
</html>