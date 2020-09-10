<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%
        //这个的路径是以斜线开始的，不以斜线结束
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <title>管理员首页</title>
    <link rel="icon" href="${APP_PATH}/statics/lightYear/favicon.ico" type="image/ico">
    <meta name="keywords" content="LightYear,光年,后台模板,后台管理系统,光年HTML模板">
    <meta name="description" content="LightYear是一个基于Bootstrap v3.3.7的后台管理系统的HTML模板。">
    <meta name="author" content="yinqi">
    <link href="${APP_PATH}/statics/lightYear/css/bootstrap.min.css" rel="stylesheet">
    <link href="${APP_PATH}/statics/lightYear/css/materialdesignicons.min.css" rel="stylesheet">
    <link href="${APP_PATH}/statics/lightYear/css/style.min.css" rel="stylesheet">
</head>

<body>
<div class="lyear-layout-web">
    <div class="lyear-layout-container">
        <!--左侧导航-->
        <aside class="lyear-layout-sidebar">

            <!-- logo -->
            <div id="logo" class="sidebar-header" style="margin-bottom:22px;margin-top:15px;">
                <a href="${APP_PATH}/admin" style="font-size:22px;">在线考试后台管理系统</a>
            </div>
            <div class="lyear-layout-sidebar-scroll">
                <nav class="sidebar-main">
                    <ul class="nav nav-drawer">
                        <li class="nav-item active">
                            <a href="${APP_PATH}/admin"><i class="mdi mdi-home"></i> 后台首页</a> </li>
                        <li class="nav-item nav-item-has-subnav">
                            <a href="${APP_PATH}/toWhere?where=admin/adminUser"><i class="mdi mdi-palette"></i> 用户管理 </a>
                        </li>
                        <li class="nav-item nav-item-has-subnav layui-this">
                            <a href="${APP_PATH}/toWhere?where=admin/adminPaper"><i class="mdi mdi-format-align-justify"></i> 试卷管理</a>

                        </li>
                        <li class="nav-item nav-item-has-subnav">
                            <a href="${APP_PATH}/toWhere?where=admin/adminProblem"><i class="mdi mdi-file-outline"></i> 题目管理</a>
                        </li>
                        <li class="nav-item nav-item-has-subnav">
                            <a href="${APP_PATH}/toWhere?where=admin/adminGrade"><i class="mdi mdi-file-music"></i> 成绩管理</a>
                        </li>
                        <li class="nav-item nav-item-has-subnav">
                            <a href="${APP_PATH}/toWhere?where=admin/adminMessage"><i class="mdi mdi-language-javascript"></i> 消息管理</a>

                        </li>
                    </ul>
                </nav>

                <div class="sidebar-footer">
                    <p class="copyright">Copyright &copy; 2020. <a target="_blank" href="http://lyear.itshubao.com">郭观辉</a> All rights reserved.</p>
                </div>
            </div>

        </aside>
        <!--End 左侧导航-->

        <!--头部信息-->
        <header class="lyear-layout-header">

            <nav class="navbar navbar-default">
                <div class="topbar">

                    <div class="topbar-left">
                        <div class="lyear-aside-toggler">
                            <span class="lyear-toggler-bar"></span>
                            <span class="lyear-toggler-bar"></span>
                            <span class="lyear-toggler-bar"></span>
                        </div>
                        <span class="navbar-page-title"> 后台首页 </span>
                    </div>

                    <ul class="topbar-right">
                        <li class="dropdown dropdown-profile">
                            <a href="javascript:void(0)" data-toggle="dropdown">
                                <img class="img-avatar img-avatar-48 m-r-10" src="${userheadpic}" alt="笔下光年" />
                                <span>${user.userName} <span class="caret"></span></span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-right">
                                <li> <a href="${APP_PATH}/toWhere?where=admin/adminProfile"><i class="mdi mdi-account"></i> 个人信息</a> </li>
                                <li> <a href="${APP_PATH}/toWhere?where=admin/adminPassword"><i class="mdi mdi-lock-outline"></i> 修改密码</a> </li>
                                <li> <a href="javascript:void(0)"><i class="mdi mdi-delete"></i> 清空缓存</a></li>
                                <li class="divider"></li>
                                <li> <a href="${APP_PATH}/userExit"><i class="mdi mdi-logout-variant"></i> 退出登录</a> </li>
                            </ul>
                        </li>
                        <!--切换主题配色-->
                        <li class="dropdown dropdown-skin">
                            <span data-toggle="dropdown" class="icon-palette"><i class="mdi mdi-palette"></i></span>
                            <ul class="dropdown-menu dropdown-menu-right" data-stopPropagation="true">
                                <li class="drop-title"><p>主题</p></li>
                                <li class="drop-skin-li clearfix">
                  <span class="inverse">
                    <input type="radio" name="site_theme" value="default" id="site_theme_1" checked>
                    <label for="site_theme_1"></label>
                  </span>
                                    <span>
                    <input type="radio" name="site_theme" value="dark" id="site_theme_2">
                    <label for="site_theme_2"></label>
                  </span>
                                    <span>
                    <input type="radio" name="site_theme" value="translucent" id="site_theme_3">
                    <label for="site_theme_3"></label>
                  </span>
                                </li>
                                <li class="drop-title"><p>LOGO</p></li>
                                <li class="drop-skin-li clearfix">
                  <span class="inverse">
                    <input type="radio" name="logo_bg" value="default" id="logo_bg_1" checked>
                    <label for="logo_bg_1"></label>
                  </span>
                                    <span>
                    <input type="radio" name="logo_bg" value="color_2" id="logo_bg_2">
                    <label for="logo_bg_2"></label>
                  </span>
                                    <span>
                    <input type="radio" name="logo_bg" value="color_3" id="logo_bg_3">
                    <label for="logo_bg_3"></label>
                  </span>
                                    <span>
                    <input type="radio" name="logo_bg" value="color_4" id="logo_bg_4">
                    <label for="logo_bg_4"></label>
                  </span>
                                    <span>
                    <input type="radio" name="logo_bg" value="color_5" id="logo_bg_5">
                    <label for="logo_bg_5"></label>
                  </span>
                                    <span>
                    <input type="radio" name="logo_bg" value="color_6" id="logo_bg_6">
                    <label for="logo_bg_6"></label>
                  </span>
                                    <span>
                    <input type="radio" name="logo_bg" value="color_7" id="logo_bg_7">
                    <label for="logo_bg_7"></label>
                  </span>
                                    <span>
                    <input type="radio" name="logo_bg" value="color_8" id="logo_bg_8">
                    <label for="logo_bg_8"></label>
                  </span>
                                </li>
                                <li class="drop-title"><p>头部</p></li>
                                <li class="drop-skin-li clearfix">
                  <span class="inverse">
                    <input type="radio" name="header_bg" value="default" id="header_bg_1" checked>
                    <label for="header_bg_1"></label>
                  </span>
                                    <span>
                    <input type="radio" name="header_bg" value="color_2" id="header_bg_2">
                    <label for="header_bg_2"></label>
                  </span>
                                    <span>
                    <input type="radio" name="header_bg" value="color_3" id="header_bg_3">
                    <label for="header_bg_3"></label>
                  </span>
                                    <span>
                    <input type="radio" name="header_bg" value="color_4" id="header_bg_4">
                    <label for="header_bg_4"></label>
                  </span>
                                    <span>
                    <input type="radio" name="header_bg" value="color_5" id="header_bg_5">
                    <label for="header_bg_5"></label>
                  </span>
                                    <span>
                    <input type="radio" name="header_bg" value="color_6" id="header_bg_6">
                    <label for="header_bg_6"></label>
                  </span>
                                    <span>
                    <input type="radio" name="header_bg" value="color_7" id="header_bg_7">
                    <label for="header_bg_7"></label>
                  </span>
                                    <span>
                    <input type="radio" name="header_bg" value="color_8" id="header_bg_8">
                    <label for="header_bg_8"></label>
                  </span>
                                </li>
                                <li class="drop-title"><p>侧边栏</p></li>
                                <li class="drop-skin-li clearfix">
                  <span class="inverse">
                    <input type="radio" name="sidebar_bg" value="default" id="sidebar_bg_1" checked>
                    <label for="sidebar_bg_1"></label>
                  </span>
                                    <span>
                    <input type="radio" name="sidebar_bg" value="color_2" id="sidebar_bg_2">
                    <label for="sidebar_bg_2"></label>
                  </span>
                                    <span>
                    <input type="radio" name="sidebar_bg" value="color_3" id="sidebar_bg_3">
                    <label for="sidebar_bg_3"></label>
                  </span>
                                    <span>
                    <input type="radio" name="sidebar_bg" value="color_4" id="sidebar_bg_4">
                    <label for="sidebar_bg_4"></label>
                  </span>
                                    <span>
                    <input type="radio" name="sidebar_bg" value="color_5" id="sidebar_bg_5">
                    <label for="sidebar_bg_5"></label>
                  </span>
                                    <span>
                    <input type="radio" name="sidebar_bg" value="color_6" id="sidebar_bg_6">
                    <label for="sidebar_bg_6"></label>
                  </span>
                                    <span>
                    <input type="radio" name="sidebar_bg" value="color_7" id="sidebar_bg_7">
                    <label for="sidebar_bg_7"></label>
                  </span>
                                    <span>
                    <input type="radio" name="sidebar_bg" value="color_8" id="sidebar_bg_8">
                    <label for="sidebar_bg_8"></label>
                  </span>
                                </li>
                            </ul>
                        </li>
                        <!--切换主题配色-->
                    </ul>

                </div>
            </nav>

        </header>
        <!--End 头部信息-->

        <!--页面主要内容-->
        <main class="lyear-layout-content">

            <div class="container-fluid">

                <div class="row">
                    <div class="col-sm-6 col-lg-3">
                        <div class="card bg-primary">
                            <div class="card-body clearfix">
                                <div class="pull-right">
                                    <p class="h6 text-white m-t-0">试卷总数</p>
                                    <p class="h3 text-white m-b-0">${paperCount}</p>
                                </div>
                                <div class="pull-left"> <span class="img-avatar img-avatar-48 bg-translucent"><i class="mdi mdi-currency-cny fa-1-5x"></i></span> </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-6 col-lg-3">
                        <div class="card bg-danger">
                            <div class="card-body clearfix">
                                <div class="pull-right">
                                    <p class="h6 text-white m-t-0">用户总数</p>
                                    <p class="h3 text-white m-b-0">${userCount}</p>
                                </div>
                                <div class="pull-left"> <span class="img-avatar img-avatar-48 bg-translucent"><i class="mdi mdi-account fa-1-5x"></i></span> </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-6 col-lg-3">
                        <div class="card bg-success">
                            <div class="card-body clearfix">
                                <div class="pull-right">
                                    <p class="h6 text-white m-t-0">题目总数</p>
                                    <p class="h3 text-white m-b-0">${problemCount}</p>
                                </div>
                                <div class="pull-left"> <span class="img-avatar img-avatar-48 bg-translucent"><i class="mdi mdi-arrow-down-bold fa-1-5x"></i></span> </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-6 col-lg-3">
                        <div class="card bg-purple">
                            <div class="card-body clearfix">
                                <div class="pull-right">
                                    <p class="h6 text-white m-t-0">留言总数</p>
                                    <p class="h3 text-white m-b-0">${messageCount}</p>
                                </div>
                                <div class="pull-left"> <span class="img-avatar img-avatar-48 bg-translucent"><i class="mdi mdi-comment-outline fa-1-5x"></i></span> </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">

                    <div class="col-lg-6">
                        <div class="card">
                            <div class="card-header">
                                <h4>每周用户</h4>
                            </div>
                            <div class="card-body">
                                <canvas class="js-chartjs-bars"></canvas>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="card">
                            <div class="card-header">
                                <h4>每周试卷数</h4>
                            </div>
                            <div class="card-body">
                                <canvas class="js-chartjs-lines"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </main>
        <!--End 页面主要内容-->
    </div>
