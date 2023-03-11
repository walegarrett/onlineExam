<%--
  Created by IntelliJ IDEA.
  User: 浩瀚
  Date: 2020/8/8
  Time: 20:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta charset="utf-8">
    <%
        //这个的路径是以斜线开始的，不以斜线结束
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <title>增加题目</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${APP_PATH}/statics/layuimini/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="${APP_PATH}/statics/layuimini/css/public.css" media="all">
    <style>
        body {
            background-color: #ffffff;
        }
    </style>
</head>
<body>
<div class="layui-form layuimini-form">
    <div class="layui-form-item">
        <label class="layui-form-label">题型</label>
        <div class="layui-input-block">
            <select name="type" lay-filter="type">
                <option value=""></option>
                <option value=1 selected="">单选</option>
                <option value=2>多选</option>
                <option value=3>判断</option>
                <option value=4>填空</option>
                <option value=5>简答</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">题干</label>
        <div class="layui-input-block">
            <input type="text" name="titleContent" lay-verify="required|content" lay-reqtext="题干不能为空" placeholder="请输入题干名称" value="" class="layui-input">
            <tip>填写题干</tip>
        </div>
    </div>
    <div class="layui-form-item" id="sigAndMulOpts">
        <label class="layui-form-label required">选项</label>
        <div class="layui-input-block" style="margin-left:60px!important;">
            <div class="layui-form-item">
                <label class="layui-form-label">A: </label>
                <div class="layui-input-block">
                    <input type="text" name="optionsA" value="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">B: </label>
                <div class="layui-input-block">
                    <input type="text" name="optionsB" value="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">C: </label>
                <div class="layui-input-block">
                    <input type="text" name="optionsC" value="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">D: </label>
                <div class="layui-input-block">
                    <input type="text" name="optionsD" value="" class="layui-input">
                </div>
            </div>
        </div>
    </div>
    <div class="layui-form-item" id="judgeOpts" style="display: none">
        <label class="layui-form-label required">选项</label>
        <div class="layui-input-block" style="margin-left:60px!important;">
            <div class="layui-form-item">
                <label class="layui-form-label">A: </label>
                <div class="layui-input-block">
                    <input type="text" name="judgeA" value="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">B: </label>
                <div class="layui-input-block">
                    <input type="text" name="judgeB" value="" class="layui-input">
                </div>
            </div>
        </div>
    </div>
    <div class="layui-form-item" id="singAns">
        <label class="layui-form-label required">答案</label>
        <div class="layui-input-block">
            <input type="radio" name="sinAns" value="A" title="A" checked="">
            <input type="radio" name="sinAns" value="B" title="B">
            <input type="radio" name="sinAns" value="C" title="C">
            <input type="radio" name="sinAns" value="D" title="D">
        </div>
    </div>
    <div class="layui-form-item" id="mulAns" style="display: none">
        <label class="layui-form-label required">答案</label>
        <div class="layui-input-block">
            <input type="checkbox" name="mulAns" value="A" title="A">
            <input type="checkbox" name="mulAns" value="B" title="B">
            <input type="checkbox" name="mulAns" value="C" title="C">
            <input type="checkbox" name="mulAns" value="D" title="D">
        </div>
    </div>
    <div class="layui-form-item" id="judAns" style="display: none">
        <label class="layui-form-label required">答案</label>
        <div class="layui-input-block">
            <input type="radio" name="judgeAns" value="A" title="A" checked="">
            <input type="radio" name="judgeAns" value="B" title="B">
        </div>
    </div>
    <div class="layui-form-item" id="ordAns" style="display: none">
        <label class="layui-form-label required">答案</label>
        <div class="layui-input-block">
            <input type="text" name="ordiAns" class="layui-input" lay-verify="content">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">分值</label>
        <div class="layui-input-block">
            <input type="number" name="score" lay-verify="required|number" lay-reqtext="分值不能为空" placeholder="请输入分值" value="" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">解析</label>
        <div class="layui-input-block">
            <input type="text" name="analysis" lay-verify="required|content" value="" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认创建</button>
        </div>
    </div>
