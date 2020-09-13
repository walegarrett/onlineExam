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
    <title>试卷管理</title>
    <link rel="icon" href="${APP_PATH}/statics/lightYear/favicon.ico" type="image/ico">
    <meta name="keywords" content="LightYear,光年,后台模板,后台管理系统,光年HTML模板">
    <meta name="description" content="LightYear是一个基于Bootstrap v3.3.7的后台管理系统的HTML模板。">
    <meta name="author" content="yinqi">
    <link href="${APP_PATH}/statics/lightYear/css/bootstrap.min.css" rel="stylesheet">
    <link href="${APP_PATH}/statics/lightYear/css/materialdesignicons.min.css" rel="stylesheet">
    <link href="${APP_PATH}/statics/lightYear/css/style.min.css" rel="stylesheet">
</head>

<body>
<div class="modal fade" id="userUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">修改试卷信息</h4>
            </div>
            <div class="modal-body">
                <!--编辑表单-->
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="paperId_update_static" class="col-sm-2 control-label">试卷id</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="paperId_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="paperName_update_input" class="col-sm-2 control-label">试卷名称</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="paperName" id="paperName_update_input" placeholder="请输入你要修改后的试卷名称">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="startTime_update_input" class="col-sm-2 control-label">开始时间</label>
                        <div class="col-sm-10">
                            <input type="datetime-local" class="form-control" name="startTime" id="startTime_update_input" placeholder="请输入你要修改后的开始考试时间">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="durationTime_update_input" class="col-sm-2 control-label">建议时长</label>
                        <div class="col-sm-10">
                            <input type="number" class="form-control" name="durationTime" id="durationTime_update_input" placeholder="请输入你要修改后的建议时长">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">是否加密</label>
                        <div class="col-sm-10">
                            否：<input type="radio" name="encry" value="1" id="encry_update_no">
                            是：<input type="radio" name="encry" value="2" id="encry_update_yes">
                        </div>
                    </div>
                    <div class="form-group" id="showinviCode">
                        <label for="inviCode_update_input" class="col-sm-2 control-label">验证码</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="inviCode" id="inviCode_update_input" placeholder="请输入你要修改后的验证码">
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
                                <div class="pull-right search-bar">
                                    <div class="input-group">
                                        <div class="input-group-btn">
                                            <input type="hidden" name="search_field" id="search-field" value="name">
                                            <button class="btn btn-default dropdown-toggle" id="search-btn" data-toggle="dropdown" type="button" aria-haspopup="true" aria-expanded="false">
                                                试卷名称 <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu">
<%--                                                <li> <a tabindex="-1" href="javascript:void(0)" data-field="account">账号</a> </li>--%>
                                                <li> <a tabindex="-1" href="javascript:void(0)" data-field="name">试卷名称</a> </li>
                                            </ul>
                                        </div>
                                        <input type="text" class="form-control" value="" id="keyword" name="keyword" placeholder="请输入名称">
                                    </div>
                                    <button class="pull-right btn btn-cyan" id="submit-btn" type="button">
                                        搜索
                                    </button>
                                </div>
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
                                        <table class="table table-hover table-bordered" id="users_table">
                                            <thead>
                                            <tr>
                                                <th>
                                                    <input type="checkbox" id="check_all">
                                                </th>
                                                <th>序号</th>
                                                <th>试卷名称</th>
                                                <th>时间限制</th>
                                                <th>题目数</th>
                                                <th>总分</th>
                                                <th>是否加密</th>
                                                <th>邀请码</th>
                                                <th>创建时间</th>
                                                <th>开始时间</th>
                                                <th>结束时间</th>
                                                <th>创建人</th>
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

<script type="text/javascript" src="${APP_PATH}/statics/lightYear/js/jquery.min.js"></script>
<script type="text/javascript" src="${APP_PATH}/statics/lightYear/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${APP_PATH}/statics/lightYear/js/perfect-scrollbar.min.js"></script>
<script type="text/javascript" src="${APP_PATH}/statics/lightYear/js/main.min.js"></script>

<!--图表插件-->
<script type="text/javascript" src="${APP_PATH}/statics/lightYear/js/Chart.js"></script>
<script type="text/javascript" src="${APP_PATH}/statics/js/common.js"></script>
<script>
    $(function () {
        $("#paperli").addClass("active");
        $('.search-bar .dropdown-menu a').click(function() {
            var field = $(this).data('field') || '';
            $('#search-field').val(field);
            $('#search-btn').html($(this).text() + ' <span class="caret"></span>');
        });

    });
    $("#submit-btn").click(function () {
        to_page(1);
    });
