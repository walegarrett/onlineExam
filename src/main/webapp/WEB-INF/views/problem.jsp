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
    <title>我创建的题目列表</title>
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
                            <label class="layui-form-label">题目ID</label>
                            <div class="layui-input-inline">
                                <input type="text" name="id" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">题型</label>
                            <div class="layui-input-inline">
                                <input type="text" name="type" autocomplete="off" class="layui-input">
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
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"> 添加 </button>
                <button class="layui-btn layui-btn-sm layui-btn-danger data-delete-btn" lay-event="delete"> 删除 </button>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
        </script>

    </div>
</div>
<script src="${APP_PATH}/statics/layuimini/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;

        table.render({
            elem: '#currentTableId',
            url: '${APP_PATH}/findProblemPageByTeaId?teacherId=${userid}',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                {field: 'id', width: 60, title: 'ID', sort: true},
                {field: 'typeName', width: 100, title: '题型'},
                {field: 'titleContent', width: 130, title: '题干'},
                {field: 'answer', title: '正确答案', width: 100},
                {field: 'analysis', width: 120, title: '答案解析'},
                {field: 'score', width: 70, title: '分值'},
                {field: 'createrId', width: 100, title: '创建者', sort: true},
                {field: 'createTime', width: 200, title: '创建时间'},
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
            var type=$("input[name='type']").val();
            var typeId=0;
            if(type=="单选题"||type=="单选"){
                typeId=1;
            }else if(type=="多选题"||type=="多选"){
                typeId=2;
            }else if(type=="判断题"||type=="判断"){
                typeId=3;
            }else if(type=="填空题"||type=="填空"){
                typeId=4;
            }else if(type=="简答题"||type=="简答"){
                typeId=5;
            }else typeId=0;
            // alert(id+" "+typeId);
            //执行搜索重载
            table.reload('currentTableId', {
                page: {
                    curr: 1
                },
                where: {
                    id:id,
                    type:typeId,
                    teacherId:${userid}
                    // searchParams: result
                },
                url: '${APP_PATH}/searchProblem'//后台做模糊搜索接口路径
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
                    title: '添加题目',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '${APP_PATH}/toWhere?where=addProblem',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            } else if (obj.event === 'delete') {  // 监听删除操作
                var checkStatus = table.checkStatus('currentTableId')
                    , data = checkStatus.data;
                var empNames="";
                var del_idstr="";
                // layer.alert(JSON.stringify(data));
                for(i=0;i<data.length;i++){
                    //alert(data[i].id);
                    empNames+=data[i].paperName+" ,";
                    //组装员工id的字符串
                    del_idstr+=data[i].id+"-";
                }

                //去除empNames多余的逗号
                empNames=empNames.substring(0,empNames.length-1);
                del_idstr=del_idstr.substring(0,del_idstr.length-1);
                var data=
                    {
                        "problemId":del_idstr
                    };

                if(confirm("确认删除【"+del_idstr+"】吗？")){
                    //确认，发送ajax请求删除
                    $.ajax({
                        url:"${APP_PATH}/deleteProblem",
                        type:"POST",
                        data:data,
                        success:function (result) {
                            if(result.code==100) {
                                alert("删除成功");
                                to_page(currentPage);
                            }else{
                                alert("删除失败");
                                to_page(currentPage);
                            }
                        }
                    });
                }
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
                    title: '编辑题目',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '${APP_PATH}/toEditProblem?problemId='+data.id,
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } else if (obj.event === 'delete') {
                if(confirm("确认删除【"+data.id+"】号题目吗？")){
                    var datas={
                        "problemId":data.id//
                    };
                    $.ajax({
                        cache: false,
                        url:"${APP_PATH}/deleteProblem",
                        type:"POST",
                        async:false,
                        data:datas,
                        success:function (result) {
                            if(result.code==200){
                                //执行有错误时候的判断
                                layer.msg('删除题目失败！');
                            }else{
                                layer.msg('删除题目成功！', {icon:1,time:1000},function(){
                                    setTimeout('window.location.reload()',1000);
                                });
                            }
                        }
                    });
                }

            }
        });

    });
</script>

</body>
</html>
