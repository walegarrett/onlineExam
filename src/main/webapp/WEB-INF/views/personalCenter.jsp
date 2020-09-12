<%--
  Created by IntelliJ IDEA.
  User: 浩瀚
  Date: 2020/8/10
  Time: 9:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!--

@Name：不落阁整站模板源码
@Author：Absolutely
@Site：http://www.lyblogs.cn

-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%
        //这个的路径是以斜线开始的，不以斜线结束
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <meta http-equiv="Content-Type" content="text/html; Charset=gb2312">
    <meta http-equiv="Content-Language" content="zh-CN">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>在线考试系统-首页</title>
    <link rel="shortcut icon" href="${APP_PATH}/statics/main/images/Logo_40.png" type="image/x-icon">
    <!--Layui-->
    <link href="${APP_PATH}/statics/main/plug/layui/css/layui.css" rel="stylesheet" />
    <!--font-awesome-->
    <link href="${APP_PATH}/statics/main/plug/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    <!--全局样式表-->
    <link href="${APP_PATH}/statics/main/css/global.css" rel="stylesheet" />
    <!-- 本页样式表 -->
    <link href="${APP_PATH}/statics/main/css/home.css" rel="stylesheet" />
    <script src="${APP_PATH}/statics/js/jquery-1.10.2.js"></script>
    <link href="${APP_PATH}/statics/css/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet">
    <link rel="stylesheet" href="${APP_PATH}/statics/bootstrapValidator/dist/css/bootstrapValidator.css"/>

    <script src="${APP_PATH}/statics/css/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/statics/bootstrapValidator/dist/js/bootstrapValidator.js"></script>
    <style>
        .dropdown-menu li a{
            color:#1aa094 !important;
        }
        #message{
            width:100px;
            height:20px;
            margin-top:10px;
        }
        /*角标 */
        .ii{
            /*display: none;*/
            background: #f00!important;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            position: absolute;
            top: 20px;
            right: 60px;
            text-align: center;
            color: #FFF;
            z-index: 99999;
        }
        .showdetail{
            background:#ffffff;
            width:370px;
            height:250px;
            box-shadow:0 0 10px #c4e3f3;
        }
        .person-header{
            padding: 18px 20px;
            border-bottom: 1px solid #ebeef5;
            box-sizing: border-box;
        }
        .person-body{
            padding: 20px 20px;
        }
        .person-picture{
            text-align:center;
            border-bottom: 1px solid #ebeef5;
        }
        .person-detail{
            margin-top:25px;
        }

    </style>