</div>

<script type="text/javascript" src="${APP_PATH}/statics/lightYear/js/jquery.min.js"></script>
<script type="text/javascript" src="${APP_PATH}/statics/lightYear/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${APP_PATH}/statics/lightYear/js/perfect-scrollbar.min.js"></script>
<script type="text/javascript" src="${APP_PATH}/statics/lightYear/js/main.min.js"></script>

<!--图表插件-->
<script type="text/javascript" src="${APP_PATH}/statics/lightYear/js/Chart.js"></script>
<script type="text/javascript">
    $(document).ready(function(e) {
        var $dashChartBarsCnt  = jQuery( '.js-chartjs-bars' )[0].getContext( '2d' ),
            $dashChartLinesCnt = jQuery( '.js-chartjs-lines' )[0].getContext( '2d' );

        var $dashChartBarsData = {
            labels: ['周一', '周二', '周三', '周四', '周五', '周六', '周日'],
            datasets: [
                {
                    label: '注册用户',
                    borderWidth: 1,
                    borderColor: 'rgba(0,0,0,0)',
                    backgroundColor: 'rgba(51,202,185,0.5)',
                    hoverBackgroundColor: "rgba(51,202,185,0.7)",
                    hoverBorderColor: "rgba(0,0,0,0)",
                    data: [${dateList[1]}, ${dateList[2]},
                    ${dateList[3]}, ${dateList[4]}, ${dateList[5]},
                    ${dateList[6]}, ${dateList[0]}]
                }
            ]
        };
        var $dashChartLinesData = {
            labels: ['周一', '周二', '周三', '周四', '周五', '周六', '周日'],
            datasets: [
                {
                    label: '试卷数',
                    data: [${paperList[1]}, ${paperList[2]},
                    ${paperList[3]}, ${paperList[4]}, ${paperList[5]},
                    ${paperList[6]}, ${paperList[0]}],
                    borderColor: '#358ed7',
                    backgroundColor: 'rgba(53, 142, 215, 0.175)',
                    borderWidth: 1,
                    fill: false,
                    lineTension: 0.5
                }
            ]
        };

        new Chart($dashChartBarsCnt, {
            type: 'bar',
            data: $dashChartBarsData
        });

        var myLineChart = new Chart($dashChartLinesCnt, {
            type: 'line',
            data: $dashChartLinesData,
        });
    });
</script>
</body>
</html>
