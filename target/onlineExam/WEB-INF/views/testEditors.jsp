<%--
  Created by IntelliJ IDEA.
  User: 浩瀚
  Date: 2020/8/20
  Time: 12:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        //这个的路径是以斜线开始的，不以斜线结束
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <title>Title</title>
    <script src="${APP_PATH}/statics/online/js/jquery-1.11.3.min.js"></script>
    <script src="${APP_PATH}/statics/ckeditor/adapters/jquery.js"></script>
    <script src="${APP_PATH}/statics/ckeditor/ckeditor.js"></script>
</head>
<body>
    <div id="test">
<%--        <textarea id="testCkeditor">--%>

<%--        </textarea>--%>
    </div>
<script>
    $(function(){
        $("#test").append("<div>nihao</div>");
        $("#test").append("<textarea id='testCkeditor'></textarea>");
        CKEDITOR.replace( 'testCkeditor',{
            height:100,
            width:1000
        });
    });

</script>
</body>
</html>
