<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>CAQ在线考试管理后台</title>
		
		<link href="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/static/css/table.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/static/css/style.css"
	rel="stylesheet">
	</head>
	<body>
	<main>
	<div >
		<div class="am-u-sm-2">
			<div class="tpl-left-nav tpl-left-nav-hover" style="margin-left: 10px;margin-top: 25px;">
			    <div class="tpl-left-nav-title">
			        	功能菜单
			    </div>
				<div class="tpl-left-nav-list">
					<ul class="tpl-left-nav-menu">
						<li class="tpl-left-nav-item">
		                        <a href="javascript:void(0)" class="nav-link">
		                            <i class="am-icon-home"></i>
		                            <span>首页</span>
		                        </a>
		                    </li>
						<li class="tpl-left-nav-item">
							<a href="javascript:void(0)" class="nav-link tpl-left-nav-link-list">
							    <i class="am-icon-database"></i>
							    <span>题库管理</span>
							    <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
							</a>
							<ul class="tpl-left-nav-sub-menu">
							    <li>
							        <a href="javascript:void(0)">
							            <i class="am-icon-angle-right"></i>
							            <span>创建题库</span>
							        </a>
							        <a href="javascript:void(0)">
							            <i class="am-icon-angle-right"></i>
							            <span>管理题库</span>
							        </a>
							        <a href="javascript:void(0)">
							            <i class="am-icon-angle-right"></i>
							            <span>创建试题</span>
							        </a>
							        <a href="javascript:void(0)">
							            <i class="am-icon-angle-right"></i>
							            <span>管理试题</span>
							        </a>
							        <a href="javascript:void(0)">
							            <i class="am-icon-angle-right"></i>
							            <span>批量导入试题</span>
							        </a>
							    </li>
							</ul>
						</li>
						<li class="tpl-left-nav-item">
							 <!-- 打开状态 a 标签添加 active 即可   -->
		                    <a href="javascript:void(0)" class="nav-link tpl-left-nav-link-list">
		                        <i class="am-icon-file-text"></i>
		                        <span>试卷管理</span>
		                        <!-- 列表打开状态的i标签添加 tpl-left-nav-more-ico-rotate 图表即90°旋转  -->
		                        <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
		                    </a>
		                    <ul class="tpl-left-nav-sub-menu">
		                    	<li>
			                    	<!-- 设置打开状态 a标签添加 active 即可   -->
			                    	<a href="javascript:void(0)">
			                            <i class="am-icon-angle-right"></i>
			                            <span>管理试卷</span>
			                        </a>
			                        <a href="javascript:void(0)">
			                            <i class="am-icon-angle-right"></i>
			                            <span>创建试卷</span>
			                        </a>
			                        <a href="javascript:void(0)">
			                            <i class="am-icon-angle-right"></i>
			                            <span>自动组卷</span>
			                        </a>
			                    </li>
		                    </ul>
						</li>
						<li class="tpl-left-nav-item">
							 <!-- 打开状态 a 标签添加 active 即可   -->
		                    <a href="javascript:;" class="nav-link tpl-left-nav-link-list">
		                        <i class="am-icon-pencil-square-o"></i>
		                        <span>考试管理</span>
		                        <!-- 列表打开状态的i标签添加 tpl-left-nav-more-ico-rotate 图表即90°旋转  -->
		                        <i class="am-icon-angle-right tpl-left-nav-more-ico am-fr am-margin-right"></i>
		                    </a>
						</li>
						<li class="tpl-left-nav-item">
		                    <a href="javascript:void(0)" class="nav-link tpl-left-nav-link-list">
		                        <i class="am-icon-bar-chart"></i>
		                        <span>统计分析</span>
		                    </a>
		                </li>
					</ul>
				</div>
			</div>
		</div>
		
		<div class="am-u-sm-10" style="padding-right: 0rem;">
			
			<div >
				<iframe src="../question/questionbanklist.jsp" id="mainframe" class="am-u-sm-12" class="iframe" scrolling="no" style="padding-top:2rem;padding-left: 2rem;padding-right: 0rem;"></iframe>
			</div>
		</div>
	</div>	
	</main>
	</body>
	<script src="${pageContext.request.contextPath}/static/js/jquery/jquery-1.11.3.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/onlineexam.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/head.js"></script>
    <script>
    $(function(){
    	$(".down").css("background-color","rgba(255,255,255,0.3)")
    })
    </script>
</html>