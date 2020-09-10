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
    <title>编辑试卷</title>
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
    <div class="layui-form-item">
        <label class="layui-form-label required">试卷名称</label>
        <div class="layui-input-block">
            <input type="text" name="paperName" lay-verify="required|content" lay-reqtext="试卷名不能为空" placeholder="请输入试卷名称" value="${paper.paperName}" class="layui-input">
            <tip>填写新建的试卷名称。</tip>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">请选择题目</label>
        <div class="layui-input-inline">
            <input type="text" name="problems" lay-verify="required" placeholder="请选择题目" autocomplete="off" class="layui-input" id="demo" value="${problems}">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">开始考试时间</label>
        <div class="layui-input-block">
            <input type="datetime-local" name="startTime" lay-verify="required" lay-reqtext="开始考试时间不能为空" placeholder="请输入开始考试时间" value="${startTime}" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">建议考试时长</label>
        <div class="layui-input-block">
            <input type="number" name="durationTime" lay-verify="required" lay-reqtext="建议时长不能为空" placeholder="请输入建议时长" value="${paper.durationTime}" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">试卷是否加密</label>
        <div class="layui-input-block">
            <c:if test="${paper.isEncry==1}">
                <input type="radio" lay-filter="noEncry" name="isEncry" value="1" title="否" id="noEncry" checked>
                <input type="radio" lay-filter="encry" name="isEncry" value="2" title="是" id="encry">
            </c:if>
            <c:if test="${paper.isEncry==2}">
                <input type="radio" lay-filter="noEncry" name="isEncry" value="1" title="否" id="noEncry">
                <input type="radio" lay-filter="encry" name="isEncry" value="2" title="是" id="encry" checked>
            </c:if>
        </div>
    </div>
    <div class="layui-form-item" id="showinviCode">
        <label class="layui-form-label required">请输入考试邀请码</label>
        <div class="layui-input-block">
            <input type="text" id="code" value="${paper.inviCode}" class="layui-input">
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
            }
        });
        tableSelect.render({
            elem: '#demo',
            searchKey: 'my',
            checkedKey: 'id',
            searchPlaceholder: '按照题目类型搜索',
            table: {
                url: '${APP_PATH}/findProblemPageByTeaId?teacherId=${userid}',
                cols: [[
                    { type: 'checkbox' },
                    {field: 'id', width: 50, title: 'ID', sort: true},
                    {field: 'type', width: 30, title: '题型'},
                    {field: 'content', width: 150, title: '题目'},
                    {field: 'answer', title: '正确答案', width: 80},
                    {field: 'analysis', width: 120, title: '答案解析'},
                    {field: 'score', width: 50, title: '分值'},
                    {field: 'createrId', width: 80, title: '创建者', sort: true},
                    {field: 'createTime', width: 120, title: '创建时间'}
                ]]
            },
            done: function (elem, data) {
                var NEWJSON = []
                layui.each(data.data, function (index, item) {
                    NEWJSON.push(item.id)
                })
                elem.val(NEWJSON.join(","))
            }
        })
        //对于是否需要邀请码
        form.on('radio(noEncry)',function (data) {
            $("#code").val("");//输入框置空
            $("#code").next("span").text("");//提示信息
            $("#showinviCode").hide();
        });
        form.on('radio(encry)',function (data) {
            $("#showinviCode").show();
        });
        //加载页面时初始化
        $(function () {
            var isEncry=${paper.isEncry};
            if(isEncry){
                $("#code").val("${paper.inviCode}");//输入框置空
                $("#code").next("span").text("");//提示信息
                $("#showinviCode").show();
            }else{
                $("#code").val("");//输入框置空
                $("#code").next("span").text("");//提示信息
                $("#showinviCode").hide();
            }

        });
        //监听提交
        form.on('submit(saveBtn)', function (data) {
            data=data.field;
            var code=$("#code").val();
            //alert(code);
            var datas={
                "paperId":${paperId},
                "teacherId":${userid},//
                "paperName":data.paperName,
                "startTime":data.startTime,
                "durationTime":data.durationTime,
                "isEncry":data.isEncry,
                "inviCode":$("#code").val(),
                "problems":data.problems
            };
            $.ajax({
                cache: false,
                url:"${APP_PATH}/updatePaper",
                type:"POST",
                async:false,
                data:datas,
                success:function (result) {
                    if(result.code==200){
                        //执行有错误时候的判断
                        layer.msg('修改试卷失败！！！！');
                    }else{
                        layer.msg('修改试卷成功');
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
