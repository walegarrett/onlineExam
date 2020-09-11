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
    <title>分数详情</title>

    <link href="${APP_PATH}/statics/online/css/main.css" rel="stylesheet" type="text/css"/>
    <link href="${APP_PATH}/statics/online/css/iconfont.css" rel="stylesheet" type="text/css"/>
    <link href="${APP_PATH}/statics/online/css/test.css" rel="stylesheet" type="text/css"/>
<%--    <link href="${APP_PATH}/statics/css/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet">--%>
    <style>
        .hasBeenAnswer {
            background: #5d9cec;
            color: #fff;
        }
        .input-textarea{
            width:100% !important;
            height:100px!important;
        }
        .commentInput{
            width:500px!important;
            /*border-color:#c4e3f3;*/
            border:none;
            font-size: 18px;
        }
        .totalScoreInput{
            /*border-color:#c4e3f3;*/
            color:#339933;
            border:none;
            width:100px!important;
            font-size: 18px;
        }
        .glyphicon{position:relative;top:1px;display:inline-block;font-family:'Glyphicons Halflings';font-style:normal;font-weight:400;line-height:1;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale}
        .glyphicon-pencil:before{content:"\270f"}
        .glyphicon-tasks:before{content:"\e137"}
        .glyphicon-tags:before{content:"\e042"}
        .form-control{
            width:100%;
            height:35px;
            border-color:#bce8f1;
            border-radius: 5px;
        }
        .score-input{
            color:#FF00FF;
            border-color:#fcf8e3;
            border-radius: 5px;
        }
        .test_time{
            font-size: 18px;
        }
    </style>
</head>
<body>
<div class="main">
    <!--nr start-->
    <div class="test_main">
        <div class="nr_left">
            <div class="test">
                <form action="" method="post" id="onlineForm">

                    <div class="test_title">
                        <p class="test_time">
                            <label>试卷得分：</label><input class="totalScoreInput" type="text" name="totalScore" value="${totalScore}" disabled/>
                            <label>批语：</label><input class="commentInput" type="text" name="comment" value="${sheet.comment}" disabled/>
                        </p>
