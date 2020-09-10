<%--
  Created by IntelliJ IDEA.
  User: 浩瀚
  Date: 2020/8/9
  Time: 11:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%
        //这个的路径是以斜线开始的，不以斜线结束
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
</head>
<script type="text/javascript" src="${APP_PATH}/statics/bootstrapValidator/vendor/jquery/jquery-1.10.2.min.js"></script>
<body>
    <button>按钮</button>
<script>
    $('button').click(function () {
        <%--$.ajax({--%>
        <%--    cache: false,--%>
        <%--    url:"${APP_PATH}/testJson",--%>
        <%--    type:"POST",--%>
        <%--    async:false,--%>
        <%--    success:function (data) {--%>
        <%--        //var jsonobj=eval("("+data+")");--%>
        <%--        alert(data.concreteItem[0].questionItemObjects[0].content);--%>
        <%--    }--%>
        <%--});--%>

        //testJson
        <%--var jsonData=${jsonData};--%>
        <%--alert(jsonData.concreteItem[0].questionItemObjects[0].content);//.concreteItem[0].questionItemObjects[0].content--%>

        //testJson1
        var jsonData=${content};
        alert(jsonData);
        alert(jsonData.analyze);
    });
</script>
</body>
</html>
