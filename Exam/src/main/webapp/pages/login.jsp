<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>登录</title>
    <link href="../static/css/login/login.css" rel="stylesheet" type="text/css">
    <link href="../static/css/login/loading.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="../static/js/jquery/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="../static/js/jquery.json-2.2.js"></script>
</head>
<body style="background-color: #fff ">
<div style="background-color: #fff">
    <div style="height: 110px;width: 100%;">
        <div style="width: 1170px;margin: 0 auto;">
            <div style="padding-top: 30px">
                <img src="../static/images/logo_login.png">
            </div>
        </div>
    </div>
    <div class="loginbox">
        <div class="loginbox_c">
            <div class="in_log">
                <!-- 登录 -->
                <ul class="panel1">
                    <li style="padding: 0px"><div class="tit_log"><h3>登录</h3><%--<a href="javascript:void(0)" class="flip1" style="color: #0061b0">注册</a>--%></div></li>
                    <li><input class="in_user user_a" type="text" placeholder="用户名/手机号/邮箱" autocomplete="off" value=""></li>
                    <li><input class="in_mm pass_a" type="password" placeholder="密码" autocomplete="off" value=""></li>
                   <%-- <li>
                        <input class="in_login w130 fl tpyzm_a" type="text" placeholder="图片验证码" size="10" value="">
                        <a href="javascript:void(0)" onclick="javascript:document.getElementById('codeimage_a').src='/member/img/code?' + Math.random();">
                            <img src="/member/img/code" title="看不清？换一张" border="0" id="codeimage_a" style="width:120px;height:39px;" class="yzm fl">
                        </a>
                    </li>--%>
                    <li class="ff">
                        <%--<a href="javascript:alert('如果该账号已绑定手机或邮箱，\n请使用验证码登录后到个人中心修改密码;\n如未绑定请联系系统管理员！')" class="fr" style="color:#0061b0;">忘记密码？</a>--%>
                        <div class="error_a" style="color: red;font-size: 12px;margin-left: 10px"></div>
                    </li>
                    <li>
                        <input onclick="submitOk_a(this);" type="button" class="login_ok submita" value="登	  录" style="cursor:pointer">
                        <div class="loading_but">
                            <div class="loadings">
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                            </div>
                        </div>
                    </li>
                </ul>
                <!-- 注册 -->
                <ul class="panel2" style="display: none">
                    <li style="padding: 0px"><div class="tit_log"><h3>注册</h3><a href="javascript:void(0)" class="flip2" style="color: #0061b0">登录</a></div></li>
                    <li><input class="in_user user_b" placeholder="用户名" autocomplete="off"></li>
                    <li><input class="in_mm pass_b" type="password" placeholder="密码" autocomplete="off"></li>
                    <li><input class="in_mm pass_b2" type="password" placeholder="再次输入密码" autocomplete="off"></li>
                    <li>
                        <input class="in_login w60 fl tpyzm_b" type="text" placeholder="验证码" size="10" value="">
                        <a href="javascript:void(0)" onclick="javascript:document.getElementById('codeimage_b').src='/member/img/code?' + Math.random();">
                            <img src="/member/img/code" title="看不清？换一张" border="0" id="codeimage_b" style="width:100px;height:39px;" class="yzm fl">
                        </a>
                        <div>
                            <input onclick="submitOk_b(this);" type="button" class="login_ok submitb" value="注   册" style="width: 28%;margin-left: 2%;margin-top: 0px;height: 40px;cursor:pointer">
                            <div class="loading_but">
                                <div class="loadings">
                                    <div class="my_loading"></div>
                                    <div class="my_loading"></div>
                                    <div class="my_loading"></div>
                                    <div class="my_loading"></div>
                                    <div class="my_loading"></div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li class="ff">
                        <div style="margin-top: -11px;font-size: 12px;"><input type="checkbox" checked="checked" class="checkbox_b">我已阅读并同意<a href="javascript:protocol()">《用户协议》</a></div>
                        <div style="margin-top: -9px;color: red;font-size: 12px;margin-left: 10px;" class="error_b"></div>
                    </li>
                </ul>
                <!-- 手机登录 -->
                <ul class="panel3" style="display: none">
                    <li style="padding: 0px"><div class="tit_log"><h3>手机</h3><a href="javascript:void(0)" class="flip2" style="color: #0061b0;margin-right: 40px;">登录</a><a href="javascript:void(0)" class="flip1" style="color: #0061b0">注册</a></div></li>
                    <li><input class="in_user user_c" placeholder="手机号" autocomplete="off"></li>
                    <li>
                        <input class="in_login w130 fl tpyzm_c" type="text" placeholder="图片验证码" size="10">
                        <a href="javascript:void(0)" onclick="javascript:document.getElementById('codeimage_c').src='/member/img/code?' + Math.random();">
                            <img src="/member/img/code" title="看不清？换一张" border="0" id="codeimage_c" style="width:120px;height:39px;" class="yzm fl">
                        </a>
                    </li>
                    <li>
                        <input class="in_mm w130 fl dxyzm_c" type="text" placeholder="短信验证码" autocomplete="off">
                        <input onclick="sys_c()" type="button" class="dxyzm fl btnSendCode_c" value="获取验证码">
                        <div class="sysmail_loading fl sys_loading">
                            <div class="loadings">
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                            </div>
                        </div>
                    </li>
                    <li class="ff">
                        <div style="margin-top: -10px;font-size: 12px"><input type="checkbox" checked="checked" class="checkbox_c">我已阅读并同意<a href="javascript:protocol()">《用户协议》</a></div>
                        <div style="margin-top: -2px;color: red;font-size: 12px;margin-left: 10px" class="error_c"></div>
                    </li>
                    <li>
                        <input onclick="submitOk_c(this);" type="button" class="login_ok submitc" value="登	  录" style="cursor:pointer">
                        <div class="loading_but">
                            <div class="loadings">
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                            </div>
                        </div>
                    </li>
                </ul>
                <!-- 邮箱登录 -->
                <ul class="panel4" style="display: none">
                    <li style="padding: 0px"><div class="tit_log"><h3>邮箱</h3><a href="javascript:void(0)" class="flip2" style="color: #0061b0;margin-right: 40px;">登录</a><a href="javascript:void(0)" class="flip1" style="color: #0061b0">注册</a></div></li>
                    <li><input class="in_user user_d" placeholder="邮箱号" autocomplete="off"></li>
                    <li>
                        <input class="in_login w130 fl tpyzm_d" type="text" placeholder="图片验证码" size="10">
                        <a href="javascript:void(0)" onclick="javascript:document.getElementById('codeimage_d').src='/member/img/code?' + Math.random();">
                            <img src="/member/img/code" title="看不清？换一张" border="0" id="codeimage_d" style="width:120px;height:39px;" class="yzm fl">
                        </a>
                    </li>
                    <li>
                        <input class="in_mm w130 fl dxyzm_d" type="text" placeholder="邮件验证码" autocomplete="off">
                        <input onclick="mail_d(this)" type="button" class="dxyzm fl btnSendCode_d" value="获取验证码">
                        <div class="sysmail_loading fl mail_loading">
                            <div class="loadings">
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                            </div>
                        </div>
                    </li>
                    <li class="ff">
                        <div style="margin-top: -10px;font-size: 12px"><input type="checkbox" checked="checked" class="checkbox_d">我已阅读并同意<a href="javascript:protocol()">《用户协议》</a></div>
                        <div style="margin-top: -5px;color: red;font-size: 12px;margin-left: 10px" class="error_d"></div>
                    </li>
                    <li style="padding-top: 0;margin-top: 9px;">
                        <input onclick="submitOk_d(this);" type="button" class="login_ok submitd" value="登	  录" style="cursor:pointer">
                        <div class="loading_but">
                            <div class="loadings">
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                                <div class="my_loading"></div>
                            </div>
                        </div>
                    </li>
                </ul>
                <!-- 邮箱快速认证 -->
                <ul class="panel5" style="display: none">
                    <li style="padding: 0px"><div class="tit_log"><h3>邮箱认证</h3><a href="javascript:void(0)" class="flip2" style="color: #0061b0;margin-right: 40px;">登录</a><a href="javascript:void(0)" class="flip1" style="color: #0061b0">注册</a></div></li>
                    <li></li>
                    <li class="mailBut">
                        <div class="loadings">
                            <div class="my_loading" style="height:20px;background: gray;"></div>
                            <div class="my_loading" style="height:20px;background: gray;"></div>
                            <div class="my_loading" style="height:20px;background: gray;"></div>
                            <div class="my_loading" style="height:20px;background: gray;"></div>
                            <div class="my_loading" style="height:20px;background: gray;"></div>
                            <div class="my_loading" style="height:20px;background: gray;"></div>
                            <div class="my_loading" style="height:20px;background: gray;"></div>
                        </div>
                    </li>
                    <li class="mailBut mailButton" style="text-align: center;">正在登录...</li>
                    <li>
                        <div class="error_e" style="color: red;font-size: 12px;text-align: center;"></div>
                    </li>
                </ul>
                <%--<ul>
                    <li>
                        <hr style="height:1px;border:none;border-top:1px solid #dadada;margin-top: -5px" />
                        <div style="color:#dadada;font-size: 12px;margin-top: -15px;text-align: center;">第三方账号直接登录</div>
                        <div style="text-align: center;">
                            <!-- <a href="javascript:alertOpen('正在开发...')" title="QQ登录"><img src="../static/images/QQ.png" style="width: 40px;height: 40px"></a>
                            <a href="javascript:alertOpen('正在开发...')" title="微信登录"><img src="../static/images/VX.png" style="width: 40px;height: 40px;margin-left: 30px"></a> -->
                            <div style="float:left;margin-left: 90px"><a href="javascript:void(0)" class="flip3" title="手机登录"><img src="../static/images/TEL.png" style="width: 40px;height: 40px;"></a></div>
                            <div style="float:left;margin-left: 50px"><a href="javascript:void(0)" class="flip4" title="邮箱登录"><img src="../static/images/MAIL.png" style="width: 40px;height: 40px;"></a></div>
                        </div>
                    </li>
                </ul>--%>
            </div>
        </div>
    </div>
    <div style="text-align: center;line-height: 30px;height: 80px;padding: 20px">
        <p >中国质量协会 版权所有 未经授权请勿转载任何图文或建立镜像</p>
        <p>客服邮箱：caq123@caq.org.cn&nbsp;&nbsp;&nbsp; 制作单位：中国质量协会网络中心</p>
        <p>Copyright©2003-2008 All rights reserved 京ICP备05018279号-1 京公网安备 110102000185</p>
    </div>
</div>
<script type="text/javascript" src="../static/js/login/login.js"></script>
</body>
</html>