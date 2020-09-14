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
    <title>用户管理</title>
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
                <h4 class="modal-title" id="myModalLabel">修改用户</h4>
            </div>
            <div class="modal-body">
                <!--编辑表单-->
                <form class="form-horizontal" id="update-form">
                    <div class="form-group">
                        <label for="uUserid_update_static" class="col-sm-2 control-label">用户账号</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="uUserid_update_static"></p>
                            <%--                            <input type="text" class="form-control" name="uUserid" id="uUserid_update_input" placeholder="请输入你要修改后的用户账号">--%>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="uPassword_update_input" class="col-sm-2 control-label">用户密码</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="uPassword" id="uPassword_update_input" placeholder="请输入你要修改后的用户密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="uNickname_update_input" class="col-sm-2 control-label">用户年龄</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="uNickname" id="uNickname_update_input" placeholder="请输入你要修改后的用户年龄">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">用户性别</label>
                        <div class="col-sm-10">
                            男：<input type="radio" name="uSex" value="1" id="uSex_update_input1">
                            女：<input type="radio" name="uSex" value="2" id="uSex_update_input2">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="uName_update_input" class="col-sm-2 control-label">真实姓名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="uName" id="uName_update_input" placeholder="请输入你要修改后的真实姓名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="uEmail_update_input" class="col-sm-2 control-label">E-mail</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="uEmail" id="uEmail_update_input" placeholder="请输入你要修改后的E-mail">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">角色</label>
                        <div class="col-sm-10">
                            学生：<input type="radio" name="uRole" value="1" id="uRole_update_input1">
                            教师：<input type="radio" name="uRole" value="2" id="uRole_update_input2">
                            管理员：<input type="radio" name="uRole" value="3" id="uRole_update_input3">
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
<div class="modal fade" id="userAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabe2">新增用户</h4>
            </div>
            <div class="modal-body">
                <!--编辑表单-->
                <form class="form-horizontal form" id="add-form" method="post">
                    <div class="form-group">
                        <label for="uUserName_add_static" class="col-sm-2 control-label">用户账号</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="uUserName" id="uUserName_add_static" placeholder="请输入你要添加的用户的新账号">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="uPassword_update_input" class="col-sm-2 control-label">用户密码</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="uPassword" id="uPassword_add_input" placeholder="请输入你要添加的用户的登录密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">用户性别</label>
                        <div class="col-sm-10">
                            男：<input type="radio" name="uSex" value="1" id="uSex_add_input1">
                            女：<input type="radio" name="uSex" value="2" id="uSex_add_input2">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="uName_update_input" class="col-sm-2 control-label">真实姓名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="uName" id="uName_add_input" placeholder="请输入你要添加的用户的真实姓名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="uEmail_update_input" class="col-sm-2 control-label">E-mail</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" name="uEmail" id="uEmail_add_input" placeholder="请输入你要添加的用户的E-mail">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="uPhone_add_input" class="col-sm-2 control-label">联系电话</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" name="uPhone" id="uPhone_add_input" placeholder="请输入你要添加的用户的phone">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="uAge_add_input" class="col-sm-2 control-label">年龄</label>
                        <div class="col-sm-10">
                            <input type="number" class="form-control" name="uAge" id="uAge_add_input" placeholder="请输入你要添加的用户年龄">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">角色</label>
                        <div class="col-sm-10">
                            学生：<input type="radio" name="uRole" value="1" id="uRole_add_input1">
                            教师：<input type="radio" name="uRole" value="2" id="uRole_add_input2">
                            管理员：<input type="radio" name="uRole" value="3" id="uRole_add_input3">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">关闭</button>
                <button type="submit" class="btn btn-primary btn-sm" id="user_add_btn">新增</button>
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
                                <div class="pull-right search-bar">
                                    <div class="input-group">
                                        <div class="input-group-btn">
                                            <input type="hidden" name="search_field" id="search-field" value="account">
                                            <button class="btn btn-default dropdown-toggle" id="search-btn" data-toggle="dropdown" type="button" aria-haspopup="true" aria-expanded="false">
                                                账号 <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu">
                                                <li> <a tabindex="-1" href="javascript:void(0)" data-field="account">账号</a> </li>
                                                <li> <a tabindex="-1" href="javascript:void(0)" data-field="name">姓名</a> </li>
                                            </ul>
                                        </div>
                                        <input type="text" class="form-control" value="" id="keyword" name="keyword" placeholder="请输入名称">
                                    </div>
                                    <button class="pull-right btn btn-cyan" id="submit-btn" type="button">
                                        搜索
                                    </button>
                                </div>
                                <div class="toolbar-btn-action">
                                    <a class="btn btn-primary m-r-5 add_btn" href="#!"><i class="mdi mdi-plus"></i> 新增</a>
