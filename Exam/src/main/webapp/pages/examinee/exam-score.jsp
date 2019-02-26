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
<title>考试成绩</title>
<meta name="keywords" content="index">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="renderer" content="webkit">
<meta name="apple-mobile-web-app-title" content="Amaze UI" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link
	href="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="../../static/css/examinee/static.css">
<link href="${pageContext.request.contextPath}/static/css/style.css"
	rel="stylesheet">
</head>

<body data-type="generalComponents">
<main>
	<div class="am-g am-u-sm-10 am-u-sm-offset-1 am-form-inline"
		style="text-align: left;margin-top: 10px">
		<button type="button" onclick="backList();"
			class="am-btn am-btn-primary am-btn-sm am-radius">
			<i class="am-icon-reply"></i> 返回
		</button>
	</div>
	<div class="header am-u-sm-10 am-u-sm-offset-1"
		style="margin-top: 20px;">2018全国企业员工全面质量绩效考试成绩</div>
	<div class="am-g am-u-sm-10 am-u-sm-offset-1 am-form-inline biao-ti">
		<div style="margin-top: 3px;margin-bottom: 3px;">
			<span class="round"> <a href="#a"><span class="shu-zi-y">1</span></a>
			</span> <span class="round"> <a href="#b"><span class="shu-zi-n">2</span></a>
			</span> <span class="round"> <a href="#c"><span class="shu-zi-y">3</span></a>
			</span> <span class="round"> <a href="#d"><span class="shu-zi-y">4</span></a>
			</span> <span class="round"> <a href="#e"><span class="shu-zi-y">5</span></a>
			</span> <span class="round"> <a href="#f"><span class="shu-zi-y">6</span></a>
			</span> <span class="round"> <a href="#g"><span class="shu-zi-n">7</span></a>
			</span>
		</div>
	</div>
	<div class="am-g am-u-sm-10 am-u-sm-offset-1 am-form-inline"
		style="margin-top: 10px;border:1px solid #ccc;height: 400px;overflow: auto;">
		<div class="am-form-inline" style="margin-left: 100px;">
			<ol style="margin-top: 10px;">
				<h3>一、基础知识</h3>
				<div style="margin-left: 50px;">
					<li id="a">关于项目质量描述下面哪项描述是正确的：
						<p class="correct-color">正确答案：选项二</p>
						<p>
							<label> <input type="radio" name="1">选项一
							</label>
						</p>
						<p>
							<label> <input type="radio" name="1" checked><span
								class="correct-color">选项二</span>
							</label>
						</p>
						<p>
							<label> <input type="radio" name="1">选项三
							</label>
						</p>
						<p>
							<label> <input type="radio" name="1">选项四
							</label>
						</p>
					</li>
					<li id="b">关于产品质量描述下面哪项描述是正确的：
						<p class="correct-color">正确答案：选项一</p>
						<p>
							<label> <input type="radio" name="2">选项一
							</label>
						</p>
						<p>
							<label> <input type="radio" name="2">选项二
							</label>
						</p>
						<p>
							<label> <input type="radio" name="2" checked><span
								class="error-color">选项三</span>
							</label>
						</p>
						<p>
							<label> <input type="radio" name="2">选项四
							</label>
						</p>
					</li>
					<li id="c">关于进度与质量关系描述下面哪些项描述是正确的：
						<p class="correct-color">正确答案：选项一、选项二</p>
						<p>
							<label> <input type="checkbox" checked><span
								class="correct-color">选项一</span>
							</label>
						</p>
						<p>
							<label> <input type="checkbox" checked><span
								class="correct-color">选项二</span>
							</label>
						</p>
						<p>
							<label> <input type="checkbox">选项三
							</label>
						</p>
						<p>
							<label> <input type="checkbox">选项四
							</label>
						</p>
					</li>
					<li id="d">关于进度与质量关系描述下面哪些项描述是正确的：
						<p class="correct-color">正确答案：选项一、选项三</p>
						<p>
							<label> <input type="checkbox" checked><span
								class="correct-color">选项一</span>
							</label>
						</p>
						<p>
							<label> <input type="checkbox">选项二
							</label>
						</p>
						<p>
							<label> <input type="checkbox" checked><span
								class="correct-color">选项三</span>
							</label>
						</p>
						<p>
							<label> <input type="checkbox">选项四
							</label>
						</p>
					</li>
					<li id="e">关于进度与质量关系描述下面哪些项描述是正确的：
						<p class="correct-color">正确答案：选项一、选项三、选项四</p>
						<p>
							<label> <input type="checkbox" checked><span
								class="correct-color">选项一</span>
							</label>
						</p>
						<p>
							<label> <input type="checkbox">选项二
							</label>
						</p>
						<p>
							<label> <input type="checkbox" checked><span
								class="correct-color">选项三</span>
							</label>
						</p>
						<p>
							<label> <input type="checkbox" checked><span
								class="correct-color">选项四</span>
							</label>
						</p>
					</li>
					<li id="f">关于进度与质量关系描述下面哪些项描述是正确的：
						<p class="correct-color">正确答案：选项三、选项四</p>
						<p>
							<label> <input type="checkbox">选项一
							</label>
						</p>
						<p>
							<label> <input type="checkbox">选项二
							</label>
						</p>
						<p>
							<label> <input type="checkbox" checked><span
								class="correct-color">选项三</span>
							</label>
						</p>
						<p>
							<label> <input type="checkbox" checked><span
								class="correct-color">选项四</span>
							</label>
						</p>
					</li>
					<li id="g">关于进度与质量关系描述下面哪些项描述是正确的：
						<p class="correct-color">正确答案：选项一、选项二</p>
						<p>
							<label> <input type="checkbox">选项一
							</label>
						</p>
						<p>
							<label> <input type="checkbox" checked><span
								class="error-color">选项二</span>
							</label>
						</p>
						<p>
							<label> <input type="checkbox" checked><span
								class="error-color">选项三</span>
							</label>
						</p>
						<p>
							<label> <input type="checkbox">选项四
							</label>
						</p>
					</li>
				</div>
				<h3>二、进阶知识</h3>
				<div style="margin-left: 50px;">
					<li id="a">关于项目质量描述下面哪项描述是正确的：
						<p class="correct-color">正确答案：选项二</p>
						<p>
							<label> <input type="radio" name="1">选项一
							</label>
						</p>
						<p>
							<label> <input type="radio" name="1" checked><span
								class="correct-color">选项二</span>
							</label>
						</p>
						<p>
							<label> <input type="radio" name="1">选项三
							</label>
						</p>
						<p>
							<label> <input type="radio" name="1">选项四
							</label>
						</p>
					</li>
					<li id="b">关于产品质量描述下面哪项描述是正确的：
						<p class="correct-color">正确答案：选项一</p>
						<p>
							<label> <input type="radio" name="2">选项一
							</label>
						</p>
						<p>
							<label> <input type="radio" name="2">选项二
							</label>
						</p>
						<p>
							<label> <input type="radio" name="2" checked><span
								class="error-color">选项三</span>
							</label>
						</p>
						<p>
							<label> <input type="radio" name="2">选项四
							</label>
						</p>
					</li>
					<li id="c">关于进度与质量关系描述下面哪些项描述是正确的：
						<p class="correct-color">正确答案：选项一、选项二</p>
						<p>
							<label> <input type="checkbox" checked><span
								class="correct-color">选项一</span>
							</label>
						</p>
						<p>
							<label> <input type="checkbox" checked><span
								class="correct-color">选项二</span>
							</label>
						</p>
						<p>
							<label> <input type="checkbox">选项三
							</label>
						</p>
						<p>
							<label> <input type="checkbox">选项四
							</label>
						</p>
					</li>
					<li id="d">关于进度与质量关系描述下面哪些项描述是正确的：
						<p class="correct-color">正确答案：选项一、选项三</p>
						<p>
							<label> <input type="checkbox" checked><span
								class="correct-color">选项一</span>
							</label>
						</p>
						<p>
							<label> <input type="checkbox">选项二
							</label>
						</p>
						<p>
							<label> <input type="checkbox" checked><span
								class="correct-color">选项三</span>
							</label>
						</p>
						<p>
							<label> <input type="checkbox">选项四
							</label>
						</p>
					</li>
					<li id="e">关于进度与质量关系描述下面哪些项描述是正确的：
						<p class="correct-color">正确答案：选项一、选项三、选项四</p>
						<p>
							<label> <input type="checkbox" checked><span
								class="correct-color">选项一</span>
							</label>
						</p>
						<p>
							<label> <input type="checkbox">选项二
							</label>
						</p>
						<p>
							<label> <input type="checkbox" checked><span
								class="correct-color">选项三</span>
							</label>
						</p>
						<p>
							<label> <input type="checkbox" checked><span
								class="correct-color">选项四</span>
							</label>
						</p>
					</li>
					<li id="f">关于进度与质量关系描述下面哪些项描述是正确的：
						<p class="correct-color">正确答案：选项三、选项四</p>
						<p>
							<label> <input type="checkbox">选项一
							</label>
						</p>
						<p>
							<label> <input type="checkbox">选项二
							</label>
						</p>
						<p>
							<label> <input type="checkbox" checked><span
								class="correct-color">选项三</span>
							</label>
						</p>
						<p>
							<label> <input type="checkbox" checked><span
								class="correct-color">选项四</span>
							</label>
						</p>
					</li>
					<li id="g">关于进度与质量关系描述下面哪些项描述是正确的：
						<p class="correct-color">正确答案：选项一、选项二</p>
						<p>
							<label> <input type="checkbox">选项一
							</label>
						</p>
						<p>
							<label> <input type="checkbox" checked><span
								class="error-color">选项二</span>
							</label>
						</p>
						<p>
							<label> <input type="checkbox" checked><span
								class="error-color">选项三</span>
							</label>
						</p>
						<p>
							<label> <input type="checkbox">选项四
							</label>
						</p>
					</li>
				</div>
			</ol>
		</div>
	</div>

</main>
	<script
		src="${pageContext.request.contextPath}/static/js/jquery/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/static/js/jquery/jquery-1.11.3.js"></script>
		<script src="${pageContext.request.contextPath}/static/js/head.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/onlineexam.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/jquery.json-2.2.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.js"></script>
	<script>
		function backList() {
			window.location.href = "../examinee/exam-history.jsp";
		}
	
		$(function() {
			$(".down").css("background-color","rgba(255,255,255,0.3)")
			$('input[type="checkbox"]').attr('disabled', true);
			$('input[type="radio"]').attr('disabled', true);
		})
	</script>
</body>

</html>
