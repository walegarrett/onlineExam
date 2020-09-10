<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <%
        //这个的路径是以斜线开始的，不以斜线结束
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <title>管理员登录页面</title>
    <link rel="icon" href="${APP_PATH}/statics/lightYear/favicon.ico" type="image/ico">
    <meta name="keywords" content="LightYear,光年,后台模板,后台管理系统,光年HTML模板">
    <meta name="description" content="LightYear是一个基于Bootstrap v3.3.7的后台管理系统的HTML模板。">
    <meta name="author" content="yinqi">
    <link href="${APP_PATH}/statics/lightYear/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${APP_PATH}/statics/bootstrapValidator/dist/css/bootstrapValidator.css"/>
    <link href="${APP_PATH}/statics/lightYear/css/materialdesignicons.min.css" rel="stylesheet">
    <link href="${APP_PATH}/statics/lightYear/css/style.min.css" rel="stylesheet">

    <style>
        body {
            display: -webkit-box;
            display: flex;
            -webkit-box-pack: center;
            justify-content: center;
            -webkit-box-align: center;
            align-items: center;
            height: 100%;
        }
        .login-box {
            display: table;
            table-layout: fixed;
            overflow: hidden;
            max-width: 700px;
        }
        .login-left {
            display: table-cell;
            position: relative;
            margin-bottom: 0;
            border-width: 0;
            padding: 45px;
        }
        .login-left .form-group:last-child {
            margin-bottom: 0px;
        }
        .login-right {
            display: table-cell;
            position: relative;
            margin-bottom: 0;
            border-width: 0;
            padding: 45px;
            width: 50%;
            max-width: 50%;
            background: #67b26f!important;
            background: -moz-linear-gradient(45deg,#67b26f 0,#4ca2cd 100%)!important;
            background: -webkit-linear-gradient(45deg,#67b26f 0,#4ca2cd 100%)!important;
            background: linear-gradient(45deg,#67b26f 0,#4ca2cd 100%)!important;
            filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#67b26f', endColorstr='#4ca2cd', GradientType=1 )!important;
        }
        .login-box .has-feedback.feedback-left .form-control {
            padding-left: 38px;
            padding-right: 12px;
        }
        .login-box .has-feedback.feedback-left .form-control-feedback {
            left: 0;
            right: auto;
            width: 38px;
            height: 38px;
            line-height: 38px;
            z-index: 4;
            color: #dcdcdc;
        }
        .login-box .has-feedback.feedback-left.row .form-control-feedback {
            left: 15px;
        }
        @media (max-width: 576px) {
            .login-right {
                display: none;
            }
        }
    </style>
</head>

<body style="background-image: url(${APP_PATH}/statics/lightYear/images/login-bg-2.jpg); background-size: cover;">
<div class="bg-translucent p-10">
    <div class="login-box bg-white clearfix">
        <div class="login-left">
            <form action="" method="post" id="login-form">
                <div class="form-group has-feedback feedback-left">
                    <input type="text" placeholder="请输入您的用户名" class="form-control" name="username" id="username" />
                    <span class="mdi mdi-account form-control-feedback" aria-hidden="true"></span>
                </div>
                <div class="form-group has-feedback feedback-left">
                    <input type="password" placeholder="请输入密码" class="form-control" id="password" name="password" />
                    <span class="mdi mdi-lock form-control-feedback" aria-hidden="true"></span>
                </div>
                <div class="form-group has-feedback feedback-left row">
                    <div class="col-xs-7">
                        <input type="text" name="code" class="form-control" placeholder="验证码" id="code">
                        <span class="mdi mdi-check-all form-control-feedback" aria-hidden="true"></span>
                    </div>
                    <div class="col-xs-5">
                        <img id="imgObj" alt="验证码" src="${APP_PATH}/code/getCode">
                        <a onclick="changeImg()">换一张</a>
                    </div>
                </div>
                <div class="form-group">
                    <label class="lyear-checkbox checkbox-primary m-t-10">
                        <input type="checkbox"><span>5天内自动登录</span>
                    </label>
                </div>
                <div class="form-group">
                    <button class="btn btn-block btn-primary" type="button" id="submitBtn">立即登录</button>
                </div>
            </form>
        </div>
        <div class="login-right">
            <p style="text-align: center"><h3>在线考试后台管理系统</h3></p>
            <p class="text-white m-tb-15">这是在线考试系统的管理员后台登录入口，更多管理功能，敬请登录探索吧！</p>
            <p class="text-white">Copyright © 2020 <a href="http://lyear.itshubao.com">郭观辉</a>. All right reserved</p>
        </div>
    </div>
</div>
<script type="text/javascript" src="${APP_PATH}/statics/lightYear/js/jquery.min.js"></script>
<script type="text/javascript" src="${APP_PATH}/statics/lightYear/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${APP_PATH}/statics/bootstrapValidator/dist/js/bootstrapValidator.js"></script>
<script type="text/javascript">
    function changeImg() {
        $("#code").val("");
        var imgSrc = $("#imgObj");
        var src = imgSrc.attr("src");
        imgSrc.attr("src", chgUrl(src));
    }

    // 时间戳
    // 为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳
    function chgUrl(url) {
        var timestamp = (new Date()).valueOf();
        url = url.substring(0, 24);
        if ((url.indexOf("&") >= 0)) {
            url = url + "×tamp=" + timestamp;
        } else {
            url = url + "?timestamp=" + timestamp;
        }
        return url;
    }
    $("#submitBtn").click(function () {
        $.ajax({
            cache: false,
            url:"${APP_PATH}/adminLogin",
            type:"POST",
            async:false,
            data:{username:$("#username").val(),
            password:$("#password").val(),
            code:$("#code").val()},
            success:function (result) {
                if(result.code==200){
                    //执行有错误时候的判断
                    alert(result.extend.err);
                }else{
                    window.location.href="${APP_PATH}/admin";
                }
            }
        });
        return false;
    });
    $(document).ready(function() {
        $('#login-form').bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                username: {
                    message: '登录帐号不可用',
                    validators: {
                        notEmpty: {
                            message: '登录账号不能为空'
                        },
                        remote: {
                            type:"POST",
                            message: '账号不存在',
                            url: '${APP_PATH}/adminCheckUserName',
                            data: {
                                userName:'username'
                            },//这里默认会传递该验证字段的值到后端,
                            delay: 2000//每输入一个字符，就发ajax请求，服务器压力还是太大，设置2秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）
                        }
                    }
                },
                password: {
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        }
                    }
                },
                code: {
                    validators: {
                        notEmpty: {
                            message: '验证码不能为空'
                        },
                        remote: {
                            type:"POST",
                            message: '验证码错误',
                            url: '${APP_PATH}/code/checkCode',
                            data :
                                {
                                    code:'code'
                                },//这里默认会传递该验证字段的值到后端,
                            delay: 2000,//每输入一个字符，就发ajax请求，服务器压力还是太大，设置2秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）
                        }
                    }
                }
            }
        });
    });

</script>
</body>
</html>