</head>
<body>
<%@include file="nav-top.jsp"%>
<!-- 主体（一般只改变这里的内容） -->
<div class="blog-body">
    <!-- 这个一般才是真正的主体内容 -->
    <div class="blog-container">
        <div class="blog-main">
            <!-- 网站公告提示 -->
            <div class="home-tips shadow">
                <i style="float:left;line-height:17px;" class="fa fa-volume-up"></i>
                <div class="home-tips-container">
                    <span style="color: #009688">本考试系统主要面向在校的老师和学生用户！学生可以在线考试，老师也可以发布相关的考试信息！！</span>
                    <span style="color: red">考试系统还具有信息留言的功能哦，老师可以通过这个功能向学生发送考试邀请码哦！！！</span>
                    <span style="color: red">如果你觉得这个网站做的不错，可以多多支持我哦！多多访问就是最大的支持哈！</span>
                    <span style="color: #009688">本次专业实训项目主要使用SSM框架以及前端的layui框架实现！耗时一个多月，同时支持学生，老师和管理员的各种考试相关功能！</span>
                </div>
            </div>
            <!--左边文章列表-->
            <div class="blog-main-left showdetail" style="width:35%; height: 65%">
                <!--开始陈列-->
                <div class="person">
                    <div class="person-header">
                      <h3>个人信息</h3>
                    </div>
                    <div class="person-body">
                        <div class="person-picture">
                            <img src="${userheadpic}" alt='头像' class="img-circle" width=140px height=140px>
                        </div>
                        <div class="person-detail">
                            <h4>账号：${user.userName}</h4>
                            <h4>姓名：${user.realName}</h4>
                            <h4>注册时间：${createTime}</h4>
                        </div>
                    </div>
                </div>
            </div>

            <!--右边小栏目-->
            <div class="blog-main-right showdetail" style="width:60%; height: 90%;padding:18px 20px;">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#changeInfo" data-toggle="tab">资料修改</a></li>
                    <li><a href="#changePas" data-toggle="tab">密码修改</a></li>
                    <li><a href="#changePic" data-toggle="tab">更换头像</a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane" id="changeInfo">
                        <form id="info-form" class="form" action="${APP_PATH}/userInfoChange" method="post">
                            <div class="form-group hidden">
                                <label>ID</label>
                                <input type="text" class="form-control" name="userId" value="${userid}" id="userId"/>
                            </div>
                            <div class="form-group">
                                <label>真实姓名</label>
                                <input type="text" class="form-control" name="realName" value="${user.realName}" id="realName"/>
                            </div>
                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" class="form-control" name="email" value="${user.email}" id="email"/>
                            </div>
                            <div class="form-group">
                                <label>联系电话</label>
                                <input type="text" class="form-control" name="phone" value="${user.phone}" id="phone"/>
                            </div>
                            <div class="form-group">
                                <label>年龄</label>
                                <input type="text" class="form-control" name="age" value="${user.age}" id="age"/>
                            </div>
                            <div class="form-group">
                                <label>性别</label>
                                <select name = "sex" id="sex" class="form-control">
                                    <option value = "1">男</option>
                                    <option value = "2">女</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <div class="col-md-6 col-md-offset-3 " >
                                    <button type="submit" name="login" class="btn btn-success  btn-block">修改</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="tab-pane" id="changePas">
                        <form id="password-form" class="form" action="${APP_PATH}/updatePassword" method="post">
                            <div class="form-group hidden">
                                <label>ID</label>
                                <input type="text" class="form-control" name="userId" value="${userid}" id=""/>
                            </div>
                            <div class="form-group">
                                <label>旧密码</label>
                                <input type="password" class="form-control" name="oldPassword"  id="oldPassword"/>
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
                                <div class="col-md-6 col-md-offset-3 " >
                                    <button type="submit" name="login" class="btn btn-success  btn-block">修改密码</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="tab-pane" id="changePic">
                        <div id="headPic">
                        </div>
                        <h3>上传用户头像</h3>
                        <form action="${APP_PATH}/fileupload3" method="post" enctype="multipart/form-data">
                            选择头像：<input type="file" name="upload"/><br/>
                            <input type="submit" value="上传"/>
                        </form>
                    </div>
                </div>
            </div>

            <div class="clear"></div>

        </div>
    </div>
</div>
<%@include file="nav-bottom.jsp"%>

<!-- layui.js -->
<script src="${APP_PATH}/statics/main/plug/layui/layui.js"></script>
<!-- 全局脚本 -->
<script src="${APP_PATH}/statics/main/js/global.js"></script>
<!-- 本页脚本 -->
<script src="${APP_PATH}/statics/main/js/home.js"></script>
<script src="${APP_PATH}/statics/js/common.js"></script>
<script>
    $(document).ready(function() {
        $('#info-form').bootstrapValidator({
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
        $('#password-form').bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                oldPassword: {
                    message: '密码输入错误',
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        },
                        remote: {
                            // type:"POST",
                            message: '旧密码输入错误',
                            url: '${APP_PATH}/checkPassword',
                            data: {
                                userId:${userid},
                                password:function() {
                                    return $('input[name="oldPassword"]').val()
                                }
                            },//这里默认会传递该验证字段的值到后端,
                            delay: 2000//每输入一个字符，就发ajax请求，服务器压力还是太大，设置2秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）
                        }
                    }
                },
                password: {
                    validators: {
                        notEmpty: {
                            message: '新密码不能为空'
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
                }
            }
        });
    });

    function showChangePic(){
        var headpic='${userheadpic}';
        var img=$("<img class='img-circle' width=200px height=200px>");
        img.attr("src",headpic);
        $("#headPic").append(img);
    }
    $(function(){
        showNoReadCount("${APP_PATH}","${userid}");
        showChangePic();
    });
</script>
</body>
</html>
