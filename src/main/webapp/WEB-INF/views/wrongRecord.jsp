<%--
  Created by IntelliJ IDEA.
  User: lemon
  Date: 2019/12/7
  Time: 17:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%
        //这个的路径是以斜线开始的，不以斜线结束
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <meta http-equiv="Content-Type" content="text/html; Charset=gb2312">
    <meta http-equiv="Content-Language" content="zh-CN">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>试卷中心</title>
    <link rel="shortcut icon" href="${APP_PATH}/statics/main/images/Absolutely.jpg" type="image/x-icon">
    <!--Layui-->
    <link href="${APP_PATH}/statics/main/plug/layui/css/layui.css" rel="stylesheet" />
    <!--font-awesome-->
    <link href="${APP_PATH}/statics/main/plug/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    <!--全局样式表-->
    <link href="${APP_PATH}/statics/main/css/global.css" rel="stylesheet" />
    <!-- 本页样式表 -->
    <link href="${APP_PATH}/statics/main/css/resource.css" rel="stylesheet" />
    <script src="${APP_PATH}/statics/js/jquery-1.10.2.js"></script>
    <link href="${APP_PATH}/statics/css/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet">
    <script src="${APP_PATH}/statics/css/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <style>
        .dropdown-menu li a{
            color:#1aa094 !important;
        }
        .showDetail{
            background:#ffffff;
            width:370px;
            height:350px;
            box-shadow:0 0 10px #c4e3f3;
        }
        .showDetail ul{
            margin-left: 20px;
            padding-top:20px;
        }
        .showDetail ul li{
            line-height: 20px;
            margin-bottom:20px;
            font-size:20px;
        }
        #message{
            width:100px;
            height:20px;
            margin-top:10px;
        }
        /*角标 */
        .ii{
            /*display: none;*/
            background: #f00!important;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            position: absolute;
            top: 20px;
            right: 60px;
            text-align: center;
            color: #FFF;
            z-index: 99999;
        }
    </style>
</head>
<body>

<%@include file="nav-top.jsp"%>
<!-- 主体（一般只改变这里的内容） -->
<div class="blog-body">
    <div class="blog-container">
        <blockquote class="layui-elem-quote sitemap layui-breadcrumb shadow">
            <a href="${APP_PATH}/index2.jsp" title="网站首页">网站首页</a>
            <a><cite>错题记录</cite></a>
        </blockquote>
        <div class="blog-main">
            <div class="blog-main">
                <div class="resource-main">
                    <%-- 从这里开始构建--%>
                        <div class="row">
                            <div class="col-md-8">
                                <!--展示帖子或者精华帖-->
                                <div class="allMains">
                                    <div class="row">
                                        <div class="col-md-12"><!--存放所有的帖子-->
                                            <table class="table table-hover" id="mains_table">
                                                <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>题干</th>
                                                    <th>所属试卷</th>
                                                    <th>题型</th>
                                                    <th>做题时间</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="showDetail">

                                </div>
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
                    <!--结束构建试题列表-->
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="nav-bottom.jsp"%>
<!-- layui.js -->
<script src="${APP_PATH}/statics/main/plug/layui/layui.js"></script>
<!-- 全局脚本 -->
<script src="${APP_PATH}/statics/js/common.js"></script>
<script src="${APP_PATH}/statics/main/js/global.js"></script>
<%--<script type="text/javascript" src="${APP_PATH}/statics/bootstrapValidator/vendor/jquery/jquery-1.10.2.min.js"></script>--%>
<script src="${APP_PATH}/statics/layuimini/lib/layui-v2.5.5/lay/modules/layer.js" charset="utf-8"></script>

