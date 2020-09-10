<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        //这个的路径是以斜线开始的，不以斜线结束
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <meta charset="utf-8">
    <title>教师端-首页</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${APP_PATH}/statics/layuimini/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="${APP_PATH}/statics/layuimini/lib/font-awesome-4.7.0/css/font-awesome.min.css" media="all">
    <link rel="stylesheet" href="${APP_PATH}/statics/layuimini/css/public.css" media="all">
    <style>
        .layui-card {border:1px solid #f2f2f2;border-radius:5px;}
        .icon {margin-right:10px;color:#1aa094;}
        .icon-cray {color:#ffb800!important;}
        .icon-blue {color:#1e9fff!important;}
        .icon-tip {color:#ff5722!important;}
        .layuimini-qiuck-module {text-align:center;margin-top: 10px}
        .layuimini-qiuck-module a i {display:inline-block;width:100%;height:60px;line-height:60px;text-align:center;border-radius:2px;font-size:30px;background-color:#F8F8F8;color:#333;transition:all .3s;-webkit-transition:all .3s;}
        .layuimini-qiuck-module a cite {position:relative;top:2px;display:block;color:#666;text-overflow:ellipsis;overflow:hidden;white-space:nowrap;font-size:14px;}
        .welcome-module {width:100%;height:210px;}
        .panel {background-color:#fff;border:1px solid transparent;border-radius:3px;-webkit-box-shadow:0 1px 1px rgba(0,0,0,.05);box-shadow:0 1px 1px rgba(0,0,0,.05)}
        .panel-body {padding:10px}
        .panel-title {margin-top:0;margin-bottom:0;font-size:12px;color:inherit}
        .label {display:inline;padding:.2em .6em .3em;font-size:75%;font-weight:700;line-height:1;color:#fff;text-align:center;white-space:nowrap;vertical-align:baseline;border-radius:.25em;margin-top: .3em;}
        .layui-red {color:red}
        .main_btn > p {height:40px;}
        .layui-bg-number {background-color:#F8F8F8;}
        .layuimini-notice:hover {background:#f6f6f6;}
        .layuimini-notice {padding:7px 16px;clear:both;font-size:12px !important;cursor:pointer;position:relative;transition:background 0.2s ease-in-out;}
        .layuimini-notice-title,.layuimini-notice-label {
            padding-right: 70px !important;text-overflow:ellipsis!important;overflow:hidden!important;white-space:nowrap!important;}
        .layuimini-notice-title {line-height:28px;font-size:14px;}
        .layuimini-notice-extra {position:absolute;top:50%;margin-top:-8px;right:16px;display:inline-block;height:16px;color:#999;}
    </style>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">
        <div class="layui-row layui-col-space15">
            <div class="layui-col-md8">
                <div class="layui-row layui-col-space15">
                    <div class="layui-col-md6">
                        <div class="layui-card">
                            <div class="layui-card-header"><i class="fa fa-warning icon"></i>数据统计</div>
                            <div class="layui-card-body">
                                <div class="welcome-module">
                                    <div class="layui-row layui-col-space10">
                                        <div class="layui-col-xs6">
                                            <div class="panel layui-bg-number">
                                                <div class="panel-body">
                                                    <div class="panel-title">
                                                        <span class="label pull-right layui-bg-blue">实时</span>
                                                        <h5>创建试卷统计</h5>
                                                    </div>
                                                    <div class="panel-content">
                                                        <h1 class="no-margins">${paperCount}</h1>
                                                        <small>当前分类总记录数</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs6">
                                            <div class="panel layui-bg-number">
                                                <div class="panel-body">
                                                    <div class="panel-title">
                                                        <span class="label pull-right layui-bg-cyan">实时</span>
                                                        <h5>创建题目统计</h5>
                                                    </div>
                                                    <div class="panel-content">
                                                        <h1 class="no-margins">${problemCount}</h1>
                                                        <small>当前分类总记录数</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs6">
                                            <div class="panel layui-bg-number">
                                                <div class="panel-body">
                                                    <div class="panel-title">
                                                        <span class="label pull-right layui-bg-orange">实时</span>
                                                        <h5>发送消息统计</h5>
                                                    </div>
                                                    <div class="panel-content">
                                                        <h1 class="no-margins">${messageCount}</h1>
                                                        <small>当前分类总记录数</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs6">
                                            <div class="panel layui-bg-number">
                                                <div class="panel-body">
                                                    <div class="panel-title">
                                                        <span class="label pull-right layui-bg-green">实时</span>
                                                        <h5>已批改试卷统计</h5>
                                                    </div>
                                                    <div class="panel-content">
                                                        <h1 class="no-margins">${judgedCount}</h1>
                                                        <small>当前分类总记录数</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6">
                        <div class="layui-card">
                            <div class="layui-card-header"><i class="fa fa-credit-card icon icon-blue"></i>快捷入口</div>
                            <div class="layui-card-body">
                                <div class="welcome-module">
                                    <div class="layui-row layui-col-space10 layuimini-qiuck">
                                        <div class="layui-col-xs3 layuimini-qiuck-module">
                                            <a href="javascript:;" data-title="主页面" data-icon="fa fa-window-maximize">
                                                <i class="fa fa-window-maximize"></i>
                                                <cite>主页面</cite>
                                            </a>
                                        </div>
                                        <div class="layui-col-xs3 layuimini-qiuck-module">
                                            <a href="javascript:;" data-title="题目管理" data-icon="fa fa-gears">
                                                <i class="fa fa-gears"></i>
                                                <cite>题目管理</cite>
                                            </a>
                                        </div>
                                        <div class="layui-col-xs3 layuimini-qiuck-module">
                                            <a href="javascript:;" data-title="试卷管理" data-icon="fa fa-file-text">
                                                <i class="fa fa-file-text"></i>
                                                <cite>试卷管理</cite>
                                            </a>
                                        </div>
                                        <div class="layui-col-xs3 layuimini-qiuck-module">
                                            <a href="javascript:;" data-title="阅卷管理" data-icon="fa fa-dot-circle-o">
                                                <i class="fa fa-dot-circle-o"></i>
                                                <cite>阅卷管理</cite>
                                            </a>
                                        </div>
                                        <div class="layui-col-xs3 layuimini-qiuck-module">
                                            <a href="javascript:;" data-title="成绩管理" data-icon="fa fa-calendar">
                                                <i class="fa fa-calendar"></i>
                                                <cite>成绩管理</cite>
                                            </a>
                                        </div>
                                        <div class="layui-col-xs3 layuimini-qiuck-module">
                                            <a href="javascript:;" data-title="消息管理" data-icon="fa fa-hourglass-end">
                                                <i class="fa fa-hourglass-end"></i>
                                                <cite>消息管理</cite>
                                            </a>
                                        </div>
                                        <div class="layui-col-xs3 layuimini-qiuck-module">
                                            <a href="javascript:;" data-title="修改密码" data-icon="fa fa-snowflake-o">
                                                <i class="fa fa-snowflake-o"></i>
                                                <cite>修改密码</cite>
                                            </a>
                                        </div>
                                        <div class="layui-col-xs3 layuimini-qiuck-module">
                                            <a href="javascript:;" data-title="个人信息" data-icon="fa fa-search">
                                                <i class="fa fa-search"></i>
                                                <cite>个人信息</cite>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="layui-col-md12">
                        <div class="layui-card">
                            <div class="layui-card-header"><i class="fa fa-line-chart icon"></i>我创建试卷的数目统计</div>
                            <div class="layui-card-body">
                                <div id="echarts-records" style="width: 100%;min-height:500px"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="layui-col-md4">

                <div class="layui-card">
                    <div class="layui-card-header"><i class="fa fa-fire icon"></i>专业实训项目信息</div>
                    <div class="layui-card-body layui-text">
                        <table class="layui-table">
                            <colgroup>
                                <col width="100">
                                <col>
                            </colgroup>
                            <tbody>
                            <tr>
                                <td>项目名称</td>
                                <td>
                                    基于WEB的在线考试系统的设计与实现
                                </td>
                            </tr>
                            <tr>
                                <td>当前版本</td>
                                <td>v1.0.0</td>
                            </tr>
                            <tr>
                                <td>主要技术</td>
                                <td>Java / Spring / SpringMVC / Mybatis / Jquery / JavaScript / Mysql / Layui / Bootstrap</td>
                            </tr>
                            <tr>
                                <td>演示地址</td>
                                <td>
                                    学生端：<a href="http://localhost:8080/onlineExam/" target="_blank">点击查看</a><br>
                                    教师端：<a href="http://localhost:8080/onlineExam/teacher" target="_blank">点击查看</a><br>
                                    管理员端：<a href="http://localhost:8080/onlineExam/admin" target="_blank">点击查看</a><br>
                                </td>
                            </tr>
                            <tr>
                                <td>相关链接</td>
                                <td>
                                    layui：<a href="https://www.layui.com/" target="_blank">点击前往</a><br>
                                    bootstrap：<a href="https://www.bootcss.com/" target="_blank">点击前往</a><br>
                                </td>
                            </tr>

                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="layui-card">
                    <div class="layui-card-header"><i class="fa fa-paper-plane-o icon"></i>本人心语</div>
                    <div class="layui-card-body layui-text layadmin-text">
                        <p>本项目是南昌大学计算机科学与技术专业在大三小学期的专业实训项目。</p>
                        <p>该在线考试系统主要基于SSM，以及前端相关的Bootstrap和Layui框架。</p>
                        <p>本人耗费较多时间来完成此次项目，自己的编程能力和实践能力都得到了很大的提升！</p>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<script src="${APP_PATH}/statics/layuimini/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script src="${APP_PATH}/statics/layuimini/js/lay-config.js?v=1.0.4" charset="utf-8"></script>
<script>
    layui.use(['layer', 'miniTab','echarts'], function () {
        var $ = layui.jquery,
            layer = layui.layer,
            miniTab = layui.miniTab,
            echarts = layui.echarts;

        miniTab.listen();

        /**
         * 报表功能
         */
        var echartsRecords = echarts.init(document.getElementById('echarts-records'), 'walden');
        var optionRecords = {
            tooltip: {
                trigger: 'axis'
            },
            legend: {
                data:['每天创建的试卷数目']
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            toolbox: {
                feature: {
                    saveAsImage: {}
                }
            },
            xAxis: {
                type: 'category',
                boundaryGap: false,
                data: ['周一','周二','周三','周四','周五','周六','周日']
            },
            yAxis: {
                type: 'value'
            },
            series: [
                {
                    name:'创建的试卷',
                    type:'line',
                    data:[${paperList[1]}, ${paperList[2]},
                        ${paperList[3]}, ${paperList[4]}, ${paperList[5]},
                        ${paperList[6]}, ${paperList[0]}]
                }
            ]
        };
        echartsRecords.setOption(optionRecords);

        // echarts 窗口缩放自适应
        window.onresize = function(){
            echartsRecords.resize();
        }

    });
</script>
</body>
</html>
