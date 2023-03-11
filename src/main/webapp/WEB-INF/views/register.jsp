<%--
  Created by IntelliJ IDEA.
  User: lemon
  Date: 2019/12/10
  Time: 11:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>用户注册</title>
    <%
        //这个的路径是以斜线开始的，不以斜线结束
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <link rel="shortcut icon" href="${APP_PATH}/statics/main/images/Absolutely.jpg" type="image/x-icon">
    <!--
        web路径：
        1.不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题
        2.以/开始的相对路径，找资源，以服务器的路径为标准，需要加上项目名称
    -->
    <link rel="stylesheet" href="${APP_PATH}/statics/bootstrapValidator/vendor/bootstrap/css/bootstrap.css"/>
    <link rel="stylesheet" href="${APP_PATH}/statics/bootstrapValidator/dist/css/bootstrapValidator.css"/>

    <script type="text/javascript" src="${APP_PATH}/statics/bootstrapValidator/vendor/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/statics/bootstrapValidator/vendor/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/statics/bootstrapValidator/dist/js/bootstrapValidator.js"></script>


    <style>
        body{
            background: url("${APP_PATH}/statics/images/login/login1.jpg");
            animation-name:myfirst;
            animation-duration:12s;
            /*变换时间*/
            animation-delay:8s;
            /*动画开始时间*/
            animation-iteration-count:infinite;
            /*下一周期循环播放*/
            animation-play-state:running;
            /*动画开始运行*/
        }
        @keyframes myfirst
        {
            0%   {background:url("${APP_PATH}/statics/images/login/login1.jpg");}
            34%  {background:url("${APP_PATH}/statics/images/login/login2.jpg");}
            67%  {background:url("${APP_PATH}/statics/images/login/login3.jpg");}
            100% {background:url("${APP_PATH}/statics/images/login/login4.jpg");}
        }
        .form{background: rgba(255,255,255,0.2);width:400px;margin:120px auto;}
        /*阴影*/
    </style>
    <script>
        function isLogin_Error() {
            var mess="${message}";
            <%--$(function(){--%>
            <%--    var args={"time":new Date()};--%>
            <%--    $.getJSON("${APP_PATH}/user/userLogin",args,function (data){--%>
            <%--        mess=data.message--%>
            <%--    })--%>
            <%--});--%>
            if (mess!=""){
                $(function () { $('#myModal').on('show.bs.modal', function () {
                    var modal = $(this);
                    //此处即为修改modal的内容
                    modal.find('.modal-body').text(mess)
                }) });
                $("#myModal").modal();
            }
        }

        $("#myModal").on("hidden.bs.modal", function() {
            $(this).removeData("bs.modal");
        });
    </script>
</head>
<body onload="isLogin_Error()">
<form id="login-form" class="form" action="${APP_PATH}/userRegister" method="post">
    <div class="form-group">
        <label>账号</label>
        <input type="text" class="form-control" name="userName" id="userName" data-bv-notempty-message="姓名栏不能为空"/>
    </div>
    <div class="form-group">
        <label>真实姓名</label>
        <input type="text" class="form-control" name="realName"  id="code"/>
    </div>
    <div class="form-group">
        <label>密码</label>
        <input type="password" class="form-control" name="password" id="password"/>
    </div>
    <div class="form-group">
        <label>确认密码</label>
        <input type="password" class="form-control" name="confirmPassword" id="confirmPassword"/>
    </div>
    <div class="form-group">
        <label>Email</label>
        <input type="email" class="form-control" name="email" id="email"/>
    </div>
    <div class="form-group">
        <label>联系电话</label>
        <input type="text" class="form-control" name="phone" id="phone"/>
    </div>
    <div class="form-group">
        <label>年龄</label>
        <input type="text" class="form-control" name="age" id="age"/>
    </div>
    <div class="form-group">
        <label>性别</label>
        <select name = "sex" id="sex" class="form-control">
            <option value = "1">男</option>
            <option value = "2">女</option>
        </select>
    </div>
    <div class="form-group">
        <label>角色</label>
        <select name = "role" id="role" class="form-control">
            <option value = "1">学生</option>
            <option value = "2">老师</option>
        </select>
    </div>
    <div class="form-group">
        <div class="col-md-4 col-md-offset-8">
            <a href="${APP_PATH}/login" ><label style="font-size: 12px;text-decoration: none">登录/</label></a>
            <a href="${APP_PATH}/toAdminLogin"><label style="font-size: 12px;text-decoration: none">管理员登录</label></a>
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-6 col-md-offset-3 " >
            <button type="submit" name="login" class="btn btn-success  btn-block"
                    onclick="login()">注册</button>
        </div>
    </div>
</form>

<%--登录错误提示的模态框--%>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    注册失败
                </h4>
            </div>
            <div class="modal-body" >
                <h3 id="login_fault_message"></h3>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">关闭
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

</body>
</html>


<script>
    $(document).ready(function() {
        $('#login-form').bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                userName: {
                    message: '登录帐号不可用',
                    validators: {
                        notEmpty: {
                            message: '登录账号不能为空'
                        },
                        stringLength: {  //长度限制
                            min: 4,
                            max: 18,
                            message: '账号长度必须在4到18位之间'
                        },
                        regexp: { //正则表达式
                            regexp: /^[a-zA-Z0-9_]+$/,
                            message: '账号只能包含英文大写、小写、数字和下划线'
                        },
                        remote: {
                            type:"POST",
                            message: '账号已存在',
                            url: '${APP_PATH}/registerCheckUserName',
                            data: {
                                    userName:'userName'
                                },//这里默认会传递该验证字段的值到后端,
                            delay: 2000//每输入一个字符，就发ajax请求，服务器压力还是太大，设置2秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）
                        }
                    }
                },
                realName: {
                    message: '真实姓名不可用',
                    validators: {
                        notEmpty: {
                            message: '真实姓名不能为空'
                        },
                        regexp: { //正则表达式
                            regexp: /^[\u4e00-\u9fa5_a-zA-Z]{2,10}$/,
                            message: '真实姓名只能是2-10位的中英文的组合'
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
                confirmPassword:{
                    validators:{
                        notEmpty: {
                            message: '确认密码不能为空'
                        },
                        identical: {  //比较是否相同
                            field: 'password',  //需要进行比较的input name值
                            message: '两次密码不一致'
                        }
                    }
                },
                email: {
                    validators: {
                        notEmpty: {
                            message: 'email不能为空'
                        },
                        emailAddress:{
                            message:"邮箱格式不正确，邮箱不可用！"
                        }
                    }
                },
                phone:{
                    validators:{
                        notEmpty:{
                            message:"电话号码不能为空"
                        },
                        regexp: { //正则表达式
                            regexp: /^1[34578]\d{9}$/,
                            message: '电话号码必须为11位纯数字'
                        }
                    }
                },
                age:{
                    validators:{
                        notEmpty:{
                            message:"年龄不能为空"
                        },
                        regexp: { //正则表达式
                            regexp: /^[0-9]+.?[0-9]*$/,
                            message: '年龄必须为数字'
                        }
                    }
                }
            }
        });
    });
</script>



