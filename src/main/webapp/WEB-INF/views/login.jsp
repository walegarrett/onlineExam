<%--
  Created by IntelliJ IDEA.
  User: 浩瀚
  Date: 2020/8/6
  Time: 20:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <%
        //这个的路径是以斜线开始的，不以斜线结束
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <META   HTTP-EQUIV="Pragma"   CONTENT="no-cache">
    <META   HTTP-EQUIV="Cache-Control"   CONTENT="no-cache">
    <META   HTTP-EQUIV="Expires"   CONTENT="0">
    <meta charset="UTF-8">
    <title>用户登陆</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="shortcut icon" href="${APP_PATH}/statics/main/images/Absolutely.jpg" type="image/x-icon">
    <link rel="stylesheet" href="${APP_PATH}/statics/layuimini/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="${APP_PATH}/statics/bootstrapValidator/vendor/bootstrap/css/bootstrap.css"/>
    <link rel="stylesheet" href="${APP_PATH}/statics/bootstrapValidator/dist/css/bootstrapValidator.css"/>

    <script type="text/javascript" src="${APP_PATH}/statics/bootstrapValidator/vendor/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/statics/bootstrapValidator/vendor/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/statics/bootstrapValidator/dist/js/bootstrapValidator.js"></script>
    <!--[if lt IE 9]>
    <script type="text/javascript" src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js" charset="utf-8"></script>
    <![endif]-->
    <style>
        html, body {width: 100%;height: 100%;overflow: hidden}
        body {background: #1E9FFF;}
        body:after {content:'';background-repeat:no-repeat;background-size:cover;-webkit-filter:blur(3px);-moz-filter:blur(3px);-o-filter:blur(3px);-ms-filter:blur(3px);filter:blur(3px);position:absolute;top:0;left:0;right:0;bottom:0;z-index:-1;}
        .layui-container {width: 100%;height: 100%;overflow: hidden}
        .admin-login-background {width:360px;height:300px;position:absolute;left:50%;top:40%;margin-left:-180px;margin-top:-100px;}
        .logo-title {text-align:center;letter-spacing:2px;padding:14px 0;}
        .logo-title h1 {color:#1E9FFF;font-size:25px;font-weight:bold;}
        .login-form {background-color:#fff;border:1px solid #fff;border-radius:3px;padding:14px 20px;box-shadow:0 0 8px #eeeeee;}
        .login-form .layui-form-item {position:relative;}
        .login-form .layui-form-item label {position:absolute;left:1px;top:1px;width:38px;line-height:36px;text-align:center;color:#d2d2d2;}
        .login-form .layui-form-item input {padding-left:36px;}
        .captcha {width:60%;display:inline-block;}
        .captcha-img {display:inline-block;width:34%;float:right;}
        .captcha-img img {height:34px;border:1px solid #e6e6e6;height:36px;width:100%;}
        #loginsubmit{margin-top:-280px !important;}
    </style>
    <script>
        function isLogin_Error() {
            var mess="${message}";
            //alert(mess);
            if (mess!=""){
                //layer.msg(mess);
                $('#myModal').on('show.bs.modal', function (event) {
                    var button = $(event.relatedTarget) // Button that triggered the modal
                    var modal = $(this)
                    // modal.find('.modal-title').text('New message to ')
                    modal.find('.modal-body #login_fault_message').text(mess)
                });
                $("#myModal").modal();
            }
        };
        $("#myModal").on("hidden.bs.modal", function() {
            $(this).removeData("bs.modal");
        });
    </script>
</head>
<body onload="isLogin_Error()"> <%--onload="isLogin_Error()"--%>
<div class="layui-container">
    <div class="admin-login-background">
        <div class="layui-form login-form">
            <form class="layui-form" method="post" action="${APP_PATH}/userLogins" id="loginForm">
                <div class="layui-form-item logo-title">
                    <h1>用户登录</h1>
                </div>
                <div class="layui-form-item">
                    <%--@declare id="username"--%><label class="layui-icon layui-icon-username" for="username"></label>
                    <input type="text" name="username" lay-verify="required|account|username" placeholder="用户名" autocomplete="off" class="layui-input" value="admin">
                </div>
                <div class="layui-form-item">
                    <%--@declare id="password"--%><label class="layui-icon layui-icon-password" for="password"></label>
                    <input type="password" name="password" lay-verify="required|password" placeholder="密码" autocomplete="off" class="layui-input" value="123456">
                </div>
                <div class="layui-form-item">
                    <%--@declare id="captcha"--%><label class="layui-icon layui-icon-vercode" for="captcha"></label>
                    <input type="text" name="captcha" lay-verify="required|captcha" placeholder="图形验证码" autocomplete="off" class="layui-input verification captcha" value="">
                    <div class="captcha-img">
                        <img id="captchaPic" src="${APP_PATH}/code/getCode" onclick="changeImg()">
                    </div>
                </div>
                <div class="layui-form-item" style="width:38px !important;">
                    <input type="checkbox" name="rememberMe" value="true" lay-skin="primary" title="记住密码">
                </div>
                <div class="layui-form-item" id="loginsubmit">
                    <div style="margin-bottom: 20px">
                        <span style="margin-right:15px;"><a href="${APP_PATH}/index2.jsp">回到主页</a></span>
                        <span >没有账号？<a href="${APP_PATH}/register">点击注册</a></span>
                        <span style="margin-left:35px;"><a href="${APP_PATH}/toAdminLogin">管理员登录</a></span>
                    </div>
                    <button id="submitBtn" class="layui-btn layui-btn layui-btn-normal layui-btn-fluid" lay-submit="" lay-filter="login">登 入</button>
                </div>
            </form>
        </div>
    </div>
</div>
<%--登录错误提示的模态框--%>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    登录失败
                </h4>
            </div>
            <div class="modal-body">
                <h4 id="login_fault_message"></h4>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-primary" data-dismiss="modal">关闭
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<%--<script src="${APP_PATH}/statics/layuimini/lib/jquery-3.4.1/jquery-3.4.1.min.js" charset="utf-8"></script>--%>
<%--<script type="text/javascript" src="${APP_PATH}/statics/layuimini/lib/layui-v2.5.5/layui.all.js" charset="utf-8"></script>--%>
<script type="text/javascript" src="${APP_PATH}/statics/layuimini/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="${APP_PATH}/statics/layuimini/lib/jq-module/jquery.particleground.min.js" charset="utf-8"></script>
<script>
    function changeImg() {
        $("#captcha").val("");
        var imgSrc = $("#captchaPic");
        var src = imgSrc.attr("src");
        //alert(src);
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
    layui.use(['form'], function () {
        var form = layui.form,
            layer = layui.layer;
        form.verify({
            username: function(value, item) {
                if(value.length>50||value.length<=0)
                    return "请输入准确用户名";
                if (!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)) {
                    return '用户名不能有特殊字符';
                }
                if (/(^\_)|(\__)|(\_+$)/.test(value)) {
                    return '用户名首尾不能出现下划线\'_\'';
                }
                if (/^\d+\d+\d$/.test(value)) {
                    return '用户名不能全为数字';
                }
                var errmessages="";
                $.ajax({
                    url:"${APP_PATH}/checkUserName",
                    type:"POST",
                    async:false,
                    data:{username:value},
                    success:function (result) {
                        if(result.code==200){
                            //执行有错误时候的判断
                            errmessages="用户不存在！"
                        }
                    }
                });
                if(errmessages!="")
                    return errmessages;
            },
            <%--password: function(value,item){--%>
            <%--    if(value.length>50||value.length<=0)--%>
            <%--        return "请输入准确密码";--%>
            <%--    var username=$("input[name='username']").val();--%>
            <%--    var errmessages="";--%>
            <%--    $.ajax({--%>
            <%--        url:"${APP_PATH}/checkLoginPassword",--%>
            <%--        type:"POST",--%>
            <%--        async:false,--%>
            <%--        data:{--%>
            <%--            username:username,--%>
            <%--            password:value--%>
            <%--        },--%>
            <%--        success:function (result) {--%>
            <%--            if(result.code==200){--%>
            <%--                //执行有错误时候的判断--%>
            <%--                errmessages="密码错误！"--%>
            <%--            }--%>
            <%--        }--%>
            <%--    });--%>
            <%--    if(errmessages!="")--%>
            <%--        return errmessages;--%>
            <%--},--%>
            captcha: function (value,item) {
                if(value.length!=4)
                    return "请输入正确验证码！";
                var data={
                    "code":value
                };
                var errmessage="";
                $.ajax({
                    url: "${APP_PATH}/checkLoginCode",
                    data: data,
                    async: false,
                    type: "post",
                    success: function (result) {
                        if (result.code != 100) {
                            errmessage= "验证码输入不正确！！！";
                        }
                    }
                });
                // alert(errmessage);
                if(errmessage!="")
                    return errmessage;
            }

        });

        // 登录过期的时候，跳出ifram框架
        if (top.location != self.location) top.location = self.location;

        // 粒子线条背景
        $(document).ready(function(){
            // isLogin_Error();
            $('.layui-container').particleground({
                dotColor:'#7ec7fd',
                lineColor:'#7ec7fd'
            });
        });

        // 进行登录操作,监听登录事件
    });
</script>
</body>
</html>