<script>
    var totalRecord;//总记录数
    var currentPage;//当前页
    //1.页面加载完成后，直接发送一个ajax请求，拿到分页信息
    $(function(){
        $("#wrongrecordli").addClass("layui-this");
        $("#wrongrecordli1").addClass("layui-this");
        to_page(1);//首次加载页面时显示第一页
        showNoReadCount("${APP_PATH}","${userid}");
    });
    //跳转到页面
    function to_page(pn){
        var data={
            "pn":pn,
            "userId":${userid}
        };
        $.ajax({
            url:"${APP_PATH}/findAllWrongAnswerOfUser",
            data:data,
            type:"get",
            success:function (result) {
                //console.log(result);
                //1.解析并且显示员工数据
                build_mains_table(result);
                //2.解析并且显示分页信息
                build_page_info(result);
                //3.分页条的显示
                build_page_nav(result);
            }
        });
    }


    //table结构
    function build_mains_table(result) {
        //清空table表
        $("table tbody").empty();
        var emps=result.extend.pageInfo.list;
        //这里是除了置顶帖之外的帖子
        $.each(emps,function (index,item) {
            var obj=item.problem.content;
            //转换String为Json格式
            var proItem = JSON.parse(obj);
            var titleContent=proItem.titleContent;
            var mainIdTd=$("<td></td>").append(item.id).addClass("normalmain");//增加一个class，标识为非置顶帖;
            var mainTitleTd=$("<td></td>").append(titleContent);

            var paperName=item.paper.paperName;
            var paperNameTd=$("<td></td>").append(paperName);

            var date=formatDate(item.sheet.submitTime);
            var hourandminute=formatDateHourAndMinute(item.sheet.submitTime);
            var submitTime=$("<td></td>").append(date+" "+hourandminute);

            var type=item.problem.type;
            if(type==1)
                var typeName=$("<td></td>").append("单选题");
            else if(type==2)
                var typeName=$("<td></td>").append("多选题");
            else if(type==3)
                var typeName=$("<td></td>").append("判断题");
            else if(type==4)
                var typeName=$("<td></td>").append("填空题");
            else
                var typeName=$("<td></td>").append("简答题");
            //append方法执行完返回的还是原来的元素
            $("<tr></tr>")
                .append(mainIdTd)
                .append(mainTitleTd)
                .append(paperNameTd)
                .append(typeName)
                .append(submitTime)
                .addClass("maintr")
                .attr("answerId",item.id)//增加一个帖子编号属性
                .attr("trueAnswer",item.problem.answer)
                .attr("answer",item.answer)
                .attr("score",item.score)
                .attr("problemScore",item.problem.score)
                .attr("type",type)
                .attr("titleContent",proItem.titleContent)
                .appendTo("#mains_table tbody");
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


    //1.点击编辑钮创建之前就绑定了事件，编辑信息资料
    //2.可以在创建按钮的时候绑定事件
    //3.绑定点击.live()
    //jquery新版本没有live(),使用on替代
    $(document).on("mouseover ",".maintr",function () {//mouseover
        $(".showDetail").empty();
        var type=$(this).attr("type");
        if(type==1){
            type="单选题";
        }else if(type==2){
            type="多选题";
        }else if(type==3){
            type="判断题";
        }else if(type==4){
            type="填空题";
        }else{
            type="简答题";
        }
        var titleContent=$(this).attr("titleContent");
        var score=$(this).attr("score");
        var trueAnswer=$(this).attr("trueAnswer");
        var answer=$(this).attr("answer");
        var problemScore=$(this).attr("problemScore");
        // alert(type+" "+titleContent+" "+score+" "+trueAnswer+" "+answer);
        var ul=$("<ul></ul>");
        var typeli=$("<li></li>").append("题目类型："+type);
        if(titleContent.length>=28){
            titleContent=titleContent.substring(0,29)+"...";
        }
        var titleContentli=$("<li></li>").append("题干："+titleContent);
        var problemScoreli=$("<li></li>").append("满分："+problemScore);
        if(answer.length>=28){
            answer=answer.substring(0,28)+"...";
        }
        var answerli=$("<li></li>").append("您的答案："+answer);
        if(trueAnswer.length>=28){
            trueAnswer=trueAnswer.substring(0,28)+"...";
        }
        var trueAnswerli=$("<li></li>").append("正确答案："+trueAnswer);

        var scoreli=$("<li></li>").append("分数："+score);
        ul.append(typeli).append(typeli).append(titleContentli).append(problemScoreli).append(answerli).append(trueAnswerli).append(scoreli)
            .appendTo(".showDetail");
    });
    $(document).on("mouseout ","tr",function () {//mouseover
        // alert("heelo,mouseout");
    });

</script>
</body>
</html>
