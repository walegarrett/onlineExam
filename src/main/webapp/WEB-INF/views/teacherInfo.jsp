<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%
        //这个的路径是以斜线开始的，不以斜线结束
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <meta charset="utf-8">
    <title>基本资料</title>
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
        <form class="layui-form layuimini-form" method="post" action="${APP_PATH}/teacherInfoChange">
            <div class="layui-form-item layui-hide">
                <label class="layui-form-label">用户ID</label>
                <div class="layui-input-block">
                    <input type="text" name="userid" value="${userid}" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item layui-disabled">
                <label class="layui-form-label">账号</label>
                <div class="layui-input-block">
                    <input type="text" name="username" placeholder="请输入管理账号"  value="${username}" class="layui-input layui-disabled">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label required">真实姓名</label>
                <div class="layui-input-block">
                    <input type="text" name="realname" lay-verify="required|trueName" lay-reqtext="真实姓名不能为空" placeholder="请输入真实姓名"  value="${user.realName}" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label required">手机</label>
                <div class="layui-input-block">
                    <input type="number" name="phone" lay-verify="required|phone" lay-reqtext="手机不能为空" placeholder="请输入手机"  value="${user.phone}" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label required">邮箱</label>
                <div class="layui-input-block">
                    <input type="email" name="email" lay-verify="required|email" lay-reqtext="邮箱不能为空" placeholder="请输入邮箱"  value="${user.email}" class="layui-input">
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
            miniTab = layui.miniTab;

        //监听提交
        form.on('submit(saveBtn)', function (data) {
            var index = layer.alert("修改成功！", function () {
                layer.close(index);
                miniTab.deleteCurrentByIframe();
            });
            return true;
        });
        // 验证
        form.verify({
            content: function (value) {
                if (value.length>200) {
                    return "输入的内容过长，请减少字数！！！";
                }
            },
            trueName:function (value) {
                // alert(value);
                if(!/^[\u4e00-\u9fa5_a-zA-Z]{2,10}$/.test(value)){
                    return "真实姓名只能是2-10位的中英文的组合";
                }
            },
            phone:function (value) {
                if(!/^1[34578]\d{9}$/.test(value)){
                    return '电话号码必须为11位纯数字';
                }
            }
        });
    });
</script>
</body>
</html>
