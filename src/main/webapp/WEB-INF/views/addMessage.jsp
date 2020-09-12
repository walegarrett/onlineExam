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
    <title>发送消息</title>
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
        <label class="layui-form-label required">标题</label>
        <div class="layui-input-block">
            <input type="text" name="title" lay-verify="required|content" lay-reqtext="标题不能为空" placeholder="请输入消息标题" value="" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">内容</label>
        <div class="layui-input-block">
            <textarea style="height:300px" type="text" name="content" lay-verify="required" lay-reqtext="内容不能为空" placeholder="请输入消息内容" value="" class="layui-input">
            </textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">接收人</label>
        <div class="layui-input-inline">
            <input type="text" name="receivers" lay-verify="required" placeholder="请选择用户" autocomplete="off" class="layui-input" id="demo" value="">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认创建</button>
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
            searchKey: 'keyword',
            checkedKey: 'id',
            searchPlaceholder: '按照用户的账号模糊搜索',
            table: {
                url: '${APP_PATH}/findUserPage',
                cols: [[
                    {type: "checkbox", width: 50},
                    {field: 'id', width: 60, title: 'ID', sort: true},
                    {field: 'userName', width: 100, title: '用户账号'},
                    {field: 'realName', width: 130, title: '用户姓名'},
                ]]
            },
            done: function (elem, data) {
                var NEWJSON = []
                layui.each(data.data, function (index, item) {
                    NEWJSON.push(item.id)
                });
                elem.val(NEWJSON.join(","))
            }
        });

        //加载页面时初始化
        $(function () {

        });
        //监听提交
        form.on('submit(saveBtn)', function (data) {
            data=data.field;
            var code=$("#code").val();
            //alert(code);
            var datas={
                "sendUserId":${userid},//
                "title":data.title,
                "content":data.content,
                "receivers":data.receivers
            };
            // alert(data.content);
            // return false;
            $.ajax({
                cache: false,
                url:"${APP_PATH}/addMessage",
                type:"POST",
                async:false,
                data:datas,
                success:function (result) {
                    if(result.code==200){
                        //执行有错误时候的判断
                        layer.msg('新建消息失败！！！！');
                    }else{
                        // layer.msg('新建消息成功！', {icon:1,time:1000},function(){
                        //     setTimeout('window.location.reload()',1000);
                        // });
                        layer.msg('新建消息成功');
                        top.layui.element.tabDelete("tab", top.jQuery(".layui-tab-title .layui-this").attr("lay-id"));
                        window.location.href="${APP_PATH}/toWhere?where=message";
                    }
                }
            });
            return false;
        });

    });
</script>
</body>
</html>
