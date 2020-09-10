<%--
  Created by IntelliJ IDEA.
  User: 浩瀚
  Date: 2020/8/8
  Time: 20:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta charset="utf-8">
    <%
        //这个的路径是以斜线开始的，不以斜线结束
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <title>修改成绩</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${APP_PATH}/statics/layuimini/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="${APP_PATH}/statics/layuimini/css/public.css" media="all">
    <style>
        body {
            background-color: #ffffff;
        }
    </style>
</head>
<body>
<div class="layui-form layuimini-form">
    <div class="layui-form-item layui-hide">
        <label class="layui-form-label required">答卷ID</label>
        <div class="layui-input-block">
            <input type="text" name="sheetId" value="${sheetId}" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">试卷名称</label>
        <div class="layui-input-block">
            <input type="text" name="paperName" value="${paper.paperName}" class="layui-input  layui-disabled">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">学生账号</label>
        <div class="layui-input-block">
            <input type="text" name="userName"  value="${user.userName}" class="layui-input  layui-disabled">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">成绩</label>
        <div class="layui-input-block">
            <input type="number" name="score" lay-verify="required|score" lay-reqtext="成绩不能为空" placeholder="请输入修改后的成绩" value="${sheet.score}" class="layui-input">
            <tip>该套试卷的总分为：${totalScore}</tip>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认修改</button>
        </div>
    </div>
</div>
<%--<script type="text/javascript" src="${APP_PATH}/statics/bootstrapValidator/vendor/jquery/jquery-1.10.2.min.js"></script>--%>
<script src="${APP_PATH}/statics/layuimini/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script src="${APP_PATH}/statics/layuimini/js/lay-config.js?v=1.0.4" charset="utf-8"></script>
<script>

    layui.use(['jquery','layer','table', 'form', 'tableSelect'], function () {
        var form = layui.form,
            layer = layui.layer;
        // $ = layui.$;

        //多选题目
        var $ = layui.jquery,
            table = layui.table,
            tableSelect = layui.tableSelect;
        // 验证
        form.verify({
            content: function (value) {
                if (value.length>200) {
                    return "输入的内容过长，请减少字数！！！";
                }
            },
            score:function (value) {
                var totalScore=${totalScore};
                var score=parseInt(value);
                if(score>totalScore)
                    return "分数不能超过满分！！";
                if(score<0)
                    return "分数不能为0！！！";
            }
        });

        //加载页面时初始化
        $(function () {

        });
        //监听提交
        form.on('submit(saveBtn)', function (data) {
            data=data.field;
            var score=data.score;
            score=parseInt(score);
            var datas={
                "sheetId":${sheetId},
                "score":score
            };
            $.ajax({
                cache: false,
                url:"${APP_PATH}/updateGrade",
                type:"POST",
                async:false,
                data:datas,
                success:function (result) {
                    if(result.code==200){
                        //执行有错误时候的判断
                        layer.msg('修改成绩失败！！！！');
                    }else{
                        layer.msg('修改成绩成功');
                        var iframeIndex = parent.layer.getFrameIndex(window.name);
                        parent.layer.close(iframeIndex);
                    }
                }
            });
            return false;
        });
    });
</script>
</body>
</html>
