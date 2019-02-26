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
<title>报名列表</title>
<meta name="keywords" content="index">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="renderer" content="webkit">
<meta name="apple-mobile-web-app-title" content="Amaze UI" />
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
	<div class="am-g am-u-sm-12">
		<div style="margin-top: 20px;margin-bottom:10px;float:right;">
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
	
	<!-- 未报名考试表格 -->
	<div id="table" class="am-u-sm-12"
		style="margin-top: 10px;">
		<table></table>
	</div>
	<div style="clear: both;"></div>
	<!-- 尾 -->
	</main>

	<!--报名考试模态框-->
	<div class="am-modal am-modal-no-btn" tabindex="-1" id="apply_exam">
    	<div class="am-modal-dialog">
        	<div class="am-modal-hd">
          		报名信息<a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        	</div>
            <div style="min-height:50px;text-align: left;" class="content">
            	<div class="sun-div">考试名称：<span id="examName"></span></div>
            	<div class="sun-div">开始时间：<span id="start_time"></span></div>
            	<div class="sun-div">结束时间：<span id="end_time"></span></div>
            	<div class="sun-div">考试费用：<span id="feiyong"></span></div>
            	<div class="sun-div">
            		 支付方式：<select class="ex-select" id="pay_type">
                     	<option value="1">支付宝</option>
                     	<option value="2">微信支付</option>
                     	<option value="3">银行转账</option>
                     </select>
            	</div>
            </div>
            <div class="am-u-sm-12" style="padding:0;margin:0;border-top:1px solid #999;">
            	<p class="am-u-sm-6 ok" id="affirm_pay"  data-am-modal-close style="padding:0;margin:0;color:#3bb4f2;line-height:40px;text-align:center;font-size:14px;font-weight:bold;cursor:pointer;">确定</p>
            	<p class="am-u-sm-6 console"  data-am-modal-close style="padding:0;margin:0;border-left:1px solid #999;color:#3bb4f2;line-height:40px;text-align:center;font-size:14px;font-weight:bold;cursor:pointer;">取消</p>
            </div>
    	</div>
	</div>
	
	<!--确认报名模态框-->
	<div class="am-modal am-modal-no-btn" tabindex="-1" id="affirm_apply">
    	<div class="am-modal-dialog">
        	<div class="am-modal-hd">
          		<a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        	</div>
            <div style="min-height:50px;" class="content" id="affirm_info">
            	
            </div>
            <div class="am-u-sm-12" style="padding:0;margin:0;border-top:1px solid #999;">
            	<p class="am-u-sm-6 ok" id="ok_apply" data-am-modal-close style="padding:0;margin:0;color:#3bb4f2;line-height:40px;text-align:center;font-size:14px;font-weight:bold;cursor:pointer;">确定</p>
            	<p class="am-u-sm-6 console" data-am-modal-close style="padding:0;margin:0;border-left:1px solid #999;color:#3bb4f2;line-height:40px;text-align:center;font-size:14px;font-weight:bold;cursor:pointer;">取消</p>
            </div>
    	</div>
	</div>

	<script src="${pageContext.request.contextPath}/static/js/jquery/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/jquery/jquery-1.11.3.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/head.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/onlineexam.js"></script>
	<script	src="${pageContext.request.contextPath}/static/js/jquery.json-2.2.js"></script>
	<script	src="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/amazeui/amazeui.datatables.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/table/table.js"></script>
	
	<script src="../../static/js/examinee/date-switch.js"></script>
	<%--<script src="../../static/js/top.js"></script>--%>
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
				sWidth : "130px",
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
				sWidth : "130px",
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
				data : "is_connect",
				title : '续考',
				"render" : function(data, type, row) {
					var str = "";
					if (data == "1") {
						str += "是";
					}else{
						str += "否";
					}
					return str;
				}
			},
			{
				data : "is_charge",
				title : '是否收费',
				"visible" : false,
				defaultContent : ""
			},
			{
				data : "fee",
				title : '费用（元）',
				defaultContent : "无"
			},
			{
				data : "duration",
				title : '考试时长（分钟）',
				sWidth : "120px",
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
					var buttonHtml = "";
					buttonHtml += '<button type="button" class="am-btn am-btn-success am-radius am-btn-sm" onclick="apply_exam(\'' + row.id + '\')"><i class="am-icon-users"></i> 报名</button>';
					return buttonHtml;
				}
			}
		];
		var page = "pli"; //p代表页码   l 代表  每页显示多少条  i  代表 一共多少条，当前多少条	
		var url = "/exam/api/applyExamList?method=getlist";
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
		
		var exam_case_id;
		//报名按钮
		function apply_exam(id){
			exam_case_id = id;
			$.ajax({
				type : "POST",
				url : "<c:url value='/api/applyExamList/"+id+"?method=get'/>",
				//data : $.toJSON(reqSerObj), //将对象序列化成JSON字符串 
				dataType : "json",
				contentType : 'application/json;charset=utf-8', //设置请求头信息  
				success : function(data) {
					if(data.row.is_charge=="1"){
						$('#apply_exam').modal();//如果收费打开模态
						$('#examName').text(data.row.name);
						$('#start_time').text(getMyDate(data.row.starttime));
						$('#end_time').text(getMyDate(data.row.endtime));
						if(data.row.fee != null && data.row.fee != ""){
							$('#feiyong').text(data.row.fee+"（元）");
						}else{
							$('#feiyong').text("无费用");
						}
					}else{
						/* $("#affirm_info").text("你确定报名"+data.row.name+"吗？");
						$("#affirm_apply").modal(); */
						applyExam(id)
					}
				},
				error : function(res) {
					alert("信息获取失败！");
				}
			});
		}
		
		//确认付款
		$("#affirm_pay").click(function(){
			var pay_type = $("#pay_type option:selected").val();//支付方式
			var reqSerObj = {
				is_charge : "1",
				payment_method : pay_type,
				exam_case_id : exam_case_id
			};
			$.ajax({
				type : "POST",
				url : "<c:url value='/api/applyExamList?method=post'/>",
				data : $.toJSON(reqSerObj), //将对象序列化成JSON字符串 
				dataType : "json",
				contentType : 'application/json;charset=utf-8', //设置请求头信息  
				success : function(data) {
					if(data.result=="success"){
						alert("报名成功！");
						var exam_name = $('#exam_name').val();
						var exam_type = $("#type_select option:selected").val();
						var apply = {
							exam_name : exam_name,
							exam_type : exam_type
						};
						table.setParameters(apply);
						table.render();
					}
				},
				error : function(res) {
					alert("报名失败，请联系管理员！");
				}
			});
		});
		
		//确认按钮
		/* $("#ok_apply").click(function(){
			applyExam();
		}); */
		
		//确认报名
		function applyExam(id){
			var reqSerObj = {
				is_charge : "0",
				exam_case_id : id
			};
			$.ajax({
				type : "POST",
				url : "<c:url value='/api/applyExamList?method=post'/>",
				data : $.toJSON(reqSerObj), //将对象序列化成JSON字符串 
				dataType : "json",
				contentType : 'application/json;charset=utf-8', //设置请求头信息  
				success : function(data) {
					if(data.result=="success"){
						alert("报名成功！");
						var exam_name = $('#exam_name').val();
						var exam_type = $("#type_select option:selected").val();
						var apply = {
							exam_name : exam_name,
							exam_type : exam_type
						};
						table.setParameters(apply);
						table.render();
					}
				},
				error : function(res) {
					alert("报名失败，请联系管理员！");
				}
			});
		}
	</script>
</body>

</html>
