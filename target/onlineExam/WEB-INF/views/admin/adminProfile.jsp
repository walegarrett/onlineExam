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
    <title>管理员个人信息</title>
    <link rel="shortcut icon" href="${APP_PATH}/statics/main/images/Absolutely.jpg" type="image/x-icon">
    <meta name="keywords" content="LightYear,光年,后台模板,后台管理系统,光年HTML模板">
    <meta name="description" content="LightYear是一个基于Bootstrap v3.3.7的后台管理系统的HTML模板。">
    <meta name="author" content="yinqi">
    <link href="${APP_PATH}/statics/lightYear/css/bootstrap.min.css" rel="stylesheet">
    <link href="${APP_PATH}/statics/lightYear/css/materialdesignicons.min.css" rel="stylesheet">
    <link href="${APP_PATH}/statics/lightYear/css/style.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${APP_PATH}/statics/bootstrapValidator/dist/css/bootstrapValidator.css"/>

</head>

<body>
<div class="lyear-layout-web">
    <div class="lyear-layout-container">
        <%@include file="admin-nav.jsp"%>

        <!--页面主要内容-->
        <main class="lyear-layout-content">

            <div class="container-fluid">

                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">

                                <div class="edit-avatar">
                                    <img src="${userheadpic}" alt="..." class="img-avatar">
                                    <div class="avatar-divider"></div>
                                    <div class="edit-avatar-content">
                                        <form action="${APP_PATH}/uploadAdminPicture" method="post" enctype="multipart/form-data">
                                            选择头像：<input type="file" class="btn btn-default" name="upload"/><br/>
                                            <input class="btn btn-default" type="submit" value="上传"/>
                                        </form>
<%--                                        <button class="btn btn-default">修改头像</button>--%>
                                        <p class="m-0">选择一张你喜欢的图片，上传图片大小不能超过2M。</p>
                                    </div>
                                </div>
                                <hr>
                                <form method="post" action="${APP_PATH}/adminInfoChange" id="update-form" class="site-form">
                                    <div class="form-group hidden">
                                        <label for="userId">ID</label>
                                        <input type="text" class="form-control" name="userId" id="userId" value="${userid}"/>
                                    </div>
                                    <div class="form-group">
                                        <label for="userName">用户名</label>
                                        <input type="text" class="form-control" name="userName" id="userName" value="${user.userName}" disabled="disabled" />
                                    </div>
                                    <div class="form-group">
                                        <label for="realName">真实姓名</label>
                                        <input type="text" class="form-control" name="realName" id="realName" placeholder="输入您的真实姓名" value="${user.realName}">
                                    </div>
                                    <div class="form-group">
                                        <label for="email">邮箱</label>
                                        <input type="email" class="form-control" name="email" id="email" aria-describedby="emailHelp" placeholder="请输入正确的邮箱地址" value="${user.email}">
                                        <small id="emailHelp" class="form-text text-muted">请保证您填写的邮箱地址是正确的。</small>
                                    </div>
                                    <button type="submit" class="btn btn-primary">保存</button>
                                </form>

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
<script type="text/javascript" src="${APP_PATH}/statics/bootstrapValidator/dist/js/bootstrapValidator.js"></script>
<script>
    $(document).ready(function() {
        $('#update-form').bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
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
                uPassword: {
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        },stringLength: {  //长度限制
                            min: 4,
                            max: 18,
                            message: '密码长度必须在4到18位之间'
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
                }
            }
        });
    });
</script>
</body>
</html>