<%--                                    <a class="btn btn-success m-r-5" href="#!"><i class="mdi mdi-check"></i> 启用</a>--%>
<%--                                    <a class="btn btn-warning m-r-5" href="#!"><i class="mdi mdi-block-helper"></i> 禁用</a>--%>
                                    <a class="btn btn-danger" id="emp_delete_all"><i class="mdi mdi-window-close"></i> 删除</a>                                </div>
                            </div>
                            <div class="card-body">
                                <!--显示表格数据-->
                                <div class="row">
                                    <div class="col-md-12">
                                        <table class="table table-hover table-bordered" id="users_table">
                                            <thead>
                                            <tr>
                                                <th>
                                                    <input type="checkbox" id="check_all">
                                                </th>
                                                <th>序号</th>
                                                <th>账号</th>
                                                <th>密码</th>
                                                <th>年龄</th>
                                                <th>性别</th>
                                                <th>姓名</th>
                                                <th>E-mail</th>
                                                <th>角色</th>
                                                <th>操作</th>
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

<script type="text/javascript" src="${APP_PATH}/statics/bootstrapValidator/vendor/jquery/jquery-1.10.2.min.js"></script>
<%--<script type="text/javascript" src="${APP_PATH}/statics/lightYear/js/jquery.min.js"></script>--%>
<script type="text/javascript" src="${APP_PATH}/statics/lightYear/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${APP_PATH}/statics/lightYear/js/perfect-scrollbar.min.js"></script>
<script type="text/javascript" src="${APP_PATH}/statics/lightYear/js/main.min.js"></script>
<script type="text/javascript" src="${APP_PATH}/statics/bootstrapValidator/dist/js/bootstrapValidator.js"></script>
<!--图表插件-->
<script type="text/javascript" src="${APP_PATH}/statics/lightYear/js/Chart.js"></script>
<script type="text/javascript" src="${APP_PATH}/statics/js/common.js"></script>
<script>
    $("#submit-btn").click(function () {
        to_page(1);
    });
