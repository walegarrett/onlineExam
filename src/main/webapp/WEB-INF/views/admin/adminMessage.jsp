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
    <title>消息管理</title>
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
<div class="modal fade" id="userUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">修改消息记录信息</h4>
            </div>
            <div class="modal-body">
                <!--编辑表单-->
                <form class="form-horizontal" id="update-form">
                    <div class="form-group">
                        <label for="messageId_update_static" class="col-sm-2 control-label">消息ID</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="messageId_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="sendUserName_update_static" class="col-sm-2 control-label">发送人</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="sendUserName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="messageTitle_update_input" class="col-sm-2 control-label">消息标题</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="messageTitle" id="messageTitle_update_input" placeholder="请输入你要修改后的消息名称">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="messageContent_update_input" class="col-sm-2 control-label">消息内容</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="messageContent" id="messageContent_update_input" placeholder="请输入你要修改后的消息名称">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">关闭</button>
                <button type="submit" class="btn btn-primary btn-sm" id="user_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>
<div class="lyear-layout-web">
    <div class="lyear-layout-container">
        <%@include file="admin-nav.jsp"%>

        <!--页面主要内容-->
        <main class="lyear-layout-content">

            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-toolbar clearfix">
                                <form class="pull-right search-bar" method="get" action="#!" role="form">
                                    <div class="input-group">
                                        <div class="input-group-btn">
                                            <input type="hidden" name="search_field" id="search-field" value="title">
                                            <button class="btn btn-default dropdown-toggle" id="search-btn" data-toggle="dropdown" type="button" aria-haspopup="true" aria-expanded="false">
                                                标题 <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu">
                                                <li> <a tabindex="-1" href="javascript:void(0)" data-field="title">标题</a> </li>
                                                <li> <a tabindex="-1" href="javascript:void(0)" data-field="cat_name">栏目</a> </li>
                                            </ul>
                                        </div>
                                        <input type="text" class="form-control" value="" name="keyword" placeholder="请输入名称">
                                    </div>
                                </form>
                                <div class="toolbar-btn-action">
<%--                                    <a class="btn btn-primary m-r-5" href="#!"><i class="mdi mdi-plus"></i> 新增</a>--%>
<%--                                    <a class="btn btn-success m-r-5" href="#!"><i class="mdi mdi-check"></i> 启用</a>--%>
<%--                                    <a class="btn btn-warning m-r-5" href="#!"><i class="mdi mdi-block-helper"></i> 禁用</a>--%>
                                    <a class="btn btn-danger" id="emp_delete_all"><i class="mdi mdi-window-close"></i> 删除</a>
                                </div>
                            </div>
                            <div class="card-body">
                                <!--显示表格数据-->
                                <div class="row">
                                    <div class="col-md-12">
                                        <table class="table table-hover table-bordered" id="users_table" style="table-layout: fixed;
word-break:break-all;">
                                            <thead>
                                            <tr>
                                                <th width="3%">
                                                    <input type="checkbox" id="check_all">
                                                </th>
                                                <th width="5%">序号</th>
                                                <th width="10%">标题</th>
                                                <th width="20%">内容</th>
                                                <th width="7%">发送人</th>
                                                <th width="8%">接收人数</th>
                                                <th width="10%">接收人</th>
                                                <th width="6%">已读数</th>
                                                <th width="8%">创建时间</th>
                                                <th width="5%">操作</th>
                                            </tr>
                                            </thead>
                                            <tbody>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <!--显示分页信息-->
                                <div class="row">
                                    <!--分页文字信息-->
                                    <div class="col-md-6" id="page_info_area">
                                    </div>
                                    <!--分页条-->
                                    <div class="col-md-6" id="page_nav_area">
                                    </div>
                                </div>
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

<!--图表插件-->
<script type="text/javascript" src="${APP_PATH}/statics/lightYear/js/Chart.js"></script>
<script type="text/javascript" src="${APP_PATH}/statics/js/common.js"></script>

