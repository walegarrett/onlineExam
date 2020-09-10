<%--
  Created by IntelliJ IDEA.
  User: 浩瀚
  Date: 2020/8/7
  Time: 22:39
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
    <meta charset="utf-8">
    <title>成绩管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${APP_PATH}/statics/layuimini/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="${APP_PATH}/statics/layuimini/css/public.css" media="all">
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <fieldset class="table-search-fieldset">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">答卷ID</label>
                            <div class="layui-input-inline">
                                <input type="number" name="id" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">试卷名称</label>
                            <div class="layui-input-inline">
                                <input type="text" name="paperName" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">学生账号</label>
                            <div class="layui-input-inline">
                                <input type="text" name="userName" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <button type="submit" class="layui-btn layui-btn-primary"  lay-submit lay-filter="data-search-btn"><i class="layui-icon"></i> 搜 索</button>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>

        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-sm layui-btn-danger data-delete-btn" lay-event="delete"> 删除 </button>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">修改成绩</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
        </script>

    </div>
</div>
<script type="text/javascript" src="${APP_PATH}/statics/layuimini/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;

        table.render({
            elem: '#currentTableId',
            //首先根据teacherid找到创建的所有试卷，再根据每个paperId找到所有的Sheet即答卷
            url: '${APP_PATH}/findJudgedSheetByTeaId?teacherId=${userid}',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                {field: 'id', width: 80, title: 'ID', sort: true},
                {field: 'paperId', title: '试卷id', width: 80},
                {field: 'paperName', width: 150, title: '试卷名称'},
                {field: 'userId', title: '学生id', width: 80},
                {field: 'userName', width: 200, title: '学生账号'},
                {field: 'score', width: 100, title: '分数', sort: true},
                {title: '操作', minWidth: 150, toolbar: '#currentTableBar', align: "center"}
            ]],
            limits: [1, 4, 7, 10, 13, 16],//数据分页条
            limit: 10,//默认十条数据一页
            page: true,//开启分页
            skin: 'line'
        });

        // 监听搜索操作
        form.on('submit(data-search-btn)', function (data) {
            var result = JSON.stringify(data.field);
            // layer.alert(result, {
            //     title: '最终的搜索信息'
            // });
            var id=$("input[name='id']").val();
            var reg = /^[0-9]+.?[0-9]*$/;
            if (reg.test(id)) {
                id=parseInt(id);
            }else id=-1;
            var title=$("input[name='paperName']").val();
            var userName=$("input[name='userName']").val();
            //执行搜索重载
            table.reload('currentTableId', {
                page: {
                    curr: 1
                }
                , where: {
                    sheetId:id,
                    paperName:title,
                    userName:userName,
                    teacherId:${userid}
                },
                url: '${APP_PATH}/searchGrade'//后台做模糊搜索接口路径
                , method: 'post'
            }, 'data');

            return false;
        });

        /**
         * toolbar监听事件
         */
        table.on('toolbar(currentTableFilter)', function (obj) {
            if (obj.event === 'add') {  // 监听添加操作
                var index = layer.open({
                    title: '添加试卷',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '${APP_PATH}/toWhere?where=addPaper',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            } else if (obj.event === 'delete') {  // 监听删除操作
                var checkStatus = table.checkStatus('currentTableId')
                    , data = checkStatus.data;
                layer.alert(JSON.stringify(data));
            }
        });

        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });

        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'edit') {
                var index = layer.open({
                    title: '修改成绩',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '${APP_PATH}/toEditGrade?sheetId='+data.id,
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } else if (obj.event === 'delete') {
                // layer.confirm('真的删除行么', function (index) {
                //     obj.del();
                //     layer.close(index);
                // });
                var datas={
                    "sheetId":data.id//
                };
                $.ajax({
                    cache: false,
                    url:"${APP_PATH}/deleteGrade",
                    type:"POST",
                    async:false,
                    data:datas,
                    success:function (result) {
                        if(result.code==200){
                            //执行有错误时候的判断
                            layer.msg('删除成绩失败！');
                        }else{
                            layer.msg('删除成绩成功！');
                        }
                    }
                });
            }
        });

    });
</script>

</body>
</html>