</script>
<script type="text/javascript">
    var totalRecord;//总记录数
    var currentPage;//当前页
    //1.页面加载请完成后，直接发送一个ajax求，拿到分页信息
    $(function(){
        $("#userli").addClass("active");
        $('.search-bar .dropdown-menu a').click(function() {
            var field = $(this).data('field') || '';
            $('#search-field').val(field);
            $('#search-btn').html($(this).text() + ' <span class="caret"></span>');
        });
        to_page(1);//首次加载页面时显示第一页
    });
    //跳转到页面
    function to_page(pn){
        var searchField=$('#search-field').val();
        var keyword=$("#keyword").val();
        // alert(searchField+" "+keyword);
        var data={
            "pn":pn,
            "field":searchField,
            "keyword":keyword
        };
        $.ajax({
            url:"${APP_PATH}/adminUserManageSearch",
            data:data,
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
            var uUseridTd = $("<td></td>").append(item.userName);
            var uPasswordTd = $("<td></td>").append(item.password);
            var uNicknameTd = $("<td></td>").append(item.age);
            var uSexTd = $("<td></td>").append(item.sex);
            var uNameTd = $("<td></td>").append(item.realName);
            var uEmailTd = $("<td></td>").append(item.email);
            var role=item.role;
            if(role==1){
                role="学生";
            }else if(role==2){
                role="教师";
            }else{
                role="管理员";
            }
            var uWorkplaceTd = $("<td></td>").append(role);
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
                .append(uUseridTd)
                .append(uPasswordTd)
                .append(uNicknameTd)
                .append(uSexTd)
                .append(uNameTd)
                .append(uEmailTd)
                .append(uWorkplaceTd)
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
        var uUserid=$(this).parents("tr").find("td:eq(2)").text();
        var uId=$(this).attr("delete-id");
        var data={
            "userId":uId
        };
        if(confirm("确认删除"+uUserid+"吗？")){
            //确认，发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/adminDeleteUser",
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
        var data={
            "userId":del_idstr
        };
        if(confirm("确认删除【"+empNames+"】这些用户吗？")){
            //确认，发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/adminDeleteUser",
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
    //点击添加用户
    $(document).on("click",".add_btn",function () {
        $("#userAddModal").modal({
            backdrop:"static"
        });
    });
    /**
     * 获取板块信息
     */
    function getUser(uId) {
        $.ajax({
            url:"${APP_PATH}/adminGetUser?userId="+uId,
            type:"GET",
            success:function (result) {
                var userData=result.extend.user;
                $("#uUserid_update_static").text(userData.userName);
                $("#uPassword_update_input").val(userData.password);
                $("#uNickname_update_input").val(userData.age);
                var sex=userData.sex;
                if(sex==1)
                    $("#uSex_update_input1").prop("checked",true);
                else $("#uSex_update_input2").prop("checked",true);
                $("#uName_update_input").val(userData.realName);
                $("#uEmail_update_input").val(userData.email);
                var role=userData.role;
                if(role==1)
                    $("#uRole_update_input1").prop("checked",true);
                else if(role==2){
                    $("#uRole_update_input2").prop("checked",true);
                }else{
                    $("#uRole_update_input3").prop("checked",true);
                }
            }
        });
    }

    /**
     * 点击更新，更新用户信息
     */
    $("#user_update_btn").click(function () {
        // var uUserid=$("#uUserid_update_input").val();
        var uPassword=$("#uPassword_update_input").val();
        var age=$("#uNickname_update_input").val();
        age=parseInt(age);
        var uName=$("#uName_update_input").val();
        var uEmail=$("#uEmail_update_input").val();
        var role=$("input[name='uRole']:checked").val();
        var sex=$("input[name='uSex']:checked").val();
        role=parseInt(role);
        sex=parseInt(sex);
        // alert($(this).attr("edit-id"));
        // alert(uUserid);
        var data={
            "id":parseInt($(this).attr("edit-id")),
            "password":uPassword,
            "age":age,
            "realName":uName,
            "email":uEmail,
            "role":role,
            "sex":sex
        };
        //发送ajax请求，保存更新的用户信息
        $.ajax({
            url:"${APP_PATH}/adminUpdateUser",
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
    /**
     * 点击新增，添加用户信息
     */
    $("#user_add_btn").click(function () {
        // var uUserid=$("#uUserid_update_input").val();
        var userName=$("#uUserName_add_static").val();
        var uPassword=$("#uPassword_add_input").val();
        var age=$("#uAge_add_input").val();
        age=parseInt(age);
        var uName=$("#uName_add_input").val();
        var uEmail=$("#uEmail_add_input").val();
        var role=$("input[name='uRole']:checked").val();
        var sex=$("input[name='uSex']:checked").val();
        var phone=$("#uPhone_add_input").val();
        role=parseInt(role);
        sex=parseInt(sex);
        // return false;
        // alert(uUserid);
        var data={
            "userName":userName,
            "password":uPassword,
            "age":age,
            "realName":uName,
            "email":uEmail,
            "role":role,
            "sex":sex,
            "phone":phone
        };
        //发送ajax请求，保存更新的用户信息
        $.ajax({
            url:"${APP_PATH}/adminAddUser",
            type:"POST",
            data:data,
            success:function (result) {
                if(result.code==100){
                    alert("添加用户成功");
                    //1.关闭对话框
                    $("#userAddModal").modal("hide");
                    //2.回到本页面
                    to_page(1);
                }else{
                    alert("添加用户失败");
                    to_page(currentPage);
                }
            }
        });
    });
    // layui.use('element', function(){
    //     var element = layui.element;
    // });
    $(document).ready(function() {
        $('#add-form').bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                uUserName: {
                    message: '登录帐号不可用',
                    validators: {
                        notEmpty: {
                            message: '登录账号不能为空'
                        },
                        stringLength: {  //长度限制
                            min: 4,
                            max: 18,
                            message: '账号长度必须在4到18位之间'
                        },
                        regexp: { //正则表达式
                            regexp: /^[a-zA-Z0-9_]+$/,
                            message: '账号只能包含大写、小写、数字和下划线'
                        },
                        remote: {
                            type:"POST",
                            message: '账号已存在',
                            url: '${APP_PATH}/adminCheckAddUserName',
                            data: function(validator) {
                                // alert($("input[name='uUserName']").val());
                                return {
                                    userName: $("input[name='uUserName']").val()
                                };
                            },
                            delay: 2000//每输入一个字符，就发ajax请求，服务器压力还是太大，设置2秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）
                        }
                    }
                },
                uName: {
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
                uEmail: {
                    validators: {
                        notEmpty: {
                            message: 'email不能为空'
                        },
                        emailAddress:{
                            message:"邮箱格式不正确，邮箱不可用！"
                        }
                    }
                },
                uPhone:{
                    validators:{
                        notEmpty:{
                            message:"电话号码不能为空"
                        },
                        regexp: { //正则表达式
                            regexp: /^1[123456789]\d{9}$/,
                            message: '电话号码必须为11位纯数字'
                        }
                    }
                },
                uAge:{
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

        $('#update-form').bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                uName: {
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
                uEmail: {
                    validators: {
                        notEmpty: {
                            message: 'email不能为空'
                        },
                        emailAddress:{
                            message:"邮箱格式不正确，邮箱不可用！"
                        }
                    }
                },
                uNickname:{
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
    });
</script>
</body>
</html>
