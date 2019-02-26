<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>考试列表</title>
<meta name="keywords" content="index">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="renderer" content="webkit">
<meta name="apple-mobile-web-app-title" content="Amaze UI" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link href="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/table.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/style.css" rel="stylesheet">
<link rel="stylesheet" href="../../static/css/examinee/static.css">
<style type="text/css">
.table .am-pagination {
	left: 43%;
}
</style>
</head>

<body data-type="generalComponents">
	<!-- 头 -->
	<main>
	<div class="am-g am-u-sm-12 am-form-inline">
		<div style="margin-top: 20px;margin-bottom:20px;float:right">
			考试类型：<select class="ex-select" id="type_select">
				<option value="">选择考试类型</option>
				<option value="在线考试">在线考试</option>
				<option value="模拟考试">模拟考试</option>
				<option value="知识竞赛">知识竞赛</option>
				<option value="自测">自测</option>
			</select> 
			&nbsp;&nbsp;&nbsp; 
			考试名称：<input type="text" class="input" placeholder="考试名称" id="exam_name"> 
			&nbsp;&nbsp;&nbsp;
			<button type="button"
				class="am-btn am-btn-primary am-radius am-btn-sm" id="search_exam">
				<i class="am-icon-search"></i> 查询
			</button>
			<button type="button"
				class="am-btn am-btn-primary am-radius am-btn-sm" id="reset">
				<i class="am-icon-undo"></i> 重置
			</button>
		</div>
	</div>
	<!-- 已报名未考试表格 -->
	<div id="table" class="am-u-sm-12"
		style="margin-top: 10px;">
		<table></table>
	</div>
	<!-- 清除浮动 -->
	<div style="clear: both;"></div>
	<!-- 尾 -->
	</main>

	<script src="${pageContext.request.contextPath}/static/js/jquery/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/jquery/jquery-1.11.3.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/head.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/onlineexam.js"></script>
	<script	src="${pageContext.request.contextPath}/static/js/jquery.json-2.2.js"></script>
	<script	src="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/amazeui/amazeui.datatables.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/table/table.js"></script>
	<script src="../../static/js/examinee/date-switch.js"></script>
	
	<script src="../../static/js/top.js"></script>
	<script>
	$(function(){
		$(".down").css("background-color","rgba(255,255,255,0.3)")
	})
		var arr = [
			{
				data : "id",
				title : '考试实例ID',
				"visible" : false
			},
			{
				data : "name",
				title : '考试名称',
			},
			{
				data : "exam_type",
				title : '考试类型',
			},
			{
				data : "starttime",
				title : '开始时间',
				"render" : function(data, type, row) {
					var str = "";
					if (data != null && data != '') {
						str = getMyDate(data);
					}
					return str;
				}
			},
			{
				data : "endtime",
				title : '结束时间',
				"render" : function(data, type, row) {
					var str = "";
					if (data != null && data != '') {
						str = getMyDate(data);
					}
					return str;
				}
			},
			{
				data : "duration",
				title : '考试时长（分钟）',
				defaultContent : ""
			},
			{
				data : "sorce_line",
				title : '分数线',
				defaultContent : ""
			},
			{
				data : null,
				title : "操作",
				sWidth : "75px",
				"render" : function(data, type, row) {
					//console.log(row)
					var nowdate = new Date();
					var buttonHtml = "";
					if(nowdate >= row.starttime && nowdate <= row.endtime){	
						buttonHtml += '<button  class="revise table_btn start_exam" onclick="startExam(\'' + row.id + '\')" value="开始考试" style="float:left;margin-right:5px;margin-left:5px;"></button>';
					}else{
						buttonHtml += '<button  class="revise table_btn start_exam" onclick="startExam(\'' + row.id + '\')" value="开始考试" style="float:left;margin-right:5px;margin-left:5px;"></button>';
						//buttonHtml += '<button  class="revise table_btn start_exam" value="考试结束" style="float:left;margin-right:5px;margin-left:5px;color: #FFFFFF;"></button>';
					}
					return buttonHtml;
				}
			}
		];
		var page = "pli"; //p代表页码   l 代表  每页显示多少条  i  代表 一共多少条，当前多少条	
		var url = "/exam/api/examList?method=getlist";
		var apply = {
			exam_name : "",
			exam_type : ""
		};
		var table = new DataGrid($('#table'), page, url, arr);
		table.setParameters(apply);
		//table.setButtonEven(".look_score", "#revise-contents");
		table.render();
		
		//查询按钮
		$('#search_exam').click(function(){
			var exam_name = $('#exam_name').val();
			var exam_type = $("#type_select option:selected").val();
			var apply = {
				exam_name : exam_name,
				exam_type : exam_type
			};
			table.setParameters(apply);
			table.render();
		});
		
		//重置按钮
		$('#reset').click(function(){
			//选中下拉列表默认项
			$("#type_select").val("");
			//清空输入框
			$("#exam_name").val("");
		});
		
		//开始开始按钮
		function startExam(id){
			//alert(id)
			window.location.href = "../examinee/exam-paper.jsp?id="+id+"";
		}
	</script>
</body>

</html>