<%--                        <font><input type="button" name="test_jiaojuan" value="提交成绩" onclick="doJudge()"></font>--%>
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
<%--                                <p class="test_time">--%>
<%--                                    <i class="glyphicon glyphicon-pencil">&#xe6fb;</i><b class="alt-1">${avaHour}:${avaMinute}</b>--%>
<%--                                </p>--%>
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
<script>

    //改变判分输入框
    $(document).on('change',"input[mtype='single'], input[mtype='multiple'], input[mtype='judge'], " +
        "input[mtype='blank'],input[mtype='short'] ",function () {
        var ids=$(this).attr("name");
        ids=ids.substring(5);
        var questionId=parseInt(ids);
        var score=$(this).val();
        var scoreNum=parseInt(score);
        alert(questionId+" "+scoreNum);
        submitAnswerJudge(questionId,scoreNum);
    });

    $(function () {
        //加载完页面就获取题目
        $.ajax({
            url:"${APP_PATH}/theAllProblemAndAnswer?paperId=${paperId}&studentId=${studentId}",
            type:"GET",
            success:function(result){
                //alert(radioProList.Problem[0].content+" "+mulProList+" "+judgeProList+" "+blankProList+" "+shortProList);
                buildRadioProList(result);buildAnswerSheet(result.extend.radioProList,0);
                buildMulProList(result);buildAnswerSheet(result.extend.mulProList,1);
                buildJudgeProList(result);buildAnswerSheet(result.extend.judgeProList,2);
                buildBlankProList(result);buildAnswerSheet(result.extend.blankProList,3);
                buildShortProList(result);buildAnswerSheet(result.extend.shortProList,4);
                // $(".alt-1").text(02+":"+60);
                computeTotalScore();//计算总分
            }
        });
    });
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
        var totalProNum=0;
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
            var optionA=$("<textarea class=\"input-textarea\" name=\"answer"+item.id+"\" id=\"4_answer_"+item.id+"_option_1\" disabled>"+lastAnswer+"</textarea>");
            blankAndShort.append(optionA);
            nr_main.append(blankAndShort);
            li1.append(nr_main);
            //增加答案信息
            li1.append($("<div class=\"test_content_nr_tt\"><span>正确答案是：</span>"+item.answer+"</div>"));
            li1.append($("<div class=\"test_content_nr_tt\"><span>答案解析是：</span>"+item.analysis+"</div>"));
            li1.append($("<div class=\"test_content_nr_tt\"><span>得分：</span>" +
                "<input type=\"text\" class=\"score-input\" name=\"score"+item.id+"\" id=\"0_score_"+item.id+"\" value=\""+item.userScore+"\" mtype=\"short\" disabled/></div>"));
            //li1.appendTo(".test_content_nr_ul_5");
            test_contetn_nr.append(li1);
            totalScore+=item.score;
            totalProNum++;
        });
        if(shortProList.length>0){
            var test_content=$("<div class='test_content'><div class='test_content_title'><h2>简答题</h2><p><span>共</span><i class='content_lit'>"+totalProNum+"</i>" +
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
        var totalProNum=0;
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
            var optionA=$("<input type=\"text\" class=\"form-control\" name=\"answer"+item.id+"\" id=\"3_answer_"+item.id+"_option_1\" value=\""+lastAnswer+"\" disabled/>");
            blankAndShort.append(optionA);
            nr_main.append(blankAndShort);
            li1.append(nr_main);
            //增加答案信息
            li1.append($("<div class=\"test_content_nr_tt\"><span>正确答案是：</span>"+item.answer+"</div>"));
            li1.append($("<div class=\"test_content_nr_tt\"><span>答案解析是：</span>"+item.analysis+"</div>"));
            li1.append($("<div class=\"test_content_nr_tt\"><span>得分：</span>" +
                "<input type=\"text\" class=\"score-input\" name=\"score"+item.id+"\" id=\"0_score_"+item.id+"\" value=\""+item.userScore+"\" mtype=\"blank\" disabled/></div>"));
            // li1.appendTo(".test_content_nr_ul_4");
            test_contetn_nr.append(li1);
            totalScore+=item.score;
            totalProNum++;
        });
        if(blankProList.length>0){
            var test_content=$("<div class='test_content'><div class='test_content_title'><h2>填空题</h2><p><span>共</span><i class='content_lit'>"+totalProNum+"</i>" +
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
        var totalProNum=0;
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
                var optionA=$("<li class=\"option\"><input type=\"radio\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"2_answer_"+item.id+"_option_1\" value=\"A\" checked disabled/>" +
                    "<label for=\"2_answer_"+item.id+"_option_1\"><p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[0].content+"</p></label></li>");
            else var optionA=$("<li class=\"option\"><input type=\"radio\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"2_answer_"+item.id+"_option_1\" value=\"A\" disabled/>" +
                "<label for=\"2_answer_"+item.id+"_option_1\"><p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[0].content+"</p></label></li>");
            if(B==true)
                var optionB=$("<li class=\"option\"><input type=\"radio\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"2_answer_"+item.id+"_option_2\" value=\"B\" checked disabled/>" +
                    "<label for=\"2_answer_"+item.id+"_option_2\"><p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[1].content+"</p></label></li>");
            else var optionB=$("<li class=\"option\"><input type=\"radio\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"2_answer_"+item.id+"_option_2\" value=\"B\" disabled/>" +
                "<label for=\"2_answer_"+item.id+"_option_2\"><p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[1].content+"</p></label></li>");
            ul.append(optionA).append(optionB);
            nr_main.append(ul);
            li1.append(nr_main);
            //增加答案信息
            li1.append($("<div class=\"test_content_nr_tt\"><span>正确答案是：</span>"+item.answer+"</div>"));
            li1.append($("<div class=\"test_content_nr_tt\"><span>答案解析是：</span>"+item.analysis+"</div>"));
            li1.append($("<div class=\"test_content_nr_tt\"><span>得分：</span>" +
                "<input type=\"text\" class=\"score-input\" name=\"score"+item.id+"\" id=\"0_score_"+item.id+"\" value=\""+item.userScore+"\" mtype=\"judge\" disabled/></div>"));
            // li1.appendTo(".test_content_nr_ul_3");
            test_contetn_nr.append(li1);
            totalScore+=item.score;
            totalProNum++;
        });
        if(judgeProList.length>0){
            var test_content=$("<div class='test_content'><div class='test_content_title'><h2>判断题</h2><p><span>共</span><i class='content_lit'>"+totalProNum+"</i>" +
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
        var totalProNum=0;
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
                var optionA=$("<li class=\"option\"><input type=\"checkbox\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"1_answer_"+item.id+"_option_1\" value=\"A\" checked disabled/>" +
                    "<label for=\"1_answer_"+item.id+"_option_1\">A. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[0].content+"</p></label></li>");
            else var optionA=$("<li class=\"option\"><input type=\"checkbox\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"1_answer_"+item.id+"_option_1\" value=\"A\" disabled/>" +
                "<label for=\"1_answer_"+item.id+"_option_1\">A. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[0].content+"</p></label></li>");
            if(B==true)
                var optionB=$("<li class=\"option\"><input type=\"checkbox\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"1_answer_"+item.id+"_option_2\" value=\"B\" checked disabled/>" +
                    "<label for=\"1_answer_"+item.id+"_option_2\">B. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[1].content+"</p></label></li>");
            else var optionB=$("<li class=\"option\"><input type=\"checkbox\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"1_answer_"+item.id+"_option_2\" value=\"B\" disabled/>" +
                "<label for=\"1_answer_"+item.id+"_option_2\">B. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[1].content+"</p></label></li>");
            if(C==true)
                var optionC=$("<li class=\"option\"><input type=\"checkbox\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"1_answer_"+item.id+"_option_3\" value=\"C\" checked disabled/>" +
                    "<label for=\"1_answer_"+item.id+"_option_3\">C. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[2].content+"</p></label></li>");
            else var optionC=$("<li class=\"option\"><input type=\"checkbox\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"1_answer_"+item.id+"_option_3\" value=\"C\" disabled/>" +
                "<label for=\"1_answer_"+item.id+"_option_3\">C. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[2].content+"</p></label></li>");
            if(D==true)
                var optionD=$("<li class=\"option\"><input type=\"checkbox\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"1_answer_"+item.id+"_option_4\" value=\"D\" checked disabled/>" +
                    "<label for=\"1_answer_"+item.id+"_option_4\">D. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[3].content+"</p></label></li>");
            else var optionD=$("<li class=\"option\"><input type=\"checkbox\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"1_answer_"+item.id+"_option_4\" value=\"D\" disabled/>" +
                "<label for=\"1_answer_"+item.id+"_option_4\">D. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[3].content+"</p></label></li>");
            ul.append(optionA).append(optionB).append(optionC).append(optionD);
            nr_main.append(ul);
            li1.append(nr_main);
            //增加答案信息
            li1.append($("<div class=\"test_content_nr_tt\"><span>正确答案是：</span>"+item.answer+"</div>"));
            li1.append($("<div class=\"test_content_nr_tt\"><span>答案解析是：</span>"+item.analysis+"</div>"));
            li1.append($("<div class=\"test_content_nr_tt\"><span>得分：</span>" +
                "<input type=\"text\" class=\"score-input\" name=\"score"+item.id+"\" id=\"0_score_"+item.id+"\" value=\""+item.userScore+"\" mtype=\"multiple\" disabled/></div>"));
            // li1.appendTo(".test_content_nr_ul_2");
            test_contetn_nr.append(li1);
            totalScore+=item.score;
            totalProNum++;
        });
        if(mulProList.length>0){
            var test_content=$("<div class='test_content'><div class='test_content_title'><h2>多选题</h2><p><span>共</span><i class='content_lit'>"+totalProNum+"</i>" +
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
        var totalProNum=0;
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
                var optionA=$("<li class=\"option\"><input type=\"radio\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"0_answer_"+item.id+"_option_1\" value=\"A\" checked disabled/>" +
                    "<label for=\"0_answer_"+item.id+"_option_1\">A. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[0].content+"</p></label></li>");
            else var optionA=$("<li class=\"option\"><input type=\"radio\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"0_answer_"+item.id+"_option_1\" value=\"A\" disabled/>" +
                "<label for=\"0_answer_"+item.id+"_option_1\">A. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[0].content+"</p></label></li>");
            if(B==true)
                var optionB=$("<li class=\"option\"><input type=\"radio\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"0_answer_"+item.id+"_option_1\" value=\"B\" checked disabled/>" +
                    "<label for=\"0_answer_"+item.id+"_option_1\">B. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[1].content+"</p></label></li>");
            else var optionB=$("<li class=\"option\"><input type=\"radio\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"0_answer_"+item.id+"_option_1\" value=\"B\" disabled/>" +
                "<label for=\"0_answer_"+item.id+"_option_1\">B. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[1].content+"</p></label></li>");
            if(C==true)
                var optionC=$("<li class=\"option\"><input type=\"radio\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"0_answer_"+item.id+"_option_1\" value=\"C\" checked disabled/>" +
                    "<label for=\"0_answer_"+item.id+"_option_1\">C. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[2].content+"</p></label></li>");
            else var optionC=$("<li class=\"option\"><input type=\"radio\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"0_answer_"+item.id+"_option_1\" value=\"C\" disabled/>" +
                "<label for=\"0_answer_"+item.id+"_option_1\">C. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[2].content+"</p></label></li>");
            if(D==true)
                var optionD=$("<li class=\"option\"><input type=\"radio\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"0_answer_"+item.id+"_option_1\" value=\"D\" checked disabled/>" +
                    "<label for=\"0_answer_"+item.id+"_option_1\">D. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[3].content+"</p></label></li>");
            else var optionD=$("<li class=\"option\"><input type=\"radio\" class=\"radioOrCheck\" name=\"answer"+item.id+"\" id=\"0_answer_"+item.id+"_option_1\" value=\"D\" disabled/>" +
                "<label for=\"0_answer_"+item.id+"_option_1\">D. <p class=\"ue\" style=\"display: inline;\">"+proItem.questionItemObjects[3].content+"</p></label></li>");
            ul.append(optionA).append(optionB).append(optionC).append(optionD);
            nr_main.append(ul);
            li1.append(nr_main);
            //增加答案信息
            li1.append($("<div class=\"test_content_nr_tt\"><span>正确答案是：</span>"+item.answer+"</div>"));
            li1.append($("<div class=\"test_content_nr_tt\"><span>答案解析是：</span>"+item.analysis+"</div>"));
            li1.append($("<div class=\"test_content_nr_tt\"><span>得分：</span>" +
                "<input type=\"text\" class=\"score-input\" name=\"score"+item.id+"\" id=\"0_score_"+item.id+"\" value=\""+item.userScore+"\" mtype=\"single\" disabled/></div>"));
            // li1.appendTo(".test_content_nr_ul_1");
            nr_ul.append(li1);
            totalScore+=item.score;
            totalProNum++;
        });
        if(radioProList.length>0){
            var test_content=$("<div class='test_content'><div class='test_content_title'><h2>单选题</h2><p><span>共</span><i class='content_lit'>"+totalProNum+"</i>" +
                "<span>题，</span><span>合计</span><i class='content_fs'>"+totalScore+"</i><span>分</span></p></div>");
            test_contetn_nr.append(nr_ul);
            $(".online_problem_main").append(test_content).append(test_contetn_nr);
        }
    }

</script>

<%--<div style="text-align:center;margin:50px 0; font:normal 14px/24px 'MicroSoft YaHei';">--%>
<%--    <p>适用浏览器：360、FireFox、Chrome、Safari、Opera、傲游、搜狗、世界之窗. 不支持IE8及以下浏览器。</p>--%>
<%--    <p>来源：<a href="http://sc.chinaz.com/" target="_blank">站长素材</a></p>--%>
<%--</div>--%>
</body>
</html>