</div>
<%--<script type="text/javascript" src="${APP_PATH}/statics/bootstrapValidator/vendor/jquery/jquery-1.10.2.min.js"></script>--%>
<script src="${APP_PATH}/statics/layuimini/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>

    layui.use(['jquery','layer','form'], function () {
        var form = layui.form,
            layer = layui.layer;
            $ = layui.$;
        // 验证
        form.verify({
            content: function (value) {
                if (value.length>200) {
                    return "输入的内容过长，请减少字数！！！";
                }
            }
        });
        form.on('select(type)', function(data){
            var value=data.value;
            if(value==1){//单选
                $("#singAns").show();
                $("#sigAndMulOpts").show();
                $("#mulAns").hide();
                $("#judAns").hide();
                $("#judgeOpts").hide();
                $("#ordAns").hide();
            }else if(value==2){//多选
                $("#singAns").hide();
                $("#sigAndMulOpts").show();
                $("#mulAns").show();
                $("#judAns").hide();
                $("#judgeOpts").hide();
                $("#ordAns").hide();
            }else if(value==3){//判断题
                $("#singAns").hide();
                $("#sigAndMulOpts").hide();
                $("#mulAns").hide();
                $("#judAns").show();
                $("#judgeOpts").show();
                $("#ordAns").hide();
            }else if(value==4||value==5){//填空
                $("#singAns").hide();
                $("#sigAndMulOpts").hide();
                $("#mulAns").hide();
                $("#judAns").hide();
                $("#judgeOpts").hide();
                $("#ordAns").show();
            }
        });

        //加载页面时初始化
        $(function () {

        });
        //监听提交
        form.on('submit(saveBtn)', function (data) {
            data=data.field;
            var ans="";
            if($("#ordAns").is(":hidden")){
                if($("#mulAns").is(":hidden")){
                    if($("#judAns").is(":hidden")){
                        ans=$('input[name="sinAns"]:checked').val();
                    }
                    else{
                        ans=$('input[name="judgeAns"]:checked').val();
                    }
                    // alert(ans);
                }else{
                    var chk_value =[];//定义一个数组
                    var ind=0;
                    $('input[name="mulAns"]:checked').each(function(){//遍历每一个名字为interest的复选框，其中选中的执行函数
                        if(ind!=0)
                            ans+=",";
                        ind++;
                        ans+=$(this).val();
                    });
                    if(ind==0){
                        layer.msg('您还未选择复选框',{
                            time: 10000
                        });
                        return false;
                    }
                }
            }else{
                    ans=data.ordiAns;
                    if(ans.length<=0||ans.length>1000){
                        layer.msg('标准答案的长度不为空且字数必须在1-1000之内！');
                        return false;
                    }
            }
            //alert(ans);
            var optionA="",optionB="",optionC="",optionD="";
            if($("#sigAndMulOpts").is(":visible")){
                optionA=data.optionsA;
                optionB=data.optionsB;
                optionC=data.optionsC;
                optionD=data.optionsD;
                if(optionA.length<=0||optionA.length>50||optionB.length<=0||optionB.length>50||optionC.length<=0||optionC.length>50||optionD.length<=0||optionD.length>50){
                    layer.msg('选项的长度不为空且字数必须在1-50之内！');
                    return false;
                }
            }else if($("#judgeOpts").is(":visible")){
                optionA=data.judgeA;
                optionB=data.judgeB;
                if(optionA.length<=0||optionA.length>50||optionB.length<=0||optionB.length>50){
                    layer.msg('选项的长度不为空且字数必须在1-50之内！');
                    return false;
                }
            }
            var type=data.type;
            // alert(type+" "+optionA+" "+optionB);
            // return false;/////////////////测试
            var datas={
                "teacherId":${userid},//
                "titleContent":data.titleContent,
                "answer":ans,
                "score":data.score,
                "type":data.type,
                "analysis":data.analysis,
                "optionA":optionA,
                "optionB":optionB,
                "optionC":optionC,
                "optionD":optionD
            };
            $.ajax({
                cache: false,
                url:"${APP_PATH}/addProblem",
                type:"POST",
                async:false,
                data:datas,
                success:function (result) {
                    if(result.code==200){
                        //执行有错误时候的判断
                        layer.msg('新建题目失败！！！！');
                    }else{
                        layer.msg('新建题目成功');
                        var iframeIndex = parent.layer.getFrameIndex(window.name);
                        parent.layer.close(iframeIndex);
                    }
                }
            });

            return false;
        });

    });
</script>
</body>
</html>
