<%--
  Created by IntelliJ IDEA.
  User: 浩瀚
  Date: 2020/8/10
  Time: 9:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!--

@Name：不落阁整站模板源码
@Author：Absolutely
@Site：http://www.lyblogs.cn

-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%
        //这个的路径是以斜线开始的，不以斜线结束
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <meta http-equiv="Content-Type" content="text/html; Charset=gb2312">
    <meta http-equiv="Content-Language" content="zh-CN">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>在线考试系统-首页</title>
    <link rel="shortcut icon" href="${APP_PATH}/statics/main/images/Logo_40.png" type="image/x-icon">
    <!--Layui-->
    <link href="${APP_PATH}/statics/main/plug/layui/css/layui.css" rel="stylesheet" />
    <!--font-awesome-->
    <link href="${APP_PATH}/statics/main/plug/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    <!--全局样式表-->
    <link href="${APP_PATH}/statics/main/css/global.css" rel="stylesheet" />
    <!-- 本页样式表 -->
    <link href="${APP_PATH}/statics/main/css/home.css" rel="stylesheet" />
    <script src="${APP_PATH}/statics/js/jquery-1.10.2.js"></script>
    <link href="${APP_PATH}/statics/css/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet">
    <script src="${APP_PATH}/statics/css/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <style>
        .dropdown-menu li a{
            color:#1aa094 !important;
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
        .img-circles{
            border-radius: 100%;
        }
    </style>
</head>
<body>
<!-- 编辑板块模态框 -->
<div class="modal fade" id="inviCodeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">邀请码</h4>
            </div>
            <div class="modal-body">
                <!--编辑表单-->
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="input_code" class="col-sm-2 control-label">请填写邀请码：</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="input_code" id="input_code" placeholder="请填写邀请码">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">关闭</button>
                <button type="submit" class="btn btn-primary btn-sm" id="code_btn">确定</button>
            </div>
        </div>
    </div>
</div>
<!-- 导航 -->
<nav class="blog-nav layui-header">
    <div class="blog-container">
        <!-- QQ互联登陆 -->
        <%--        <a href="javascript:;" class="blog-user layui-hide">--%>
        <%--            <img src="${APP_PATH}/statics/main/images/Absolutely.jpg" alt="Absolutely" title="Absolutely" />--%>
        <%--        </a>--%>
        <!-- 不落阁 -->
        <a class="blog-logo" href="index2.jsp">在线考试系统</a>
        <!-- 导航菜单 -->
        <ul class="layui-nav" lay-filter="nav" style="margin-left:170px">
            <li class="layui-nav-item layui-this">
                <a href="index2.jsp"><i class="fa fa-home fa-fw"></i>&nbsp;网站首页</a>
            </li>
            <li class="layui-nav-item">
                <a href="${APP_PATH}/toWhere?where=paperCenter"><i class="fa fa-file-text fa-fw"></i>&nbsp;试卷中心</a>
            </li>
            <li class="layui-nav-item">
                <a href="${APP_PATH}/toWhere?where=examRecord"><i class="fa fa-tags fa-fw"></i>&nbsp;考试记录</a>
            </li>
            <li class="layui-nav-item">
                <a href="${APP_PATH}/toWhere?where=wrongRecord"><i class="fa fa-tags fa-fw"></i>&nbsp;错题记录</a>
            </li>

            <c:if test="${userid==null}">
                <li class="layui-nav-item">
                    <a href="${APP_PATH}/login"><i class="fa fa-info fa-fw"></i>登录</a>
                </li>
                <li class="layui-nav-item">
                    <a href="${APP_PATH}/register"><i class="fa fa-info fa-fw"></i>注册</a>
                </li>
                <li class="layui-nav-item">
                    <a href="${APP_PATH}/admin"><i class="fa fa-tags fa-fw"></i>&nbsp;管理员入口</a>
                </li>
            </c:if>
            <c:if test="${userid!=null&&role!=3}">
                <li class="layui-nav-item dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                        <img src="${userheadpic}" alt='头像' class="img-circle" width=30px height=30px><span> ${username}</span><span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="${APP_PATH}/toWhere?where=personalCenter">个人主页</a></li>
                        <li id="message">
                            <a href="${APP_PATH}/toReadMessage?userId=${userid}">
                                个人消息<span id="msgNum" class="ii">4</span></a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="${APP_PATH}/userExit">退出登录</a></li>
                    </ul>
                </li>
            </c:if>
            <c:if test="${userid!=null&&role==3}">
                <li class="layui-nav-item">
                    <a href="${APP_PATH}/admin"><i class="fa fa-tags fa-fw"></i>&nbsp;管理员入口</a>
                </li>
            </c:if>
        </ul>
        <!-- 手机和平板的导航开关 -->
        <a class="blog-navicon" href="javascript:;">
            <i class="fa fa-navicon"></i>
        </a>
    </div>
</nav>
<!-- 主体（一般只改变这里的内容） -->
<div class="blog-body">
    <!-- canvas -->
    <canvas id="canvas-banner" style="background: #393D49;"></canvas>
    <!--为了及时效果需要立即设置canvas宽高，否则就在home.js中设置-->
    <script type="text/javascript">
        var canvas = document.getElementById('canvas-banner');
        canvas.width = window.document.body.clientWidth - 10;//减去滚动条的宽度
        if (screen.width >= 992) {
            canvas.height = window.innerHeight * 1 / 3;
        } else {
            canvas.height = window.innerHeight * 2 / 7;
        }
    </script>
    <!-- 这个一般才是真正的主体内容 -->
    <div class="blog-container">
        <div class="blog-main">
            <!-- 网站公告提示 -->
            <div class="home-tips shadow">
                <i style="float:left;line-height:17px;" class="fa fa-volume-up"></i>
                <div class="home-tips-container">
                    <span style="color: #009688">本考试系统主要面向在校的老师和学生用户！学生可以在线考试，老师也可以发布相关的考试信息！！</span>
                    <span style="color: red">考试系统还具有信息留言的功能哦，老师可以通过这个功能向学生发送考试邀请码哦！！！</span>
                    <span style="color: red">如果你觉得这个网站做的不错，可以多多支持我哦！多多访问就是最大的支持哈！</span>
                    <span style="color: #009688">本次专业实训项目主要使用SSM框架以及前端的layui框架实现！耗时一个多月，同时支持学生，老师和管理员的各种考试相关功能！</span>
                </div>
            </div>
            <!--左边文章列表-->
            <div class="blog-main-left">
                <!--开始陈列-->
                <div class="article shadow">
                    <div class="article-left">
                        <img src="${APP_PATH}/statics/main/images/cover/201703181909057125.jpg"/>
                    </div>
                    <div class="article-right">
                        <div class="article-title">
                            <a href="">基于laypage的layui扩展模块（pagesize.js）！</a>
                        </div>
                        <div><!-- class="article-abstract"-->
                            <ul>
                                <li>总分: </li>
                                <li>开始时间: </li>
                                <li>限时: </li>
                            </ul>
                        </div>
                    </div>
                    <div class="clear"></div>
                    <div class="article-footer">
                        <span><i class="fa fa-clock-o"></i> 2017-03-18</span>
                        <span class="article-author"><i class="fa fa-user"> </i> Absolutely</span>
                        <span class="article-viewinfo"><i class="fa fa-eye"> </i> </span>
                        <span class="article-viewinfo"><i class="fa fa-commenting"> </i> </span>
                    </div>
                </div>


            </div>
            <!--右边小栏目-->
            <div class="blog-main-right">
                <div class="blogerinfo shadow">
                    <div class="blogerinfo-figure">
                        <img class="img-circles" src="${APP_PATH}/statics/main/images/Absolutely.jpg" alt="Absolutely" width="150px" height="150px"/>
                    </div>
                    <p class="blogerinfo-nickname">在线考试系统</p>
                    <p class="blogerinfo-introduce">南昌大学-专业实训项目-面向学校老师和学生的在线考试及管理系统</p>
                    <p class="blogerinfo-location"><i class="fa fa-location-arrow"></i>&nbsp;江西 - 南昌</p>
                    <hr />
                </div>
                <div></div><!--占位-->
                <div class="blog-module shadow" style="height:80%;">
                    <div class="blog-module-title">最热考试</div>
                    <ul class="fa-ul blog-module-ul">
                        <li><i class="fa-li fa fa-hand-o-right"></i><a href="http://pan.baidu.com/s/1c1BJ6Qc" target="_blank">Canvas</a></li>
                        <li><i class="fa-li fa fa-hand-o-right"></i><a href="http://pan.baidu.com/s/1kVK8UhT" target="_blank">pagesize.js</a></li>
                        <li><i class="fa-li fa fa-hand-o-right"></i><a href="https://pan.baidu.com/s/1mit2aiW" target="_blank">时光轴</a></li>
                        <li><i class="fa-li fa fa-hand-o-right"></i><a href="https://pan.baidu.com/s/1nuAKF81" target="_blank">图片轮播</a></li>
                    </ul>
                </div>
            </div>
            <div class="clear"></div>
        </div>
    </div>
</div>
<!-- 底部 -->
<footer class="blog-footer">
    <p><span>Copyright</span><span>&copy;</span><span>2020</span><a href="">郭观辉</a><span>Design By Guanhui Guo</span></p>
    <p><a href="http://www.miibeian.gov.cn/" target="_blank">南昌大学</a></p>
</footer>
<!--侧边导航-->
<ul class="layui-nav layui-nav-tree layui-nav-side blog-nav-left layui-hide" lay-filter="nav">
    <li class="layui-nav-item layui-this">
        <a href="index2.jsp"><i class="fa fa-home fa-fw"></i>&nbsp;网站首页</a>
    </li>
    <li class="layui-nav-item">
        <a href="${APP_PATH}/toWhere?where=paperCenter"><i class="fa fa-file-text fa-fw"></i>&nbsp;试卷中心</a>
    </li>
    <li class="layui-nav-item">
        <a href="${APP_PATH}/toWhere?where=examRecord"><i class="fa fa-tags fa-fw"></i>&nbsp;考试记录</a>
    </li>
    <li class="layui-nav-item">
        <a href="${APP_PATH}/toWhere?where=wrongRecord"><i class="fa fa-tags fa-fw"></i>&nbsp;错题记录</a>
    </li>
    <c:if test="${userid==null}">
        <li class="layui-nav-item">
            <a href="${APP_PATH}/login"><i class="fa fa-info fa-fw"></i>登录</a>
        </li>
        <li class="layui-nav-item">
            <a href="${APP_PATH}/register"><i class="fa fa-info fa-fw"></i>注册</a>
        </li>
        <li class="layui-nav-item">
            <a href="${APP_PATH}/admin"><i class="fa fa-tags fa-fw"></i>&nbsp;管理员入口</a>
        </li>
    </c:if>
    <c:if test="${userid!=null&&role!=3}">
        <li class="layui-nav-item dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                <img src="${userheadpic}" alt='头像' class="img-circle" width=30px height=30px><span> ${username}</span><span class="caret"></span></a>
            <ul class="dropdown-menu">
                <li><a href="${APP_PATH}/toWhere?where=personalCenter">个人主页</a></li>
                <li id="message1">
                    <a href="${APP_PATH}/toReadMessage?userId=${userid}">
                        个人消息<span id="msgNum1" class="ii">4</span></a></li>
                <li role="separator" class="divider"></li>
                <li><a href="${APP_PATH}/userExit">退出登录</a></li>
            </ul>
        </li>
    </c:if>
    <c:if test="${userid!=null&&role==3}">
        <li class="layui-nav-item">
            <a href="${APP_PATH}/admin"><i class="fa fa-tags fa-fw"></i>&nbsp;管理员入口</a>
        </li>
    </c:if>
</ul>
<!--分享窗体-->
<div class="blog-share layui-hide">
    <div class="blog-share-body">
        <div style="width: 200px;height:100%;">
            <div class="bdsharebuttonbox">
                <a class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
                <a class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a>
                <a class="bds_weixin" data-cmd="weixin" title="分享到微信"></a>
                <a class="bds_sqq" data-cmd="sqq" title="分享到QQ好友"></a>
            </div>
        </div>
    </div>
</div>
<!--遮罩-->
<div class="blog-mask animated layui-hide"></div>

<!-- layui.js -->
<script src="${APP_PATH}/statics/main/plug/layui/layui.js"></script>
<!-- 全局脚本 -->
<script src="${APP_PATH}/statics/main/js/global.js"></script>
<!-- 本页脚本 -->
<script src="${APP_PATH}/statics/main/js/home.js"></script>
<script src="${APP_PATH}/statics/js/common.js"></script>
<script>

    /*
    显示主页的考试
     */
    function buildNoEncryAndNum(result){
        $(".blog-main-left").empty();
        var paperlist=result.extend.paperlist;
        $.each(paperlist,function (index,item) {//所有的版块
            if(index<5){
                var articleshadow=$("<div class='article shadow'></div>")
                var articleleft=$("<div class='article-left'><img src='${APP_PATH}/statics/main/images/cover/201703181909057125.jpg'/></div>")
                var articleright=$("<div class='article-right'></div>");
                var articletitle=$("<div class='article-title'></div>");
                var href=$("<a class='paperlink' href=''>"+item.paperName+"</a>");
                href.attr("paperId",item.id);
                href.attr("startTime",item.startTime);
                href.attr("endTime",item.endTime);
                href.attr("inviCode",item.inviCode);
                articletitle.append(href);
                var startTime=item.startTime;
                var time1=formatDate(startTime);
                var time2=formatDateHourAndMinute(startTime);
                var div=$("<div><ul><li>总分："+item.totalScore+"</li><li>开始时间："+time1+" "+time2+"</li>" +
                    "<li>限时："+item.durationTime+"（分）</li></ul></div>");
                articleright.append(articletitle).append(div);
                var clear=$("<div class='clear'></div>");
                var articlefooter=$("<div class='article-footer'></div>");
                var createTime=item.createTime;
                createTime=formatDate(createTime)+" "+formatDateHourAndMinute(createTime);
                var span=$("<span><i class=\"fa fa-clock-o\"></i> "+createTime+"</span>" +
                    "<span class=\"article-author\"><i class=\"fa fa-user\"> </i> "+item.createrUserName+"</span>" +
                    "<span class=\"article-viewinfo\"><i class=\"fa fa-eye\"> </i> </span>" +
                    "<span class=\"article-viewinfo\"><i class=\"fa fa-commenting\"> </i> </span>");
                articlefooter.append(span);
                articleshadow.append(articleleft).append(articleright).append(clear).append(articlefooter);
                articleshadow.appendTo(".blog-main-left");
            }
        });
    }
    function buildRecentExam(result){
        $(".blog-module-ul").empty();
        var paperlist=result.extend.paperlist;
        $.each(paperlist,function (index,item) {//所有的版块
            if(index<15){
                var li=$("<li><i class=\"fa-li fa fa-hand-o-right\"></i></li>");
                var href=$("<a class='paperlink' href=''>"+item.paperName+"</a>");
                href.attr("paperId",item.id);
                href.attr("startTime",item.startTime);
                href.attr("endTime",item.endTime);
                href.attr("inviCode",item.inviCode);
                li.append(href);
                li.appendTo(".blog-module-ul");
            }
        });
    }
    function checkHasDoExam(paperId,userId,inviCode){
        // alert(paperId);
        if(inviCode!=""){//参加这次考试需要邀请码
            $("#inviCodeModal").modal({
                backdrop:"static"
            });
        }else{
            window.open("${APP_PATH}/thePaper?paperId="+paperId);
        }
        $("#code_btn").click(function () {
            var code=$("#input_code").val();
            // var paperId=parseInt($(this).attr("paperId"));
            // alert(paperId);
            $.ajax({
                data: {"paperId": paperId,"code":code},
                url: "${APP_PATH}/checkInviCode",
                async: false, //异步提交
                type: "post",
                success: function (result) {
                    if(result.code==200){
                        alert("输入的邀请码不正确，请重新输入！！！");
                        return false;
                    }else{
                        window.location.href="${APP_PATH}/thePaper?paperId="+paperId;
                        return true;
                    }
                }
            });
        });
    }
    $(document).on('click',".paperlink",function () {
        var paperId=$(this).attr("paperId");
        paperId=parseInt(paperId);
        var userid="${userid}";
        var inviCode=$(this).attr("inviCode");
        if(userid==undefined||userid==""||userid==null){
            alert("您还未登录，无法进行答题！！！");
            return;
        }
        userid=parseInt(userid);
        var startTime=$(this).attr("startTime");
        var endTime=$(this).attr("endTime");
        var now=new Date();
        now=now.getTime();
        if(now<startTime){
            alert("考试还未开始！");
            return false;
        }else if(now>endTime){
            alert("考试已经结束！");
            return false;
        }
        var data={
            "userId":userid,
            "paperId":paperId
        };
        var flag=true;
        $.ajax({
            url:"${APP_PATH}/checkIsAnswer",
            data:data,
            type:"get",
            async:false,
            success:function (result) {
                //console.log(result);
               if(result.code==100){//已经答题
                   flag=false;
                   alert("您已经完成了该套试卷，无法重复考试！");
               }
            }
        });
        if(!flag)
            return false;
        // alert(paperId+" "+startTime+" "+endTime+" "+now.getTime());
        <%--window.location.href="${APP_PATH}/thePaper?paperId="+paperId;--%>
        checkHasDoExam(paperId,userid,inviCode);
        return false;
    });
    $(function(){
        $.ajax({
            url:"${APP_PATH}/findPaperInIndex",
            type:"GET",
            async:false,
            success:function(result){
                buildNoEncryAndNum(result);
                // buildRecentExam(result);
            }
        });
        $.ajax({
            url:"${APP_PATH}/findPaperHottest",
            type:"GET",
            async:false,
            success:function(result){
                // buildNoEncryAndNum(result);
                buildRecentExam(result);
            }
        });
        showNoReadCount("${APP_PATH}","${userid}");
    });
</script>
</body>
</html>
