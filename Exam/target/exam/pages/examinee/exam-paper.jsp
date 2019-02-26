<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>试卷</title>
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link href="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../../static/css/examinee/static.css">
    <%-- <link rel="stylesheet" href="../../static/css/login/login.css">--%>
    <%--<link href="${pageContext.request.contextPath}/static/css/style.css" rel="stylesheet">--%>
    <style type="text/css">
        body span, label {
            font-size: 14px;
        }
        img{
            /*width:400px;*/
            border:black 1px solid;
        }
        #image{
            position: absolute;
            display: none;
        }
        html,body,main{
            height: 100%;
            margin: 0px;
            padding: 0px;
        }
    </style>
</head>

<%--禁用选中、鼠标右键功能--%>
<body data-type="generalComponents" onselectstart="return false" oncontextmenu="return false">
<!-- 头 -->
<main>
    <div class="am-g am-u-sm-12 am-form-inline"
         style="text-align: left;margin-top: 10px">
        <button type="button" onclick="backList();" id="go_back"
                class="am-btn am-btn-primary am-btn-sm am-radius">
            <i class="am-icon-reply"></i> 返回
        </button>
    </div>
    <div class="header am-u-sm-12" style="margin-top: 10px;" id="title"></div>
    <div class="am-g am-u-sm-12" style="margin-top: 10px;">
        <div class="am-fl" style="width: auto;">
            <label>剩余时间：<span style="color: red;font-size: 16px;" id="timer"></span>（请注意答题时间，答题时间结束后将自动提交！）</label>
        </div>
        <div id="timeContent"></div>
    </div>
    <input type="hidden" id="paper_case_id">
    <input type="hidden" id="answer_paper_id">
    <!-- <div class="am-g am-u-sm-12 am-form-inline biao-ti">
        <div style="margin-top: 3px;margin-bottom: 3px;" id="tihao">

        </div>
    </div> -->
    <div style="clear: both;"></div>
    <div id="kaoti" class="am-g  am-form-inline" style="margin-top: 10px;border:2px solid #ccc;width: 98%;height: 75%;overflow-y: auto;">
        <div class="am-form-inline" style="margin-left: 30px;">
            <ol style="margin-top: 10px;" id="exam_paper_content">

            </ol>
        </div>
    </div>

    <!--动态显示的图片-->
    <div >
        <img id="image">
    </div>

    <div class="am-g am-u-sm-12 am-form-inline"
         style="text-align: center;margin-top: 10px;margin-bottom: 10px;">
        <button type="button"
                class="am-btn am-btn-primary am-radius am-btn-sm" id="submit">
            <i class="am-icon-check"></i> 提交
        </button>
        &nbsp;&nbsp;&nbsp;
        <button type="button"
                class="am-btn am-btn-primary am-radius am-btn-sm" id="save">
            <i class="am-icon-save"></i> 保存
        </button>
    </div>
    <!-- 清除浮动 -->
    <div style="clear: both;"></div>
    <!-- 尾 -->
</main>


<!--确认提交模态框-->
<div class="am-modal am-modal-no-btn" tabindex="-1" id="affirm_modal">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">
            提 示<a href="javascript: void(0)" class="am-close am-close-spin"
                  data-am-modal-close>&times;</a>
        </div>
        <div style="min-height:50px;margin-top: 10px;" class="msg_content" id="msg_content">

        </div>
        <div class="am-u-sm-12" style="padding:0;margin:0;border-top:1px solid #999;">
            <p class="am-u-sm-6 ok" id="ok_submit" data-am-modal-close
               style="padding:0;margin:0;color:#3bb4f2;line-height:40px;text-align:center;font-size:14px;font-weight:bold;cursor:pointer;">
                确定</p>
            <p class="am-u-sm-6 console" data-am-modal-close
               style="padding:0;margin:0;border-left:1px solid #999;color:#3bb4f2;line-height:40px;text-align:center;font-size:14px;font-weight:bold;cursor:pointer;">
                取消</p>
        </div>
    </div>
</div>

<div class="am-modal am-modal-alert" tabindex="-1" id="login-modal">
    <div class="am-modal-dialog" style="background:white;width:400px;height:400px">
        <div class="am-modal-hd" style="padding: 10px 10px 5px 10px;">
            <a href="javascript:void(0)" class="am-close am-close-spin" data-am-modal-close="">×</a>
        </div>
        <div class="am-modal-bd" style="border:none;font-size: 14px;height:400px;padding: 15px 5px;">
            <div class="in_log" style="-webkit-box-shadow: none;">
                <ul class="panel1">
                    <li style="padding: 0px">
                        <div class="tit_log" style="text-align: left;">
                            <h3>登录</h3>
                        </div>
                    </li>
                    <li><input class="in_user user_a" type="text" placeholder="证件号码" autocomplete="off" value=""></li>
                    <li><input class="in_mm pass_a" type="password" placeholder="准考证号" autocomplete="off" value=""></li>
                    <li class="ff"><div class="error_a" style="color: red;font-size: 12px;text-align: left;"></div></li>
                    <li><input onclick="submitOk_a();" type="button" class="login_ok" value="登    录"></li>
                </ul>
            </div>
        </div>
    </div>
</div>


<script src="${pageContext.request.contextPath}/static/js/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/jquery/jquery-1.7.1.min.js"></script>
<%--<script src="${pageContext.request.contextPath}/static/js/head.js"></script>--%>
<script src="${pageContext.request.contextPath}/static/js/onlineexam.js"></script>
<script src="${pageContext.request.contextPath}/static/js/jquery.json-2.2.js"></script>
<script src="../../static/js/examinee/json2.js"></script>
<script src="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.js"></script>
<script src="../../static/js/examinee/exam-paper.js"></script>
<script src="../../static/js/examinee/count-down.js"></script>
<script src="../../static/js/examinee/exam-paper-content.js"></script>
<script src="../../static/js/login/login.js"></script>

<script>

    var url = window.location.href;
    var con = url.split("?")[1];
    var exam_id = con.split("&")[0].split("=")[1]; //考试ID

</script>
</body>

</html>
