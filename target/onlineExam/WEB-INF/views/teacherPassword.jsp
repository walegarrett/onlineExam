<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%
        //这个的路径是以斜线开始的，不以斜线结束
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <meta charset="utf-8">
    <title>修改密码</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${APP_PATH}/statics/layuimini/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="${APP_PATH}/statics/layuimini/css/public.css" media="all">
    <style>
        .layui-form-item .layui-input-company {width: auto;padding-right: 10px;line-height: 38px;}
    </style>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <form class="layui-form layuimini-form"  method="post" action="${APP_PATH}/teacherPasswordChange">
            <div class="layui-form-item layui-hide">
                <label class="layui-form-label">用户ID</label>
                <div class="layui-input-block">
                    <input type="text" name="userid" value="${userid}" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label required">旧的密码</label>
                <div class="layui-input-block">
                    <input type="password" name="old_password" lay-verify="required|checkpwd" lay-reqtext="旧的密码不能为空" placeholder="请输入旧的密码"  value="" class="layui-input">
                    <tip>填写自己账号的旧的密码。</tip>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label required">新的密码</label>
                <div class="layui-input-block">
                    <input type="password" name="new_password" lay-verify="required" lay-reqtext="新的密码不能为空" placeholder="请输入新的密码"  value="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label required">确认密码</label>
                <div class="layui-input-block">
                    <input type="password" name="again_password" lay-verify="required|checkconfirm" lay-reqtext="新的密码不能为空" placeholder="请输入新的密码"  value="" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认保存</button>
                </div>
            </div>
        </form>
    </div>
</div>
<script src="${APP_PATH}/statics/layuimini/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script src="${APP_PATH}/statics/layuimini/js/lay-config.js?v=1.0.4" charset="utf-8"></script>
<script>
    layui.use(['form','miniTab'], function () {
        var form = layui.form,
            layer = layui.layer,
            miniTab = layui.miniTab,
            $=layui.jquery;
        form.verify({
            checkpwd:function (value,item) {
                var data={
                    "userId":${userid},
                    "password":value
                };
                var errmessage="";
                $.ajax({
                    url: "${APP_PATH}/checkTeacherPassword",
                    data: data,
                    async: false,
                    type: "post",
                    success: function (result) {
                        if (result.code != 100) {
                            errmessage= "原密码输入不正确！！！";
                        }
                    }
                });
                if(errmessage!="")
                    return errmessage;
            },
            checkconfirm:function (value,item) {
                var password=$("input[name='new_password']").val();
                if(password!=value){
                    return "确认密码和密码不符！";
                }
            }
        });
        //监听提交
        // form.on('submit(saveBtn)', function (data) {
        //     var index = layer.alert(JSON.stringify(data.field), {
        //         title: '最终的提交信息'
        //     }, function () {
        //         layer.close(index);
        //         miniTab.deleteCurrentByIframe();
        //     });
        //     return false;
        // });

    });
</script>
</body>
</html>
