<%--
  Created by IntelliJ IDEA.
  User: Sunguowei
  Date: 2018/8/27
  Time: 11:00
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <title>标题</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <script src="${pageContext.request.contextPath}/static/js/jquery/jquery-1.11.3.js"></script>
    <script src="/exam/static/js/examinee/jquery.jsonp.js"></script>
    <script>
        $(function () {
            $("#tijiao").click(function(){
                $.ajax({
                    url:"http://127.0.0.1:8080/exam/jsonpTest",
                    method:"GET",
                    dataType:"jsonp",
                    data:{"name":"zhangsan"},
                    jsonp:"callback",//指定回调参数名
                    jsonpCallback:"callbackAction",//回调方法名
                    success:function(data){
                        console.log(data)
                    },
                    error:function(data){
                        console.log(2)
                    }
                });
            });
        });
    </script>
</head>
<body>
    <input type="button" value="提交" id="tijiao">
</body>
</html>
