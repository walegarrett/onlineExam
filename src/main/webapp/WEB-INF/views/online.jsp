<%--
  Created by IntelliJ IDEA.
  User: 浩瀚
  Date: 2020/8/10
  Time: 10:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <%
        //这个的路径是以斜线开始的，不以斜线结束
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <meta http-equiv="content-type" content="text/html;charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>在线考试</title>
    <link rel="shortcut icon" href="${APP_PATH}/statics/main/images/Absolutely.jpg" type="image/x-icon">
    <link href="${APP_PATH}/statics/online/css/main.css" rel="stylesheet" type="text/css"/>
    <link href="${APP_PATH}/statics/online/css/iconfont.css" rel="stylesheet" type="text/css"/>
    <link href="${APP_PATH}/statics/online/css/test.css" rel="stylesheet" type="text/css"/>
<%--    <link href="${APP_PATH}/statics/css/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet">--%>

<%--    <link href="${APP_PATH}/statics/css/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet">--%>
    <style>
        .hasBeenAnswer {
            background: #5d9cec;
            color: #fff;
        }
        .navbar{
            position:fixed;
            top:0px;
            width:70.5%;
            height:200px!important;
            z-index:1000;
            color:black;
        }
        .test{
            margin-top:50px;
        }
        .navbar-nav li{
            width:200px;
            margin:10px 50px;
            float:left!important;
        }
        .form-control{
            width:100%;
            height:35px;
            border-color:#c4e3f3;
            border-radius: 5px;
        }
        .input-textarea{
            width:100%;
            height:100px;
        }
        .glyphicon{position:relative;top:1px;display:inline-block;font-family:'Glyphicons Halflings';font-style:normal;font-weight:400;line-height:1;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale}
        .glyphicon-pencil:before{content:"\270f"}
        .glyphicon-tasks:before{content:"\e137"}
        .glyphicon-tags:before{content:"\e042"}
        .glyphicon-time:before{content:"\e023"}
    </style>

</head>
<body>
<div class="main">

    <!--nr start-->
    <div class="test_main">
        <div class="nr_left">
            <nav class="navbar navbar-default">
                <div class="container-fluid">
                    <!-- Collect the nav links, forms, and other content for toggling -->
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                        <ul class="nav navbar-nav">
                            <li><h2>${paper.paperName}</h2></li>
                            <li><h2>满分：${paper.totalScore}分</h2></li>
                            <li><h2>考试限时：${paper.durationTime}分钟</h2></li>
                        </ul>
                    </div><!-- /.navbar-collapse -->
                </div><!-- /.container-fluid -->

            </nav>
            <video class="text-right" id="video"style="
                width: 200px;height: 200px;
                position: fixed;right: 380px; top:40px;">
            </video>
            <div class="test">
                <form action="" method="post" id="onlineForm">

                    <div class="test_title">
<%--                        <p class="test_time">--%>
<%--                            <b class="alt-1">${avaHour}:${avaMinute}</b>--%>
<%--                        </p>--%>
                        <font><input type="button" name="test_jiaojuan" value="交卷" onclick="doPaper()"></font>
                    </div>

                    <div class="online_problem_main">

                    </div>
                    <div style="height: 100px!important;">

                    </div>
                </form>
            </div>
        </div>

        <div class="nr_right">
            <div class="nr_rt_main">
                <div class="rt_nr1">
                    <div class="rt_nr1_title">
                        <h1>
                            <i class="glyphicon glyphicon-pencil"></i>答题卡
                        </h1>
                        <p class="test_time">
<%--                            <i class="glyphicon glyphicon-time"></i>--%>
                            <b class="alt-1">${avaHour}:${avaMinute}</b>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--nr end-->
    <div class="foot"></div>
</div>
<script src="${APP_PATH}/statics/online/js/jquery-1.11.3.min.js"></script>

