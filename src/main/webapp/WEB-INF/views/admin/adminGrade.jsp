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
    <title>成绩管理</title>
    <link rel="shortcut icon" href="${APP_PATH}/statics/main/images/Absolutely.jpg" type="image/x-icon">
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
                <h4 class="modal-title" id="myModalLabel">修改成绩信息</h4>
            </div>
            <div class="modal-body">
                <!--编辑表单-->
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="paperId_update_static" class="col-sm-2 control-label">试卷ID</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="paperId_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="paperName_update_static" class="col-sm-2 control-label">试卷名称</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="paperName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="userId_update_static" class="col-sm-2 control-label">答卷者ID</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="userId_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="userName_update_static" class="col-sm-2 control-label">答卷者账号</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="userName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="score_update_input" class="col-sm-2 control-label">最终分数</label>
                        <div class="col-sm-7">
                            <input type="number" class="form-control" name="paperName" id="score_update_input" placeholder="请输入你要修改后的试卷名称">
                        </div>
                        <div class="col-sm-3">
                            <label id="paperScore">试卷满分为：50分</label>
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
                                            <input type="hidden" name="search_field" id="search-field" value="paperName">
                                            <button class="btn btn-default dropdown-toggle" id="search-btn" data-toggle="dropdown" type="button" aria-haspopup="true" aria-expanded="false">
                                                试卷名称 <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu">
                                                <li> <a tabindex="-1" href="javascript:void(0)" data-field="paperName">试卷名称</a> </li>
                                                <li> <a tabindex="-1" href="javascript:void(0)" data-field="studentAccount">学生账号</a> </li>
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
<%--                                    <a class="btn btn-danger" href="#!"><i class="mdi mdi-window-close"></i> 删除</a>--%>
                                </div>
                            </div>
                            <div class="card-body">
                                <!--显示表格数据-->
                                <div class="row">
                                    <div class="col-md-12">
                                        <table class="table table-hover table-bordered" id="users_table">
                                            <thead>
                                            <tr>
                                                <th>序号</th>
                                                <th>试卷ID</th>
                                                <th>试卷名称</th>
                                                <th>学生ID</th>
                                                <th>学生账号</th>
                                                <th>提交时间</th>
                                                <th>用时</th>
                                                <th>分数</th>
                                                <th>批改人</th>
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

<!--bootstrap-table-->
<script src="${APP_PATH}/statics/bootstrap-table/bootstrap-table.js"></script>
<link rel="stylesheet" href="${APP_PATH}/statics/bootstrap-table/bootstrap-table.css" />
<script src="${APP_PATH}/statics/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<script src="${APP_PATH}/statics/bootstrap-table/extensions/export/bootstrap-table-export.js"></script>
<script src="${APP_PATH}/statics/bootstrap-table/extensions/export/tableExport.js"></script>
<script src="${APP_PATH}/statics/bootstrap-table/extensions/export/jquery.base64.js"></script>
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
        $("#gradeli").addClass("active");
        $('.search-bar .dropdown-menu a').click(function() {
            var field = $(this).data('field') || '';
            $('#search-field').val(field);
            $('#search-btn').html($(this).text() + ' <span class="caret"></span>');
        });
        to_page(1);//首次加载页面时显示第一页
    });
    $("#submit-btn").click(function () {
        to_page(1);
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
            url:"${APP_PATH}/adminGradeManageSearch",
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
            var uIdTd = $("<td></td>").append(item.id);
            var uPaperIdTd = $("<td></td>").append(item.paperId);
            var uPaperNameTd = $("<td></td>").append(item.paperName);
            var uUserIdTd = $("<td></td>").append(item.userId);
            var uUserName = $("<td></td>").append(item.userName);
            var createTime1=formatDate(item.submitTime);
            var createTime2=formatDateHourAndMinute(item.submitTime);
            var uSubmitTime = $("<td></td>").append(createTime1+" "+createTime2);
            var uDoTime = $("<td></td>").append(item.doTime);
            var uTotalScoreTd = $("<td></td>").append(item.score);
            var uJudgerNameTd = $("<td></td>").append(item.judgerName);

            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("查看");
            var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加一个自定义的属性
            editBtn.attr("edit-id",item.id);
            editBtn.attr("paperScore",item.paperScore);
            //为删除按钮添加一个自定义的属性来表示当前删除的员工id
            delBtn.attr("delete-id",item.id);
            editBtn.attr("paperId",item.paperId);
            editBtn.attr("userId",item.userId);
            editBtn.attr("status",item.status);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>")
                .append(uIdTd)
                .append(uPaperIdTd)
                .append(uPaperNameTd)
                .append(uUserIdTd)
                .append(uUserName)
                .append(uSubmitTime)
                .append(uDoTime)
                .append(uTotalScoreTd)
                .append(uJudgerNameTd)
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
        var sheetid=$(this).attr("delete-id");
        var status=$(this).attr("status");
        var userid=$(this).attr("userId");
        var paperid=$(this).attr("paperId");
        if(status==1){
            window.open("${APP_PATH}/theSheetRecord?paperId="+paperid+"&userId="+userid+"","_blank");
            <%--top.location.href="${APP_PATH}/theSheetRecord?paperId="+paperid+"&userId="+userid+"";--%>
        }else{
            window.open("${APP_PATH}/theScoreSheetRecord?sheetId="+sheetid+"","_blank");
            <%--top.location.href="${APP_PATH}/theScoreSheetRecord?sheetId="+sheetid+"";--%>
        }
    });

    //点击编辑用户
    $(document).on("click",".edit_btn",function () {
        $("#paperScore").text("试卷总分为："+$(this).attr("paperScore"));
        //-------------注意以下的逻辑关系，先后次序不能改变
        getUser($(this).attr("edit-id"));
        $("#userUpdateModal").modal({
            backdrop:"static"
        });
        //2.把用户的id传递给模态框的更新按钮
        $("#user_update_btn").attr("edit-id",$(this).attr("edit-id"));
        $("#user_update_btn").attr("paperScore",$(this).attr("paperScore"));
    });
    /**
     * 获取板块信息
     */
    function getUser(uId) {
        $.ajax({
            url:"${APP_PATH}/adminGetGrade?sheetId="+uId,
            type:"GET",
            success:function (result) {
                var userData=result.extend.sheet;
                $("#paperId_update_static").text(userData.id);
                $("#paperName_update_static").text(userData.paperName);
                $("#userId_update_static").text(userData.userId);
                $("#userName_update_static").text(userData.userName);
                $("#score_update_input").val(userData.score);
            }
        });
    }

    /**
     * 点击更新，更新用户信息
     */
    $("#user_update_btn").click(function () {
        // var uUserid=$("#uUserid_update_input").val();
        var score=$("#score_update_input").val();
        score=parseInt(score);
        var paperScore=parseInt($(this).attr("paperScore"));
        if(score<0||score>paperScore){
            alert("分数不能超出试卷满分且不能为负数哦！");
            return false;
        }
        var data={
            "id":parseInt($(this).attr("edit-id")),
            "score":score
        };
        //发送ajax请求，保存更新的用户信息
        $.ajax({
            url:"${APP_PATH}/adminUpdateGrade",
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