</script>
<script type="text/javascript">
    var totalRecord;//总记录数
    var currentPage;//当前页
    //对于是否需要邀请码
    $("#encry_update_no").click(function () {
        $("#inviCode_update_input").val("");//输入框置空
        $("#showinviCode").hide();
    });
    $("#encry_update_yes").click(function () {
        $("#showinviCode").show();
    });
    //1.页面加载请完成后，直接发送一个ajax求，拿到分页信息
    $(function(){
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
            url:"${APP_PATH}/adminPaperManageSearch",//adminPaperManage
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
            var uPaperNameTd = $("<td></td>").append(item.paperName);
            var uDurationTimeTd = $("<td></td>").append(item.durationTime);
            var uProblemAccountTd = $("<td></td>").append(item.questionCount);
            var uTotalScoreTd = $("<td></td>").append(item.totalScore);
            var isEncryTd = $("<td></td>").append(item.isEncryString);
            var uInviCode = $("<td></td>").append(item.inviCode);
            var createTime1=formatDate(item.createTime);
            var createTime2=formatDateHourAndMinute(item.createTime);
            var uCreateTimeTd = $("<td></td>").append(createTime1+" "+createTime2);
            var startTime1=formatDate(item.startTime);
            var startTime2=formatDateHourAndMinute(item.startTime);
            var uStartTimeTd = $("<td></td>").append(startTime1+" "+startTime2);
            var endTime1=formatDate(item.endTime);
            var endTime2=formatDateHourAndMinute(item.endTime);
            var uEndTimeTd = $("<td></td>").append(endTime1+" "+endTime2);
            var uCreaterUserName=$("<td></td>").append(item.createrUserName);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            var showBtn=$("<button></button>").addClass("btn btn-brown btn-sm show_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("查看");
            showBtn.attr("paperId",item.id);
            //为编辑按钮添加一个自定义的属性
            editBtn.attr("edit-id",item.id);
            //为删除按钮添加一个自定义的属性来表示当前删除的员工id
            delBtn.attr("delete-id",item.id);
            var btnTd = $("<td></td>").append(delBtn).append(" ").append(editBtn).append(showBtn);
            $("<tr></tr>")
                .append(checkBoxTd)
                .append(uIdTd)
                .append(uPaperNameTd)
                .append(uDurationTimeTd)
                .append(uProblemAccountTd)
                .append(uTotalScoreTd)
                .append(isEncryTd)
                .append(uInviCode)
                .append(uCreateTimeTd)
                .append(uStartTimeTd)
                .append(uEndTimeTd)
                .append(uCreaterUserName)
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
        var paperName=$(this).parents("tr").find("td:eq(2)").text();
        var uId=$(this).attr("delete-id");
        var data=
            {
                "paperId":uId
            };
        if(confirm("确认删除"+paperName+"吗？")){
            //确认，发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/adminDeletePaper",
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
        var data=
            {
                "paperId":del_idstr
            };
        if(confirm("确认删除【"+empNames+"】吗？")){
            //确认，发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/adminDeletePaper",
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
    //点击查看按钮事件
    $(document).on("click",".show_btn",function () {
        //弹出是否确认删除的对话框
        var paperId=$(this).attr("paperId");
        window.open("${APP_PATH}/showPaperDetail?paperId="+paperId+"","_blank");
    });

    //点击编辑用户
    $(document).on("click",".edit_btn",function () {
        //alert("");
        //-------------注意以下的逻辑关系，先后次序不能改变
        getUser($(this).attr("edit-id"));
        // alert($(this).attr("edit-id"));
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
            url:"${APP_PATH}/adminGetPaper?paperId="+uId,
            type:"GET",
            success:function (result) {
                var userData=result.extend.paper;
                $("#paperId_update_static").text(userData.id);
                $("#paperName_update_input").val(userData.paperName);

                var startTime=userData.startTime;
                var startTime1 =formatDate(startTime);
                var startTime2 =formatDateHourAndMinute(startTime);
                startTime=startTime1+"T"+startTime2;
                $("#startTime_update_input").val(startTime);
                $("#durationTime_update_input").val(userData.durationTime);
                var isEncry=userData.isEncry;
                if(isEncry==1){//未加密
                    $("#encry_update_no").prop("checked",true);
                    $("#inviCode_update_input").val("");//输入框置空
                    $("#showinviCode").hide();
                }else{
                    $("#encry_update_yes").prop("checked",true);
                    $("#inviCode_update_input").val(userData.inviCode);//输入框置空
                    $("#showinviCode").show();
                }
            }
        });
    }

    /**
     * 点击更新，更新用户信息
     */
    $("#user_update_btn").click(function () {
        // var uUserid=$("#uUserid_update_input").val();
        var paperName=$("#paperName_update_input").val();
        var durationTime=$("#durationTime_update_input").val();
        durationTime=parseInt(durationTime);
        var startTime=$("#startTime_update_input").val();
        var inviCode=$("#inviCode_update_input").val();
        var isEncry=$("input[name='encry']:checked").val();
        isEncry=parseInt(isEncry);
        // alert($(this).attr("edit-id"));
        // alert(uUserid);
        var data={
            "id":parseInt($(this).attr("edit-id")),
            "paperName":paperName,
            "durationTime":durationTime,
            "startTime":startTime,
            "isEncry":isEncry,
            "inviCode":inviCode
        };
        //发送ajax请求，保存更新的用户信息
        $.ajax({
            url:"${APP_PATH}/adminUpdatePaper",
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
    // layui.use('element', function(){
    //     var element = layui.element;
    // });
</script>
</body>
</html>
