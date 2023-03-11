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
    <title>题目管理</title>
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
                <h4 class="modal-title" id="myModalLabel">修改题目信息</h4>
            </div>
            <div class="modal-body">
                <!--编辑表单-->
                <form class="form-horizontal" id="update-form">
                    <div class="form-group">
                        <label for="problemId_update_static" class="col-sm-2 control-label">题目id</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="problemId_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="type_update_static" class="col-sm-2 control-label">题目类型</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="type_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="titleContent_update_input" class="col-sm-2 control-label">题干</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="titleContent" id="titleContent_update_input" placeholder="请输入你要修改后的题干">
                        </div>
                    </div>
                    <div class="form-group" id="sigAndMulOpts">
                        <label class="col-sm-2 control-label">选项</label>
                        <div class="col-sm-10">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">A: </label>
                                <div class="col-sm-10">
                                    <input type="text" name="optionsA" value="" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">B: </label>
                                <div class="col-sm-10">
                                    <input type="text" name="optionsB" value="" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">C: </label>
                                <div class="col-sm-10">
                                    <input type="text" name="optionsC" value="" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">D: </label>
                                <div class="col-sm-10">
                                    <input type="text" name="optionsD" value="" class="form-control">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group" id="judgeOpts">
                        <label class="col-sm-2 control-label">判断选项</label>
                        <div class="col-sm-10">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">A: </label>
                                <div class="col-sm-10">
                                    <input type="text" name="judgeA" value="" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">B: </label>
                                <div class="col-sm-10">
                                    <input type="text" name="judgeB" value="" class="form-control">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group" id="singAns">
                        <label class="col-sm-2 control-label">单选答案</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                            <input type="radio" name="sinAns" value="A" title="A" checked=""><label>A </label>
                            </label>
                            <label class="radio-inline">
                            <input type="radio" name="sinAns" value="B" title="B"><label>B </label>
                            </label>
                            <label class="radio-inline">
                            <input type="radio" name="sinAns" value="C" title="C"><label>C </label>
                            </label>
                            <label class="radio-inline">
                            <input type="radio" name="sinAns" value="D" title="D"><label>D </label>
                            </label>
                        </div>
                    </div>
                    <div class="form-group" id="mulAns">
                        <label class="col-sm-2 control-label">多选答案</label>
                        <div class="col-sm-10">
                            <label class="checkbox-inline">
                            <input type="checkbox" name="mulAns" value="A" title="A"><label>A </label>
                            </label>
                            <label class="checkbox-inline">
                            <input type="checkbox" name="mulAns" value="B" title="B"><label>B </label>
                            </label>
                            <label class="checkbox-inline">
                            <input type="checkbox" name="mulAns" value="C" title="C"><label>C </label>
                            </label>
                            <label class="checkbox-inline">
                            <input type="checkbox" name="mulAns" value="D" title="D"><label>D </label>
                            </label>
                        </div>
                    </div>
                    <div class="form-group" id="judAns">
                        <label class="col-sm-2 control-label">判断答案</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="judgeAns" value="A" title="A" checked=""><label>A </label>
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="judgeAns" value="B" title="B"><label>B </label>
                            </label>

                        </div>
                    </div>
                    <div class="form-group" id="ordAns">
                        <label for="ordiAns_update_input" class="col-sm-2 control-label">简答和填空答案</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="ordiAns" id="ordiAns_update_input" placeholder="请输入你要修改后的答案">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="score_update_input" class="col-sm-2 control-label">分值</label>
                        <div class="col-sm-10">
                            <input type="number" class="form-control" name="score" id="score_update_input" placeholder="请输入你要修改后的分值">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="analysis_update_input" class="col-sm-2 control-label">答案解析</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="analysis" id="analysis_update_input" placeholder="请输入你要修改后的答案解析">
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
                                            <input type="hidden" name="search_field" id="search-field" value="type">
                                            <button class="btn btn-default dropdown-toggle" id="search-btn" data-toggle="dropdown" type="button" aria-haspopup="true" aria-expanded="false">
                                                题型 <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu">
                                                <%--                                                <li> <a tabindex="-1" href="javascript:void(0)" data-field="account">账号</a> </li>--%>
                                                <li> <a tabindex="-1" href="javascript:void(0)" data-field="type">题型</a> </li>
                                            </ul>
                                        </div>
                                        <input type="text" class="form-control" value="" id="keyword" name="keyword" placeholder="请输入题型">
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
                                                <th width="4%">序号</th>
                                                <th width="5%">题型</th>
                                                <th>题干</th>
                                                <th>正确答案</th>
                                                <th>答案解析</th>
                                                <th width="4%">分值</th>
                                                <th width="6%">创建时间</th>
                                                <th>创建者</th>
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
<script type="text/javascript" src="${APP_PATH}/statics/bootstrapValidator/dist/js/bootstrapValidator.js"></script>
<!--图表插件-->
<script type="text/javascript" src="${APP_PATH}/statics/lightYear/js/Chart.js"></script>
<script type="text/javascript" src="${APP_PATH}/statics/js/common.js"></script>

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
        $("#problemli").addClass("active");
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
            url:"${APP_PATH}/adminProblemManageSearch",
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
            var uTypeTd = $("<td></td>").append(item.typeName);
            var uTitleContentTd = $("<td></td>").append(item.titleContent);
            var uAnswerTd=$("<td></td>").append(item.answer);
            var uAnalysis = $("<td></td>").append(item.analysis);
            var uScoreTd = $("<td></td>").append(item.score);
            var createTime1=formatDate(item.createTime);
            var createTime2=formatDateHourAndMinute(item.createTime);
            var uCreateTimeTd = $("<td></td>").append(createTime1+" "+createTime2);
            var uCreaterUserName=$("<td></td>").append(item.createrUserName);

            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加一个自定义的属性
            editBtn.attr("edit-id",item.id);
            editBtn.attr("problemType",item.type);
            //为删除按钮添加一个自定义的属性来表示当前删除的员工id
            delBtn.attr("delete-id",item.id);
            var btnTd = $("<td></td>").append(delBtn).append(" ").append(editBtn);
            $("<tr></tr>")
                .append(checkBoxTd)
                .append(uIdTd)
                .append(uTypeTd)
                .append(uTitleContentTd)
                .append(uAnswerTd)
                .append(uAnalysis)
                .append(uScoreTd)
                .append(uCreateTimeTd)
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
        var paperName=$(this).parents("tr").find("td:eq(1)").text();
        var uId=$(this).attr("delete-id");
        var data=
            {
                "problemId":uId
            };
        if(confirm("确认删除"+paperName+"吗？")){
            //确认，发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/adminDeleteProblem",
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
            empNames+=$(this).parents("tr").find("td:eq(1)").text()+" ,";
            //组装员工id的字符串
            del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //去除empNames多余的逗号
        empNames=empNames.substring(0,empNames.length-1);
        del_idstr=del_idstr.substring(0,del_idstr.length-1);
        var data=
            {
                "problemId":del_idstr
            };
        if(confirm("确认删除【"+empNames+"】这些题目吗？")){
            //确认，发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/adminDeleteProblem",
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
        //设置页面元素显示

        $("#userUpdateModal").modal({
            backdrop:"static"
        });
        //2.把用户的id传递给模态框的更新按钮
        $("#user_update_btn").attr("edit-id",$(this).attr("edit-id"));
        $("#user_update_btn").attr("problemType",$(this).attr("problemType"));
    });
    /**
     * 获取板块信息
     */
    function getUser(uId) {
        $.ajax({
            url:"${APP_PATH}/adminGetProblem?problemId="+uId,
            type:"GET",
            success:function (result) {
                var userData=result.extend.problem;
                $("#problemId_update_static").text(userData.id);
                var content=userData.content;
                //转换String为Json格式
                content = JSON.parse(content);
                var titleContent=content.titleContent;//题干
                var type=userData.type;
                $("#titleContent_update_input").val(content.titleContent);
                $("#analysis_update_input").val(userData.analysis);
                $("#score_update_input").val(userData.score);
                <%--$("#answer input[name='type']").val(${answer});--%>
                if(type==1){//单选题
                    $("#type_update_static").text("单选题");
                    $("#singAns").show();
                    $("#singAns input[value='"+userData.answer+"']").attr("selected",true);
                    $("#sigAndMulOpts").show();
                    $("#sigAndMulOpts input[name='optionsA']").val(content.questionItemObjects[0].content);
                    $("#sigAndMulOpts input[name='optionsB']").val(content.questionItemObjects[1].content);
                    $("#sigAndMulOpts input[name='optionsC']").val(content.questionItemObjects[2].content);
                    $("#sigAndMulOpts input[name='optionsD']").val(content.questionItemObjects[3].content);
                    $("#mulAns").hide();
                    $("#judAns").hide();
                    $("#judgeOpts").hide();
                    $("#ordAns").hide();
                }else if(type==2){//多选
                    $("#type_update_static").text("多选题");
                    $("#singAns").hide();
                    $("#sigAndMulOpts").show();
                    $("#sigAndMulOpts input[name='optionsA']").val(content.questionItemObjects[0].content);
                    $("#sigAndMulOpts input[name='optionsB']").val(content.questionItemObjects[1].content);
                    $("#sigAndMulOpts input[name='optionsC']").val(content.questionItemObjects[2].content);
                    $("#sigAndMulOpts input[name='optionsD']").val(content.questionItemObjects[3].content);
                    $("#mulAns").show();
                    var answer=userData.answer;
                    var items=answer.split(",");
                    $.each(items,function(index,value){
                        $("#mulAns input[value='"+value+"']").attr("checked",true);
                    });
                    $("#judAns").hide();
                    $("#judgeOpts").hide();
                    $("#ordAns").hide();
                }else if(type==3){//判断
                    $("#type_update_static").text("判断题");
                    $("#singAns").hide();
                    $("#sigAndMulOpts").hide();
                    $("#mulAns").hide();
                    $("#judAns").show();
                    $("#judAns input[value="+userData.answer+"]").prop("checked",true);
                    $("#judgeOpts").show();
                    $("#judgeOpts input[name='judgeA']").val(content.questionItemObjects[0].content);
                    $("#judgeOpts input[name='judgeB']").val(content.questionItemObjects[1].content);
                    $("#ordAns").hide();
                }else{//填空和简答
                    if(type==4) $("#type_update_static").text("填空题");
                    else $("#type_update_static").text("简答题");
                    $("#singAns").hide();
                    $("#sigAndMulOpts").hide();
                    $("#mulAns").hide();
                    $("#judAns").hide();
                    $("#judgeOpts").hide();
                    $("#ordAns").show();
                    $("#ordAns input[name='ordiAns']").val(userData.answer);
                }
            }
        });
    }

    /**
     * 点击更新，更新用户信息
     */
    $("#user_update_btn").click(function () {
        // var uUserid=$("#uUserid_update_input").val();
        var ans="";
        if($("#ordAns").is(":hidden")){
            if($("#mulAns").is(":hidden")){
                if($("#judAns").is(":hidden"))
                    ans=$('input[name="sinAns"]:checked').val();
                else
                    ans=$('input[name="judgeAns"]:checked').val();
            }else{
                var chk_value =[];//定义一个数组
                var ind=0;
                $('input[name="mulAns"]:checked').each(function(){//遍历每一个名字为interest的复选框，其中选中的执行函数
                    if(ind!=0)
                        ans+=",";
                    ind++;
                    ans+=$(this).val();
                });
            }
        }else{
            ans=$("#ordAns input[name='ordiAns']").val();
        }
        //alert(ans);
        var optionA="",optionB="",optionC="",optionD="";
        if($("#sigAndMulOpts").is(":visible")){
            optionA=$("#sigAndMulOpts input[name='optionsA']").val();
            optionB=$("#sigAndMulOpts input[name='optionsB']").val();
            optionC=$("#sigAndMulOpts input[name='optionsC']").val();
            optionD=$("#sigAndMulOpts input[name='optionsD']").val();
        }else if($("#judgeOpts").is(":visible")){
            optionA=$("#judgeOpts input[name='judgeA']").val();
            optionB=$("#judgeOpts input[name='judgeB']").val();
        }
        var titleContent=$("#titleContent_update_input").val();
        var analysis=$("#analysis_update_input").val();
        var score=parseInt($("#score_update_input").val());
        var data={
            "problemId":parseInt($(this).attr("edit-id")),
            "titleContent":titleContent,
            "answer":ans,
            "score":score,
            "type":parseInt($(this).attr("problemType")),
            "analysis":analysis,
            "optionA":optionA,
            "optionB":optionB,
            "optionC":optionC,
            "optionD":optionD
        };
        // alert(titleContent+" "+ans+" "+optionA+" "+optionB+" "+optionC+" "+optionD+" "+score+" "+analysis);
        // return false;
        //发送ajax请求，保存更新的用户信息
        $.ajax({
            url:"${APP_PATH}/adminUpdateProblem",
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
    $(document).ready(function() {
        $('#update-form').bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                titleContent: {
                    message: '题干不符合要求',
                    validators: {
                        notEmpty: {
                            message: '题干不能为空'
                        },
                        stringLength: {  //长度限制
                            min: 3,
                            max: 50,
                            message: '题干长度必须在3到50位之间'
                        }
                    }
                },
                analysis: {
                    message: '答案解析不符合要求',
                    validators: {
                        notEmpty: {
                            message: '答案解析不能为空'
                        },
                        stringLength: {  //长度限制
                            min: 1,
                            max: 50,
                            message: '答案解析必须在1到50位之间'
                        }
                    }
                },
                score: {
                    validators: {
                        notEmpty: {
                            message: '分数不能为空'
                        },
                        regexp: { //正则表达式
                            regexp: /^[0-9]+.?[0-9]*$/,
                            message: '分数必须为数字'
                        }
                    }
                }
            }
        });
    });
</script>
</body>
</html>
