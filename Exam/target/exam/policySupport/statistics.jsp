<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>决策支持</title>
<meta id="viewport" name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta HTTP-EQUIV="pragma" CONTENT="no-cache">  
<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">  
<meta HTTP-EQUIV="expires" CONTENT="0">  

<link href="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.css" rel="stylesheet">
<style>
li{list-style:none;}
body{background:#f2f2f2;color:#333;font-family:"DFKai-SB";}
div,ul,li,p,span,a{margin:0;padding:0;}
img{width:15px;height:15px;float:left;margin-top:15px;margin-right:10px;}
.head{width:100%;height:45px;line-height:45px;padding-left:30px;font-size:14px;font-weight:bold;}
ul{background:#fff;}
ul li{color:#333;font-size:14px;width:100%;
height:45px;line-height:45px;padding:0 15px;border-bottom:1px solid #f2f2f2;}
ul li span{float:right;}
</style>

</head>
<body>
<div class="wrap">
	<p class="head">人力资源</p>
	<ul>
		<li class="statistics" val="../attendancestatistics/attendancestatistics.jsp">
    		<img src="${pageContext.request.contextPath}/static/images/count.jpg">
      		 考勤统计
    		<span> 〉 </span>
		</li>
	</ul>
	<p class="head">评审评选</p>
	<ul>
		<li class="statistics" val="../../dss/statistics/statisticsRs.html">
	    	<img src="${pageContext.request.contextPath}/static/images/match.jpg">
	      	活动统计
	   		<span> 〉 </span>
		</li>
	</ul>
	<p class="head">财务管理</p>
	<ul>
		<li class="statistics" val="../../dss/statistics/statisticsBudget.html">
		    <img src="${pageContext.request.contextPath}/static/images/budget.jpg">
		            预算统计
		    <span> 〉 </span>
		</li>
	</ul>
	<p class="head">项目管理</p>
	<ul>
		<li class="statistics" val="../../dss/statistics/statisticsPs.html">
		    <img src="${pageContext.request.contextPath}/static/images/project.jpg">
		            项目统计
		    <span> 〉 </span>
		</li>
	</ul>
</div>

<div style="margin-top:45rem;">
	<a href="../index/index_test.jsp?rx_token=<%=request.getParameter("rx_token")%>"><font style="color:#f2f2f2">测试环境</font></a>
</div>

<script src="<c:url value='/static/js/jquery/jquery.min.js'/>"></script>
<script>
$(function(){
	$(".statistics").click(function(){
		var rx_token="<%=request.getParameter("rx_token")%>";
		window.location.href=$(this).attr("val")+"?rx_token="+rx_token;
	})
})
</script>
</body>
</html>