<%--<script type="text/javascript" src="${APP_PATH}/statics/bootstrapValidator/vendor/jquery/jquery-1.10.2.min.js"></script>--%>
<script src="${APP_PATH}/statics/online/js/jquery.easy-pie-chart.js"></script>
<!--时间js-->
<script src="${APP_PATH}/statics/online/js/jquery.countdown.js"></script>
<script src="${APP_PATH}/statics/ckeditor/adapters/jquery.js"></script>
<script src="${APP_PATH}/statics/ckeditor/ckeditor.js"></script>

<script>
    //访问用户媒体设备的兼容方法
    function getUserMedia(constraints, success, error) {
        if (navigator.mediaDevices.getUserMedia) {
            //最新的标准API
            navigator.mediaDevices.getUserMedia(constraints).then(success).catch(error);
        } else if (navigator.webkitGetUserMedia) {
            //webkit核心浏览器
            navigator.webkitGetUserMedia(constraints, success, error)
        } else if (navigator.mozGetUserMedia) {
            //firfox浏览器
            navigator.mozGetUserMedia(constraints, success, error);
        } else if (navigator.getUserMedia) {
            //旧版API
            navigator.getUserMedia(constraints, success, error);
        }
    }

    var video = document.getElementById('video');

    function success(stream) {
        //兼容webkit核心浏览器
        var CompatibleURL = window.URL || window.webkitURL;
        //将视频流设置为video元素的源
        console.log(stream);
        //video.src = CompatibleURL.createObjectURL(stream);
        video.srcObject = stream;
        video.play();
    }
    function error(error) {
        console.log('访问用户媒体设备失败${error.name}, ${error.message}');
    }

    if (navigator.mediaDevices.getUserMedia || navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia) {
        //调用用户媒体设备, 访问摄像头
        getUserMedia({video: {width: 480, height: 320}}, success, error);
    } else {
        alert('不支持访问用户媒体');
    }


    window.jQuery(function ($) {
        "use strict";
        $('time').countDown({
            with_separators: false
        });
        $('.alt-1').countDown({
            css_class: 'countdown-alt-1'
        });
        // $('.alt-2').countDown({
        //     css_class: 'countdown-alt-2'
        // });
    });
    function submitAnswer(questionId, answer) {
        $.ajax({
            data: {"userId":${userid},"questionId": questionId, "answer": answer, "paperId": ${paperId}},
            url: "${APP_PATH}/insertOrUpdateAnswer",
            async: true, //异步提交
            type: "post",
            success: function (result) {
                // alert(result.msg);
            }
        });
    }
    //点击单选题
    $(document).on('click',"input[mtype='single']",function () {
        var examId = $(this).closest('.test_content_nr_main').closest('li').attr('id'); // 得到题目ID
        var cardLi = $('a[href=#' + examId + ']'); // 根据题目ID找到对应答题卡
        // alert(cardLi);
        // 设置已答题
        if (!cardLi.hasClass('hasBeenAnswer')) {
            cardLi.addClass('hasBeenAnswer');
        }
        var ids=$(this).attr("name");
        ids=ids.substring(6);
        var questionId=parseInt(ids);
        var answer="";
        $('input[name="' + $(this).attr("name") + '"]:checked').each(function () {
            answer = $(this).val();
        });
        //alert(questionId+" "+answer);
        submitAnswer(questionId,answer);
    });
    //多选题
    $(document).on('click',"input[mtype='multiple']",function () {
        //alert($(this).attr("name"));//获取当前input的name
        debugger;
        var examId = $(this).closest('.test_content_nr_main').closest('li').attr('id'); // 得到题目ID
        var cardLi = $('a[href=#' + examId + ']'); // 根据题目ID找到对应答题卡
        // alert(cardLi);
        // 设置已答题
        if (!cardLi.hasClass('hasBeenAnswer')) {
            cardLi.addClass('hasBeenAnswer');
        }
        var ids=$(this).attr("name");
        ids=ids.substring(6);
        var questionId=parseInt(ids);
        var answer="";
        $('input[name="' + $(this).attr("name") + '"]:checked').each(function () {
            answer += $(this).val() + ",";//A,B,C,
        });
        if (answer.length > 0) {
            answer = answer.substring(0, answer.length - 1);
        }
        // alert(questionId+" "+answer);
        submitAnswer(questionId,answer);
    });
    //判断题
    $(document).on('click',"input[mtype='judge']",function (event) {
        //alert($(this).attr("name"));//获取当前input的name
        debugger;
        var examId = $(this).closest('.test_content_nr_main').closest('li').attr('id'); // 得到题目ID
        var cardLi = $('a[href=#' + examId + ']'); // 根据题目ID找到对应答题卡
        // alert(cardLi);
        // 设置已答题
        if (!cardLi.hasClass('hasBeenAnswer')) {
            cardLi.addClass('hasBeenAnswer');
        }
        var ids=$(this).attr("name");
        ids=ids.substring(6);
        var questionId=parseInt(ids);
        var answer="";
        $('input[name="' + $(this).attr("name") + '"]:checked').each(function () {
            answer = $(this).val();
        });
        // alert(questionId+" "+answer);
        submitAnswer(questionId,answer);
    });
    //填空,简答题
    $(document).on('change',".blankAndShort textarea, .blankAndShort input",function () {
        var examId = $(this).closest('.test_content_nr_main').closest('li').attr('id'); // 得到题目ID
        var cardLi = $('a[href=#' + examId + ']'); // 根据题目ID找到对应答题卡
        // alert(cardLi);
        // 设置已答题
        if (!cardLi.hasClass('hasBeenAnswer')) {
            cardLi.addClass('hasBeenAnswer');
        }
        var ids=$(this).attr("name");
        ids=ids.substring(6);
        var questionId=parseInt(ids);
        var answer="";
        answer=$(this).val();
        // alert(questionId+" "+answer);
        if(answer.length>=500){
            alert("填空和简答的答案字数不能超出500字！！！");
            return false;
        }
        submitAnswer(questionId,answer);
    });
    $(function () {
        //加载完页面就获取题目
        $.ajax({
            url:"${APP_PATH}/theAllProblem?paperId=${paperId}&userId=${userid}",
            type:"GET",
            async:false,
            success:function(result){
                //alert(radioProList.Problem[0].content+" "+mulProList+" "+judgeProList+" "+blankProList+" "+shortProList);
                buildRadioProList(result);buildAnswerSheet(result.extend.radioProList,0);
                buildMulProList(result);buildAnswerSheet(result.extend.mulProList,1);
                buildJudgeProList(result);buildAnswerSheet(result.extend.judgeProList,2);
                buildBlankProList(result);buildAnswerSheet(result.extend.blankProList,3);
                buildShortProList(result);buildAnswerSheet(result.extend.shortProList,4);
                // $(".alt-1").text(02+":"+60);
            }
        });
        // CKEDITOR.replace( '4_answer_28_option_1',{
        //     height:100,
        //     width:800
        // });
    });
    // $(document).ready(function () {
    //     alert($("#4_answer_28_option_1").val());
    //     CKEDITOR.replace( '4_answer_28_option_1',{
    //         height:100,
    //         width:200
    //     });
    // });
    //构建答题卡
    function buildAnswerSheet(list,type){
        if(list.length==0)
            return;
        var typename;
        if(type==0) typename="单选题";
        else if(type==1) typename="多选题";
        else if(type==2) typename="判断题";
        else if(type==3) typename="填空题";
        else typename="简答题";
        var problemnum=list.length;
        var rt_content_tt=$("<div class='rt_content_tt'><h2>"+typename+"</h2>" +
            "<p><span>共</span><i class='content_lit'>"+problemnum+"</i><span>题</span></p></div>");
        var rt_content_nr_answerSheet=$("<div class='rt_content_nr answerSheet'></div>");
        var ul=$("<ul></ul>");
        $.each(list,function (index,item) {
            var cnt=index+1;
            var li=$("<li><a href='#qu_"+type+"_"+item.id+"'>"+cnt+"</a></li>");
            li.appendTo(ul);
        });
        rt_content_nr_answerSheet.append(ul);
        $("<div class='rt_content'></div>").append(rt_content_tt).append(rt_content_nr_answerSheet).appendTo(".rt_nr1");
    }
    //简答题
    function buildShortProList(result){
        var shortProList=result.extend.shortProList;
        var length=shortProList.length;
        var test_contetn_nr=$("<div class=\"test_content_nr\"></div>");
        var nr_ul=$("<ul></ul>");
        var totalScore=0;
        var totalProNUm=0;
        //简答题
        $.each(shortProList,function (index,item) {
            // alert(item);
            var lastAnswer=item.userAnswer;//上次填写的答案
            var li1=$("<li id=\"qu_4_"+item.id+"\"></li>");
            var obj=item.content;
            //转换String为Json格式
            var proItem = JSON.parse(obj);
            li1.append($("<div class=\"test_content_nr_tt\"><i>"+(index+1)+"</i><span>("+item.score+"分)</span><font>"+proItem.titleContent+"</font><b class=\"glyphicon glyphicon-pencil\"></b></div>"));
            var nr_main=$("<div class=\"test_content_nr_main\"></div>");

            var blankAndShort=$("<div class=\"blankAndShort\"></div>");
            var optionA=$("<textarea class=\"input-textarea\" name=\"answer"+item.id+"\" id=\"4_answer_"+item.id+"_option_1\">"+lastAnswer+"</textarea>");
            // optionA.ckeditor();
            blankAndShort.append(optionA);
            nr_main.append(blankAndShort);
            li1.append(nr_main);
            //li1.appendTo(".test_content_nr_ul_5");
            test_contetn_nr.append(li1);
            totalScore+=item.score;
            totalProNUm++;
        });
        if(shortProList.length>0){
            var test_content=$("<div class='test_content'><div class='test_content_title'><h2>简答题</h2><p><span>共</span><i class='content_lit'>"+totalProNUm+"</i>" +
                "<span>题，</span><span>合计</span><i class='content_fs'>"+totalScore+"</i><span>分</span></p></div>");
            test_contetn_nr.append(nr_ul);
            $(".online_problem_main").append(test_content).append(test_contetn_nr);
        }
    }
    //填空题
    function buildBlankProList(result){
        var blankProList=result.extend.blankProList;
        var test_contetn_nr=$("<div class=\"test_content_nr\"></div>");
        var nr_ul=$("<ul></ul>");
        var totalScore=0;
        var totalProNUm=0;
        //填空题
        $.each(blankProList,function (index,item) {
            // alert(item.userAnswer);
            var lastAnswer=item.userAnswer;
            var li1=$("<li id=\"qu_3_"+item.id+"\"></li>");
            var obj=item.content;
            //转换String为Json格式
            var proItem = JSON.parse(obj);
            li1.append($("<div class=\"test_content_nr_tt\"><i>"+(index+1)+"</i><span>("+item.score+"分)</span><font>"+proItem.titleContent+"</font><b class=\"glyphicon glyphicon-pencil\"></b></div>"));
            var nr_main=$("<div class=\"test_content_nr_main\"></div>");
            var blankAndShort=$("<div class=\"blankAndShort\"></div>");
            var optionA=$("<input type=\"text\" class=\"form-control\" name=\"answer"+item.id+"\" id=\"3_answer_"+item.id+"_option_1\" value=\""+lastAnswer+"\"/>");
            blankAndShort.append(optionA);
            nr_main.append(blankAndShort);
            li1.append(nr_main);
            // li1.appendTo(".test_content_nr_ul_4");
            test_contetn_nr.append(li1);
            totalScore+=item.score;
            totalProNUm++;
        });
        if(blankProList.length>0){
            var test_content=$("<div class='test_content'><div class='test_content_title'><h2>填空题</h2><p><span>共</span><i class='content_lit'>"+totalProNUm+"</i>" +
                "<span>题，</span><span>合计</span><i class='content_fs'>"+totalScore+"</i><span>分</span></p></div>");
            test_contetn_nr.append(nr_ul);
            $(".online_problem_main").append(test_content).append(test_contetn_nr);
        }
    }
    //判断题
    function buildJudgeProList(result){
        var judgeProList=result.extend.judgeProList;
        var test_contetn_nr=$("<div class=\"test_content_nr\"></div>");
        var nr_ul=$("<ul></ul>");
        var totalScore=0;
        var totalProNUm=0;
        //判断题
        $.each(judgeProList,function (index,item) {
            // alert(item);
            var lastAnswer=item.userAnswer;
            var A=false,B=false;
            if(lastAnswer.length>0){
                var opt=lastAnswer[0];
                if(opt=="A") A=true;
                if(opt=="B") B=true;
            }
            var li1=$("<li id=\"qu_2_"+item.id+"\"></li>");
            var obj=item.content;
            //转换String为Json格式
            var proItem = JSON.parse(obj);
            li1.append($("<div class=\"test_content_nr_tt\"><i>"+(index+1)+"</i><span>("+item.score+"分)</span><font>"+proItem.titleContent+"</font><b class=\"glyphicon glyphicon-pencil\"></b></div>"));
            var nr_main=$("<div class=\"test_content_nr_main\"></div>");
            var ul=$("<ul></ul>");
            if(A==true)
                var optionA=$("<li class=\"option\"><input type=\"radio\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"2_answer_"+item.id+"_option_1\" value=\"A\" mtype=\"judge\" checked/>" +
                "<label for=\"2_answer_"+item.id+"_option_1\"><p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[0].content+"</p></label></li>");
            else var optionA=$("<li class=\"option\"><input type=\"radio\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"2_answer_"+item.id+"_option_1\" value=\"A\" mtype=\"judge\"/>" +
                "<label for=\"2_answer_"+item.id+"_option_1\"><p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[0].content+"</p></label></li>");
            if(B==true)
                var optionB=$("<li class=\"option\"><input type=\"radio\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"2_answer_"+item.id+"_option_2\" value=\"B\" mtype=\"judge\" checked/>" +
                "<label for=\"2_answer_"+item.id+"_option_2\"><p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[1].content+"</p></label></li>");
            else var optionB=$("<li class=\"option\"><input type=\"radio\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"2_answer_"+item.id+"_option_2\" value=\"B\" mtype=\"judge\"/>" +
                "<label for=\"2_answer_"+item.id+"_option_2\"><p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[1].content+"</p></label></li>");
            ul.append(optionA).append(optionB);
            nr_main.append(ul);
            li1.append(nr_main);
            // li1.appendTo(".test_content_nr_ul_3");
            test_contetn_nr.append(li1);
            totalScore+=item.score;
            totalProNUm++;
        });
        if(judgeProList.length>0){
            var test_content=$("<div class='test_content'><div class='test_content_title'><h2>判断题</h2><p><span>共</span><i class='content_lit'>"+totalProNUm+"</i>" +
                "<span>题，</span><span>合计</span><i class='content_fs'>"+totalScore+"</i><span>分</span></p></div>");
            test_contetn_nr.append(nr_ul);
            $(".online_problem_main").append(test_content).append(test_contetn_nr);
        }
    }
    //多选题
    function buildMulProList(result){
        var mulProList=result.extend.mulProList;
        var test_contetn_nr=$("<div class=\"test_content_nr\"></div>");
        var nr_ul=$("<ul></ul>");
        var totalScore=0;
        var totalProNUm=0;
        //多选题
        $.each(mulProList,function (index,item) {
            // alert(item);
            var answer=item.userAnswer;
            var lastAnswer=answer.split(",");
            console.log(lastAnswer);
            var A=false,B=false,C=false,D=false;
            for(var j=0;j<lastAnswer.length;j++){
                var opt=lastAnswer[j];
                if(opt=="A") A=true;
                if(opt=="B") B=true;
                if(opt=="C") C=true;
                if(opt=="D") D=true;
            }
            var li1=$("<li id=\"qu_1_"+item.id+"\"></li>");
            var obj=item.content;
            //转换String为Json格式
            var proItem = JSON.parse(obj);

            li1.append($("<div class=\"test_content_nr_tt\"><i>"+(index+1)+"</i><span>("+item.score+"分)</span><font>"+proItem.titleContent+"</font><b class=\"glyphicon glyphicon-pencil\"></b></div>"));

            var nr_main=$("<div class=\"test_content_nr_main\"></div>");
            var ul=$("<ul></ul>");
            if(A==true)
                var optionA=$("<li class=\"option\"><input type=\"checkbox\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"1_answer_"+item.id+"_option_1\" value=\"A\" mtype=\"multiple\" checked/>" +
                "<label for=\"1_answer_"+item.id+"_option_1\">A. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[0].content+"</p></label></li>");
            else var optionA=$("<li class=\"option\"><input type=\"checkbox\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"1_answer_"+item.id+"_option_1\" value=\"A\" mtype=\"multiple\"/>" +
                "<label for=\"1_answer_"+item.id+"_option_1\">A. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[0].content+"</p></label></li>");
            if(B==true)
                var optionB=$("<li class=\"option\"><input type=\"checkbox\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"1_answer_"+item.id+"_option_2\" value=\"B\" mtype=\"multiple\" checked/>" +
                "<label for=\"1_answer_"+item.id+"_option_2\">B. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[1].content+"</p></label></li>");
            else var optionB=$("<li class=\"option\"><input type=\"checkbox\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"1_answer_"+item.id+"_option_2\" value=\"B\" mtype=\"multiple\"/>" +
                "<label for=\"1_answer_"+item.id+"_option_2\">B. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[1].content+"</p></label></li>");
            if(C==true)
                var optionC=$("<li class=\"option\"><input type=\"checkbox\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"1_answer_"+item.id+"_option_3\" value=\"C\" mtype=\"multiple\" checked/>" +
                "<label for=\"1_answer_"+item.id+"_option_3\">C. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[2].content+"</p></label></li>");
            else var optionC=$("<li class=\"option\"><input type=\"checkbox\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"1_answer_"+item.id+"_option_3\" value=\"C\" mtype=\"multiple\"/>" +
                "<label for=\"1_answer_"+item.id+"_option_3\">C. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[2].content+"</p></label></li>");
            if(D==true)
                var optionD=$("<li class=\"option\"><input type=\"checkbox\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"1_answer_"+item.id+"_option_4\" value=\"D\" mtype=\"multiple\" checked/>" +
                "<label for=\"1_answer_"+item.id+"_option_4\">D. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[3].content+"</p></label></li>");
            else var optionD=$("<li class=\"option\"><input type=\"checkbox\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"1_answer_"+item.id+"_option_4\" value=\"D\" mtype=\"multiple\"/>" +
                "<label for=\"1_answer_"+item.id+"_option_4\">D. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[3].content+"</p></label></li>");
            ul.append(optionA).append(optionB).append(optionC).append(optionD);
            nr_main.append(ul);
            li1.append(nr_main);
            // li1.appendTo(".test_content_nr_ul_2");
            test_contetn_nr.append(li1);
            totalScore+=item.score;
            totalProNUm++;
        });
        if(mulProList.length>0){
            var test_content=$("<div class='test_content'><div class='test_content_title'><h2>多选题</h2><p><span>共</span><i class='content_lit'>"+totalProNUm+"</i>" +
                "<span>题，</span><span>合计</span><i class='content_fs'>"+totalScore+"</i><span>分</span></p></div>");
            test_contetn_nr.append(nr_ul);
            $(".online_problem_main").append(test_content).append(test_contetn_nr);
        }
    }
    //单选
    function buildRadioProList(result){
        var radioProList=result.extend.radioProList;
        var test_contetn_nr=$("<div class=\"test_content_nr\"></div>");
        var nr_ul=$("<ul></ul>");
        var totalScore=0;
        var totalProNUm=0;
        //单选题
        $.each(radioProList,function (index,item) {
            var lastAnswer=item.userAnswer;
            var A=false,B=false,C=false,D=false;
            if(lastAnswer.length>0){
                var opt=lastAnswer[0];
                if(opt=="A") A=true;
                else if(opt=="B") B=true;
                else if(opt=="C") C=true;
                else D=true;
            }
            var li1=$("<li id=\"qu_0_"+item.id+"\"></li>");
            var obj=item.content;
            //转换String为Json格式
            var proItem = JSON.parse(obj);

            li1.append($("<div class=\"test_content_nr_tt\"><i>"+(index+1)+"</i><span>("+item.score+"分)</span><font>"+proItem.titleContent+"</font><b class=\"glyphicon glyphicon-pencil\"></b></div>"));

            var nr_main=$("<div class=\"test_content_nr_main\"></div>");
            var ul=$("<ul></ul>");
            if(A==true)
                var optionA=$("<li class=\"option\"><input type=\"radio\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"0_answer_"+item.id+"_option_1\" value=\"A\" mtype=\"single\" checked/>" +
                "<label for=\"0_answer_"+item.id+"_option_1\">A. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[0].content+"</p></label></li>");
            else var optionA=$("<li class=\"option\"><input type=\"radio\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"0_answer_"+item.id+"_option_1\" value=\"A\" mtype=\"single\"/>" +
                "<label for=\"0_answer_"+item.id+"_option_1\">A. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[0].content+"</p></label></li>");
            if(B==true)
                var optionB=$("<li class=\"option\"><input type=\"radio\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"0_answer_"+item.id+"_option_1\" value=\"B\" mtype=\"single\" checked/>" +
                "<label for=\"0_answer_"+item.id+"_option_1\">B. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[1].content+"</p></label></li>");
            else var optionB=$("<li class=\"option\"><input type=\"radio\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"0_answer_"+item.id+"_option_1\" value=\"B\" mtype=\"single\"/>" +
                "<label for=\"0_answer_"+item.id+"_option_1\">B. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[1].content+"</p></label></li>");
            if(C==true)
                var optionC=$("<li class=\"option\"><input type=\"radio\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"0_answer_"+item.id+"_option_1\" value=\"C\" mtype=\"single\" checked/>" +
                "<label for=\"0_answer_"+item.id+"_option_1\">C. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[2].content+"</p></label></li>");
            else var optionC=$("<li class=\"option\"><input type=\"radio\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"0_answer_"+item.id+"_option_1\" value=\"C\" mtype=\"single\"/>" +
                "<label for=\"0_answer_"+item.id+"_option_1\">C. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[2].content+"</p></label></li>");
            if(D==true)
                var optionD=$("<li class=\"option\"><input type=\"radio\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"0_answer_"+item.id+"_option_1\" value=\"D\" mtype=\"single\" checked/>" +
                "<label for=\"0_answer_"+item.id+"_option_1\">D. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[3].content+"</p></label></li>");
            else var optionD=$("<li class=\"option\"><input type=\"radio\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"0_answer_"+item.id+"_option_1\" value=\"D\" mtype=\"single\"/>" +
                "<label for=\"0_answer_"+item.id+"_option_1\">D. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[3].content+"</p></label></li>");
            ul.append(optionA).append(optionB).append(optionC).append(optionD);
            nr_main.append(ul);
            li1.append(nr_main);
            // li1.appendTo(".test_content_nr_ul_1");
            nr_ul.append(li1);
            totalScore+=item.score;
            totalProNUm++;
        });
        if(radioProList.length>0){
            var test_content=$("<div class='test_content'><div class='test_content_title'><h2>单选题</h2><p><span>共</span><i class='content_lit'>"+totalProNUm+"</i>" +
                "<span>题，</span><span>合计</span><i class='content_fs'>"+totalScore+"</i><span>分</span></p></div>");
            test_contetn_nr.append(nr_ul);
            $(".online_problem_main").append(test_content).append(test_contetn_nr);
        }
    }
    function validateAnswer(list){
        var flag=true;
        $.each(list,function (index,item) {
            //alert(item.userAnswer);
            if(item.userAnswer==""||item.userAnswer==undefined||item.userAnswer==null){
                //alert("false");
                flag=false;
            }
        });
        //alert(flag);
        return flag;
    }
    function testValidate(){
        var success=true;
        $.ajax({
            url:"${APP_PATH}/theAllProblem?paperId=${paperId}",
            type:"GET",
            async:false,
            success:function(result){
                //alert(radioProList.Problem[0].content+" "+mulProList+" "+judgeProList+" "+blankProList+" "+shortProList);
                success=success&&validateAnswer(result.extend.radioProList);
                //alert(success);
                success=success&&validateAnswer(result.extend.mulProList);
                //alert(success);
                success=success&&validateAnswer(result.extend.judgeProList);
                //alert(success);
                success=success&&validateAnswer(result.extend.blankProList);
                //alert(success);
                success=success&&validateAnswer(result.extend.shortProList);
                //alert(success);
                // $(".alt-1").text(02+":"+60);
            }
        });
        //alert(success);
        return success;
    }
    /**
     * 自动提交试卷
     * */
    function autoSubmitSheet() {
        $.ajax({
            url: "${APP_PATH}/submitPaper",
            data: {"userId":${userid}, "paperId": ${paperId}},
            async: true,
            type: "post",
            success: function (result) {
                if (result.code == 100) {
                    alert("交卷成功");
                    location.href = "${APP_PATH}/toWhere?where=examRecord";
                } else {
                    alert("交卷失败")
                }
            }
        })
    }
    /**
     * 交卷
     */
    function doPaper() {
        var times=$(".alt-1").text();
        //alert(times);
        var validate = testValidate();
        if (!validate) {
            var confir=confirm("你还有题目未作答，一旦交卷无法修改！！！确认交卷？");
            if(confir==false) return false;
        }else {
            var confir=confirm("题目已经全部作答完成，是否确认提交试卷");
            if(confir==false) return false;
        }

        //return false;
        // $.modal.loading("正在交卷中，请稍后...");
        $.ajax({
            url: "${APP_PATH}/submitPaper",
            data: {"userId":${userid}, "paperId": ${paperId}},
            async: true,
            type: "post",
            success: function (result) {
                if (result.code == 100) {
                    alert("交卷成功");
                    location.href = "${APP_PATH}/toWhere?where=examRecord";
                } else {
                    alert("交卷失败")
                }
            }
        })
    }
</script>

<%--<div style="text-align:center;margin:50px 0; font:normal 14px/24px 'MicroSoft YaHei';">--%>
<%--    <p>适用浏览器：360、FireFox、Chrome、Safari、Opera、傲游、搜狗、世界之窗. 不支持IE8及以下浏览器。</p>--%>
<%--    <p>来源：<a href="http://sc.chinaz.com/" target="_blank">站长素材</a></p>--%>
<%--</div>--%>
</body>
</html>