<script type="text/javascript">
    var totalRecord;//总记录数
    var currentPage;//当前页
    //1.页面加载请完成后，直接发送一个ajax求，拿到分页信息
    $(function(){
        $("#messageli").addClass("active");
        to_page(1);//首次加载页面时显示第一页
    });
    //跳转到页面
    function to_page(pn){
        $.ajax({
            url:"${APP_PATH}/adminMessageManage",
            data:"pn="+pn,
            type:"get",
            success:function (result) {
                //console.log(result);
                //1.解析并且显示员工数据
                build_users_table(result);
                //2.解析并且显示分页信息
                build_page_info(result);
                //3.分页条的显示
                build_page_nav(result);
            }
        });
    }
    //table结构
    function build_users_table(result) {
        //清空table表
        $("table tbody").empty();
        var users=result.extend.pageInfo.list;
        $.each(users,function (index,item) {
            var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>" );
            var uIdTd = $("<td></td>").append(item.id);
            var uTitleTd = $("<td></td>").append(item.title);
            var uContentTd = $("<td></td>").append(item.content);
            var uSendUserTd = $("<td></td>").append(item.sendUserName);
            var uReceiveCount = $("<td></td>").append(item.receiveUserCount);
            var uReceiverAccounts = $("<td></td>").append(item.receiverAccounts);
            var uReadCount = $("<td></td>").append(item.readCount);
            var createTime1=formatDate(item.createTime);
            var createTime2=formatDateHourAndMinute(item.createTime);
            var uCreateTimeTd = $("<td></td>").append(createTime1+" "+createTime2);

            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加一个自定义的属性
            editBtn.attr("edit-id",item.id);
            //为删除按钮添加一个自定义的属性来表示当前删除的员工id
            delBtn.attr("delete-id",item.id);
            var btnTd = $("<td></td>").append(delBtn).append(" ").append(editBtn);
            $("<tr></tr>")
                .append(checkBoxTd)
                .append(uIdTd)
                .append(uTitleTd)
                .append(uContentTd)
                .append(uSendUserTd)
                .append(uReceiveCount)
                .append(uReceiverAccounts)
                .append(uReadCount)
                .append(uCreateTimeTd)
                .append(btnTd)
                .appendTo("#users_table tbody");
        });
    }
    //解析显示分页信息
    function build_page_info(result){
        $("#page_info_area").empty();
        $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页，" +
            "总共"+result.extend.pageInfo.pages+"页，" +
            "总共"+result.extend.pageInfo.total+"条记录");
        totalRecord=result.extend.pageInfo.total;
        currentPage=result.extend.pageInfo.pageNum;
    }
    //解析显示分页条，点击分页要去下一页
    function build_page_nav(result){
        $("#page_nav_area").empty();

        var ul=$("<ul><ul>").addClass("pagination");
        var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.extend.pageInfo.hasPreviousPage==false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{
            //为元素添加翻页事件
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum-1);
            });
        }
        var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if(result.extend.pageInfo.hasNextPage==false){
            lastPageLi.addClass("disabled");
            nextPageLi.addClass("disabled");
        }else{
            //为元素添加翻页事件
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum+1);
            });
        }
        //添加首页和前一页的提示
        ul.append(firstPageLi).append(prePageLi);
        //遍历给ul中添加页码
        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
            var numLi=$("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum==item){
                numLi.addClass("active");//高亮显示
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        //添加末页和下一页的提示
        ul.append(nextPageLi).append(lastPageLi);

        //把ul添加到nav中
        var navEle=$("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    //点击删除按钮事件
    $(document).on("click",".delete_btn",function () {
        //弹出是否确认删除的对话框
        // alert($(this).parents("tr").find("td:eq(0)").text());
        var messageTitle=$(this).parents("tr").find("td:eq(2)").text();
        var uId=$(this).attr("delete-id");
        var data=
            {
                "messageId":uId
            };
        if(confirm("确认删除"+messageTitle+"吗？")){
            //确认，发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/adminDeleteMessage",
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
    });

    //点击编辑用户
    $(document).on("click",".edit_btn",function () {
        //alert("");
        //-------------注意以下的逻辑关系，先后次序不能改变
        getUser($(this).attr("edit-id"));
        $("#userUpdateModal").modal({
            backdrop:"static"
        });
        //2.把用户的id传递给模态框的更新按钮
        $("#user_update_btn").attr("edit-id",$(this).attr("edit-id"));

    });
    /**
     * 获取板块信息
     */
    function getUser(uId) {
        $.ajax({
            url:"${APP_PATH}/adminGetMessage?messageId="+uId,
            type:"GET",
            success:function (result) {
                var userData=result.extend.message;
                $("#messageId_update_static").text(userData.id);
                $("#sendUserName_update_static").text(userData.sendUserName);
                $("#messageTitle_update_input").val(userData.title);
                $("#messageContent_update_input").val(userData.content);
            }
        });
    }

    /**
     * 点击更新，更新用户信息
     */
    $("#user_update_btn").click(function () {
        // var uUserid=$("#uUserid_update_input").val();
        var title=$("#messageTitle_update_input").val();
        var content=$("#messageContent_update_input").val();
        // alert($(this).attr("edit-id"));
        // alert(uUserid);
        var data={
            "id":parseInt($(this).attr("edit-id")),
            "messageTitle":title,
            "messageContent":content
        };
        //发送ajax请求，保存更新的用户信息
        $.ajax({
            url:"${APP_PATH}/adminUpdateMessage",
            type:"POST",
            data:data,
            success:function (result) {
                if(result.code==100){
                    alert("编辑成功");
                    //1.关闭对话框
                    $("#userUpdateModal").modal("hide");
                    //2.回到本页面
                    to_page(currentPage);
                }else{
                    alert("编辑失败");
                    to_page(currentPage);
                }
            }
        });
    });
    //点击全部删除就批量删除
    $("#emp_delete_all").click(function () {
        var empNames="";
        var del_idstr="";
        $.each($(".check_item:checked"),function () {
            //当前遍历的元素
            //$(this).parents("tr").find("td:eq(2)").text();
            empNames+=$(this).parents("tr").find("td:eq(2)").text()+" ,";
            //组装员工id的字符串
            del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //去除empNames多余的逗号
        empNames=empNames.substring(0,empNames.length-1);
        del_idstr=del_idstr.substring(0,del_idstr.length-1);
        var data=
            {
                "messageId":del_idstr
            };
        if(confirm("确认删除【"+empNames+"】吗？")){
            //确认，发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/adminDeleteMessage",
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
    });
    $(document).ready(function() {
        $('#update-form').bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                messageTitle: {
                    message: '消息标题不符合要求',
                    validators: {
                        notEmpty: {
                            message: '消息标题不能为空'
                        },
                        stringLength: {  //长度限制
                            min: 2,
                            max: 15,
                            message: '消息标题长度必须在2到15位之间'
                        }
                    }
                },
                messageContent: {
                    message: '消息内容不符合要求',
                    validators: {
                        notEmpty: {
                            message: '消息内容不能为空'
                        },
                        stringLength: {  //长度限制
                            min: 1,
                            max: 100,
                            message: '消息内容长度必须在1到100位之间'
                        }
                    }
                }
            }
        });
    });
</script>
</body>
</html>
