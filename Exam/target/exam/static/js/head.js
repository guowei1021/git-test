//外部系统根地址
function getMgtBasePath(){
	return "http://192.168.8.225:8080"
}
var pageWrapper=$('<div class="wrapper"></div>'); 
var topWrapper=$('<div class="top-wrapper"></div>'); 
var clearfix=$('<div class="clearfix"></div>'); 
$(function() {
	if (self == top) { 
		//头部
		$("main").before('<header id="topPage"></header> ')
		if(navigator.userAgent.indexOf("MSIE 8.0")>0){
			$('<footer id="footPage"></footer> ').insertAfter($("body"))
		}else{
			$("main").after('<footer id="footPage"></footer> ')
		}
		
		var topPage=$("#topPage");
		//创建div
		var account = "<a href='javascript:loginmodal()' style='border-left: 0px;color:blue;padding-left: 0px;margin-right: 10px;font-size: 12px'>登录</a>";
		var as = "";
		var hy = "";
		if(user()!=null){
			hy = "<hy style='font-size: 12px'>欢迎：</hy>"
			account = '<a href="/member/user/information.html" title="个人中心" style="border-left:0px;padding-left: 0px;font-size: 12px">'+user().account+'</a>';
			as = '<a href="javascript:loginOut()" style="float:right;border-left:0px;color:blue;margin-right:10px;margin-left: 10px;padding-left: 0px;font-size: 12px">退出</a>'
			
		}
		var leftDiv=$('<div  class="top-left left"> <div class="logo-system margin-l-s clearfix">'
				+'<p class="left">中国质量协会质量服务平台</p>'
				+' </div>  </div>');
		var rightDiv=$('<div class="top-right margin-r-s right">' 
				+'<ul class="act-list">'
				+'<li><a href="/rs/static/pages/orgmanage/org_unit.html" target="rightFrame"   class="organizational" style="border:none;font-size: 12px">组织单位</a></li>'
				+'<li><a href="/rs/declaremanage/apply_home_page.jsp" target="rightFrame"   class="sereward" style="font-size: 12px">质量品牌申报</a></li>'
				+'<li><a href="/rs/reviewmanage/award_review.jsp" target="rightFrame" class="seexpertre"  style="font-size: 12px">专家评审</a></li>'
				+'<li><a href="/exam/pages/examinee/apply-exam-list.jsp"  target="rightFrame" class="seonlineexam" style="font-size: 12px">在线考试</a></li>'
				+'<li><a href="/member/declaremanage/ms_organization_info.jsp"  target="rightFrame" class="" style="border-right: 1px solid #ccc;font-size: 12px">基础信息</a></li>'
				+'<li style="text-align: center;padding-left: 20px;">'+hy+''+account+''+as+'</li>'
				+ '</ul>'
				+ '</div>');
		clearfix.append(leftDiv);
		clearfix.append(rightDiv);
		//添加样式
		topWrapper.append(clearfix);
		pageWrapper.append(topWrapper);
		topPage.append(pageWrapper);
		//底端
		var footPage=$("#footPage");
		var foot=$('<div class="foot"></div>'); 
		var footWrapper=$('<div class="foot-wrapper"></div>'); 
		var footContent=$('<div class="foot-content center">'
				+'<ul class="act-list">'
				+'<li><a href="#">关于我们</a></li>'
				+'<li><a href="#">网站地图</a></li>'
				+'<li><a href="#">版权声明</a></li>'
				+'<li><a href="#">联系我们</a></li>'
				+'</ul>'
				+'</div>'); 
		var footTxt=$('<div class="foot-txt">'
				+'<p>中国质量协会 版权所有 未经授权请勿转载任何图文或建立镜像</p>'
				+'<p>客服邮箱：caq123@caq.org.cn&nbsp;&nbsp;&nbsp; 制作单位：中国质量协会网络中心</p>'
				+'<p>Copyright©2003-2008 All rights reserved 京ICP备05018279号-1 京公网安备 110102000185</p>'
				+'</div>'); 
		footWrapper.append(footContent);
		foot.append(footWrapper);
		foot.append(footTxt);
		footPage.append(foot);
		//清除浮动
		topPage.append('<div style="clear:both;"></div>')
		footPage.append('<div style="clear:both;"></div>')
	}

	
    })
    
    
    
    
//登录====================================    
$(function(){
	$("body").append('<div class="am-modal am-modal-alert" tabindex="-1" id="login-modal">'+
			'<div class="am-modal-dialog" style="background:white;width:400px;height:440px">'+
			'<div class="am-modal-hd" style="padding: 10px 10px 5px 10px;">'+
				'<a href="javascript:void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>'+
			'</div>'+	
			'<div class="am-modal-bd" style="border:none;font-size: 14px;height:400px;padding: 15px 5px;">'+
					'<div class="in_log">'+
						/*登录*/	
						'<ul class="panel1">'+
							'<li style="padding: 0px"><div class="tit_log"><h3>登录</h3><a href="javascript:void(0)" class="flip1" style="color: #0061b0">注册</a></div></li>'+
							'<li><input class="in_user user_a" type="text" placeholder="用户名" autocomplete="off" value=""></li>'+
							'<li><input class="in_mm pass_a" type="password" placeholder="密码" autocomplete="off" value=""></li>'+
							'<li>'+
								'<input class="in_login w165 fl tpyzm_a" type="text" placeholder="图片验证码" size="10" value="">'+
								'<a href="javascript:void(0)" onclick="javascript:document.getElementById(\'codeimage_a\').src=\'/member/img/code?\' + Math.random();">'+
									'<img src="/member/img/code" title="看不清？换一张" border="0" id="codeimage_a" style="width:120px;height:39px;" class="yzm fl">'+
								'</a>'+
							'</li>'+
							'<li class="ff">'+
								'<a href="javascript:alert(\'如果该账号已绑定手机或邮箱，请使用验证码登录后到个人中心修改密码，如未绑定请联系系统管理员！\')" class="fr" style="color:#0061b0;">忘记密码？</a>'+
								'<div class="error_a" style="color: red;font-size: 12px;text-align: left;"></div>'+
							'</li>'+
							'<li><input onclick="submitOk_a();" type="button" class="login_ok" value="登	  录"></li>'+
						'</ul>'+
						/*注册*/	
						'<ul class="panel2" style="display: none">'+
							'<li style="padding: 0px"><div class="tit_log"><h3>注册</h3><a href="javascript:void(0)" class="flip2" style="color: #0061b0">登录</a></div></li>'+
							'<li><input class="in_user user_b" placeholder="用户名" autocomplete="off"></li>'+
							'<li><input class="in_mm pass_b" type="password" placeholder="密码" autocomplete="off"></li>'+
							'<li><input class="in_mm pass_b2" type="password" placeholder="再次输入密码" autocomplete="off"></li>'+
							'<li>'+
								'<input class="in_login fl tpyzm_b" type="text" placeholder="验证码" size="10" value="" style="width:105px">'+
								'<a href="javascript:void(0)" onclick="javascript:document.getElementById(\'codeimage_b\').src=\'/member/img/code?\' + Math.random();">'+
									'<img src="/member/img/code" title="看不清？换一张" border="0" id="codeimage_b" style="width:100px;height:39px;" class="yzm fl">'+
								'</a>'+
								'<input onclick="submitOk_b();" type="button" class="login_ok" value="注   册" style="width: 25%;margin-left: 2%;margin-top: 0px;height: 40px;cursor:pointer">'+
							'</li>'+
							'<li class="ff">'+
							/*'<div style="float:left;margin-top: 5px;font-size: 12px;text-align: left;"><input type="checkbox" checked="checked" class="checkbox_b" style="height:14px;">我已阅读并同意<a href="javascript:void(0)">《用户协议》</a></div>'+*/
							'<div style="float:left;margin-top: 5px;color: red;font-size: 12px;margin-left: 10px;text-align: left;" class="error_b"></div>'+
							'</li>'+
						'</ul>'+
						/*手机*/	
						'<ul class="panel3" style="display: none">'+
							'<li style="padding: 0px"><div class="tit_log"><h3>手机</h3><a href="javascript:void(0)" class="flip2" style="color: #0061b0;margin-right: 40px;">登录</a><a href="javascript:void(0)" class="flip1" style="color: #0061b0">注册</a></div></li>'+
							'<li><input class="in_user user_c" placeholder="手机号" autocomplete="off"></li>'+
							'<li>'+
								'<input class="in_login w165 fl tpyzm_c" type="text" placeholder="图片验证码" size="10">'+
								'<a href="#" onclick="javascript:document.getElementById(\'codeimages_c\').src=\'/member/img/code?\' + Math.random();">'+
									'<img src="/member/img/code" title="看不清？换一张" border="0" id="codeimages_c" style="width:120px;height:39px;" class="yzm fl">'+
								'</a>'+
							'</li>'+
							'<li>'+
								'<input class="in_mm w165 fl dxyzm_c" type="text" placeholder="短信验证码" autocomplete="off">'+
								'<input onclick="sendMessage()" type="button" class="dxyzm fl btnSendCode" value="获取验证码">'+
							'</li>'+
							'<li class="ff">'+
								/*'<div style="margin-top: -5px;font-size: 12px;text-align: left;"><input type="checkbox" checked="checked" class="checkbox" style="height:14px;">我已阅读并同意<a href="javascript:void(0)">《用户协议》</a></div>'+*/
								'<div style="margin-top: -5px;color: red;font-size: 12px;text-align: left;" class="error_c"></div>'+
							'</li>'+
							'<li><input onclick="submitOk_c();" type="button" class="login_ok" value="登	  录"></li>'+
						'</ul>'+
						/*邮箱*/	
						'<ul class="panel4" style="display: none">'+
							'<li style="padding: 0px"><div class="tit_log"><h3>邮箱</h3><a href="javascript:void(0)" class="flip2" style="color: #0061b0;margin-right: 40px;">登录</a><a href="javascript:void(0)" class="flip1" style="color: #0061b0">注册</a></div></li>'+
							'<li><input class="in_user user_d" placeholder="邮箱号" autocomplete="off"></li>'+
							'<li>'+
								'<input class="in_login w165 fl tpyzm_d" type="text" placeholder="图片验证码" size="10">'+
								'<a href="#" onclick="javascript:document.getElementById(\'codeimage_d\').src=\'/member/img/code?\' + Math.random();">'+
									'<img src="/member/img/code" title="看不清？换一张" border="0" id="codeimage_d" style="width:120px;height:39px;" class="yzm fl">'+
								'</a>'+
							'</li>'+
							'<li>'+
								'<input class="in_mm w165 fl dxyzm_d" type="text" placeholder="邮件验证码" autocomplete="off">'+
								'<input onclick="mail_d()" type="button" class="dxyzm fl btnSendCode_d" value="获取验证码">'+
							'</li>'+
							'<li class="ff">'+
								/*'<div style="margin-top: -5px;font-size: 12px;text-align: left;"><input type="checkbox" checked="checked" class="checkbox_d" style="height:14px;">我已阅读并同意<a href="javascript:void(0)">《用户协议》</a></div>'+*/
								'<div style="margin-top: -5px;color: red;font-size: 12px;text-align: left;" class="error_d"></div>'+
							'</li>'+
							'<li><input onclick="submitOk_d();" type="button" class="login_ok" value="登	  录"></li>'+
						'</ul>'+
						/*'<ul style="margin-top: 10px;">'+
							'<li style="padding: 0px 0;">'+
								'<hr style="height:1px;border:none;border-top:1px solid #dadada;" />'+
								'<div style="color:#dadada;font-size: 12px;margin-top: -15px;text-align: center;">第三方账号直接登录</div>'+
								'<div style="text-align: center;">'+
									'<a href="javascript:alert(\'正在开发...\')" title="QQ登录"><img src="../static/images/QQ.png" style="width: 40px;height: 40px"></a>'+
									'<a href="javascript:alert(\'正在开发...\')" title="微信登录"><img src="../static/images/VX.png" style="width: 40px;height: 40px;margin-left: 30px"></a>'+
									'<a href="javascript:void(0)" class="flip3" title="手机登录"><img src="/member/static/images/TEL.png" style="width: 40px;height: 40px;"></a>'+
									'<a href="javascript:void(0)" class="flip4" title="邮箱登录"><img src="/member/static/images/MAIL.png" style="width: 40px;height: 40px;"></a>'+
								'</div>'+
							'</li>'+
						'</ul>'+*/
					'</div>'+
				'</div>'+
			'</div>'+
		'</div>'+
		'<div class="am-modal am-modal-confirm" tabindex="-1" id="loginout-modal">'+
			'<div class="am-modal-dialog" style="width:300px">'+
				'<div class="am-modal-hd" style="font-size: 19px;">提示</div>'+
		    	'<div class="am-modal-bd">确定要退出吗？</div>'+
		    	'<div class="am-modal-footer">'+
			    	'<span class="am-modal-btn" style="font-size: 14px;" data-am-modal-cancel>取消</span>'+
			    	'<span class="am-modal-btn" style="font-size: 14px;" onclick="loginOuty()" data-am-modal-confirm>确定</span>'+
		    	'</div>'+
			'</div>'+
		'</div>	'
		)
		$(".flip1").click(function(){
		    if($(".panel2").is(":hidden")){
			    document.getElementById('codeimage_b').src='/member/img/code?' + Math.random();
		    }
		    $(".panel2").slideDown("slow");
		    $(".panel1,.panel3,.panel4").slideUp("slow");
	  	});
		$(".flip2").click(function(){
			if($(".panel1").is(":hidden")){
			    document.getElementById('codeimage_a').src='/member/img/code?' + Math.random();
		    }
			$(".panel1").slideDown("slow");
			$(".panel2,.panel3,.panel4").slideUp("slow");
	  	});
		$(".flip3").click(function(){
			if($(".panel3").is(":hidden")){
			    document.getElementById('codeimage_c').src='/member/img/code?' + Math.random();
		    }
			$(".panel3").slideDown("slow");
			$(".panel1,.panel2,.panel4").slideUp("slow");
	  	});
		$(".flip4").click(function(){
			if($(".panel4").is(":hidden")){
			    document.getElementById('codeimage_d').src='/member/img/code?' + Math.random();
		    }
			$(".panel4").slideDown("slow");
			$(".panel1,.panel2,.panel3").slideUp("slow");
	  	});
})
//登录
function submitOk_a() {
	if ($(".user_a").val() == "") {  
	    $(".error_a").html("请输入账号！")
        return false;  
    }
	if ($(".pass_a").val() == "") {  
	    $(".error_a").html("请输入密码！")
        return false;  
    }
	if ($(".tpyzm_a").val() == "") {  
	    $(".error_a").html("请输入图形验证码！")
        return false;  
    }
	$.ajax({
		url:"/member/login/login",
		type:"post",
		dataType:"json",
		contentType:"application/json",
		data:$.toJSON({parameters:{account:$(".user_a").val(),password:$(".pass_a").val(),code:$(".tpyzm_a").val()}}),
		success:function(data){
			console.log(data);
			if(data.result == "success"){
				$('#login-modal').modal('close');
				window.location.reload();
			}
		},
		error:function(data){
			$(".error_a").html(JSON.parse(data.responseText).errors[0].message)
			document.getElementById('codeimage_a').src='/member/img/code?' + Math.random();
			$(".tpyzm_a").val("")
		}
	})
}
//注册
function submitOk_b() {
	$(".error_b").html("")
	/*if(!$(".checkbox_b").is(":checked")){
		$(".error_b").html("请阅读并同意用户协议！")
		return false;
	}*/
    if (!/^[a-zA-Z][a-zA-Z0-9-_]{3,17}$/.test($(".user_b").val()) || $(".user_b").val().indexOf("@") != -1) {  
	    $(".error_b").html("用户名4~18位字母、数字、-、_ 组成，字母开头！")
        return false;
    }
    if (!/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$/.test($(".pass_b").val())) {  
	    $(".error_b").html("密码8~16位字母和数字组成！")
        return false;  
    }
    if ($(".pass_b").val() != $(".pass_b2").val()) {  
	    $(".error_b").html("两次密码输入不一致！")
        return false;  
    }
    if ($(".tpyzm_b").val() == "") {  
	    $(".error_b").html("请输入图形验证码！")
        return false;  
    }
	$.ajax({
		url:"/member/login/register",
		type:"post",
		dataType:"json",
		contentType:"application/json",
		data:$.toJSON({account:$(".user_b").val(),password:$(".pass_b").val(),code:$(".tpyzm_b").val()}),
		success:function(data){
			console.log(data);
			if(data.result == "success"){
				$('#login-modal').modal('close');
				window.location.reload();
			}
		},
		error:function(data){
			$(".error_b").html(JSON.parse(data.responseText).errors[0].message)
			document.getElementById('codeimage_b').src='/member/img/code?' + Math.random();
			$(".tpyzm_b").val("");
		}
	})
}
//邮箱登录（发送验证码）
function mail_d(){
	if(check()){
		$(".btnSendCode_d").attr("disabled", "true"); 
		$.ajax({
			url:"/member/logincode/mail",
			type:"post",
			dataType:"json",
			contentType:"application/json",
			data:$.toJSON({account:$(".user_d").val(),code:$(".tpyzm_d").val()}),
			success:function(data){
				console.log(data);
				if(data.result == "success"){
					sendMessage_d();//验证码倒计时
					
					var uurl = $(".user_d").val();//生成登录邮箱链接
		            uurl = gotoEmail(uurl);
		            if (uurl != "") {
		                $(".error_d").html("<span style='color:green'>验证码已发送, 点击 &nbsp;<a href='http://"+uurl+"' target='_blank' style='color:#0061b0'>登录邮箱</a> &nbsp;查看!</apan>");
		            }else{
		            	$(".error_d").html("<span style='color:green'>验证码已发送,请注意查看!");
		            }
		            
					document.getElementById('codeimage_d').src='/member/img/code?' + Math.random();
					$(".tpyzm_d").val("");
				}
			},
			error:function(data){
				$(".error_d").html(JSON.parse(data.responseText).errors[0].message)
				document.getElementById('codeimage_d').src='/member/img/code?' + Math.random();
				$(".tpyzm_d").val("");
				$(".btnSendCode_d").removeAttr("disabled");//启用按钮 
			}
		})
	}
}
function submitOk_d() {
	if(check()){
		if ($(".dxyzm_d").val() == "") {  
		    $(".error_d").html("请输入短信验证码！")
	        return false;  
	    }
		$.ajax({
			url:"/member/login/mail",
			type:"post",
			dataType:"json",
			contentType:"application/json",
			data:$.toJSON({account:$(".user_d").val(),password:$(".dxyzm_d").val(),code:$(".tpyzm_d").val()}),
			success:function(data){
				console.log(data);
				if(data.result == "success"){
					$('#login-modal').modal('close');
					window.location.reload();
				}
			},
			error:function(data){
				$(".error_d").html(JSON.parse(data.responseText).errors[0].message)
				document.getElementById('codeimage_d').src='/member/img/code?' + Math.random();
				$(".tpyzm_d").val("")
			}
		}) 
	}
}
//邮箱校验
function check(){
	if ($(".user_d").val() == "") {  
	    $(".error_d").html("请输入邮箱！")
        return false;  
    }
	if (!/^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/.test($(".user_d").val())) { 
	    $(".error_d").html("邮箱格式错误！")
        return false;  
    }
	if ($(".tpyzm_d").val() == "") {  
	    $(".error_d").html("请输入图片验证码！")
        return false;  
    }
	/*if(!$(".checkbox_d").is(":checked")){
		$(".error_d").html("请阅读并同意用户协议！")
		return false;
	}*/
	return true;
}

/*限制发送邮件*/
var InterValObj_d; //timer变量，控制时间 
var count_d = 60; //间隔函数，1秒执行 
var curCount_d = getCookie("curCount_d");//当前剩余秒数 
if(curCount_d>0){
	sendMessage_d()
}
function sendMessage_d() { 
	if(curCount_d<1){
		curCount_d = count_d; 
	}
   	$(".btnSendCode_d").addClass("dxyzms"); 
   	$(".btnSendCode_d").attr("disabled", "true"); 
   	$(".btnSendCode_d").val("重新发送("+curCount_d+") "); 
   	InterValObj_d = window.setInterval(SetRemainTime_d, 1000); //启动计时器，1秒执行一次 
} 
//timer处理函数 
function SetRemainTime_d() { 
   if (curCount_d == 0) {         
     window.clearInterval(InterValObj_d);//停止计时器 
 	 $(".btnSendCode_d").removeClass("dxyzms"); 
     $(".btnSendCode_d").removeAttr("disabled");//启用按钮 
     $(".btnSendCode_d").val("重新发送"); 
   } 
   else { 
     curCount_d--; 
     var date=new Date(); 
     date.setTime(date.getTime()+curCount_d*1000); 
     document.cookie="curCount_d="+curCount_d+";expires="+date.toGMTString();
     $(".btnSendCode_d").val("重新发送("+curCount_d+") "); 
   } 
 } 
 
//取 cookie
function getCookie(name){
	var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
	if(arr=document.cookie.match(reg))
		return unescape(arr[2]);
	else
		return null;
}
//根据用户输入的Email跳转到相应的电子邮箱首页
function gotoEmail($mail) {
    $t = $mail.split('@')[1];
    $t = $t.toLowerCase();
    if ($t == '163.com') {
        return 'mail.163.com';
    } else if ($t == 'vip.163.com') {
        return 'vip.163.com';
    } else if ($t == '126.com') {
        return 'mail.126.com';
    } else if ($t == 'qq.com' || $t == 'vip.qq.com' || $t == 'foxmail.com') {
        return 'mail.qq.com';
    } else if ($t == 'gmail.com') {
        return 'mail.google.com';
    } else if ($t == 'sohu.com') {
        return 'mail.sohu.com';
    } else if ($t == 'tom.com') {
        return 'mail.tom.com';
    } else if ($t == 'vip.sina.com') {
        return 'vip.sina.com';
    } else if ($t == 'sina.com.cn' || $t == 'sina.com') {
        return 'mail.sina.com.cn';
    } else if ($t == 'tom.com') {
        return 'mail.tom.com';
    } else if ($t == 'yahoo.com.cn' || $t == 'yahoo.cn') {
        return 'mail.cn.yahoo.com';
    } else if ($t == 'yeah.net') {
        return 'www.yeah.net';
    } else if ($t == '21cn.com') {
        return 'mail.21cn.com';
    } else if ($t == 'hotmail.com') {
        return 'www.hotmail.com';
    } else if ($t == 'sogou.com') {
        return 'mail.sogou.com';
    } else if ($t == '188.com') {
        return 'www.188.com';
    } else if ($t == '189.cn') {
        return 'webmail15.189.cn/webmail';
    } else if ($t == 'wo.com.cn') {
        return 'mail.wo.com.cn/smsmail';
    } else if ($t == '139.com') {
        return 'mail.10086.cn';
    } else {
        return '';
    }
};
$("body").keydown(function (){
	$(".error_a,.error_b,.error_c,.error_d").html("")
})
/* base64 */
function Base64() {  
    // private property  
    _keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";  
   
    // public method for encoding  
    this.encode = function (input) {  
        var output = "";  
        var chr1, chr2, chr3, enc1, enc2, enc3, enc4;  
        var i = 0;  
        input = _utf8_encode(input);  
        while (i < input.length) {  
            chr1 = input.charCodeAt(i++);  
            chr2 = input.charCodeAt(i++);  
            chr3 = input.charCodeAt(i++);  
            enc1 = chr1 >> 2;  
            enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);  
            enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);  
            enc4 = chr3 & 63;  
            if (isNaN(chr2)) {  
                enc3 = enc4 = 64;  
            } else if (isNaN(chr3)) {  
                enc4 = 64;  
            }  
            output = output +  
            _keyStr.charAt(enc1) + _keyStr.charAt(enc2) +  
            _keyStr.charAt(enc3) + _keyStr.charAt(enc4);  
        }  
        return output;  
    }  
   
    // public method for decoding  
    this.decode = function (input) {  
        var output = "";  
        var chr1, chr2, chr3;  
        var enc1, enc2, enc3, enc4;  
        var i = 0;  
        input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");  
        while (i < input.length) {  
            enc1 = _keyStr.indexOf(input.charAt(i++));  
            enc2 = _keyStr.indexOf(input.charAt(i++));  
            enc3 = _keyStr.indexOf(input.charAt(i++));  
            enc4 = _keyStr.indexOf(input.charAt(i++));  
            chr1 = (enc1 << 2) | (enc2 >> 4);  
            chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);  
            chr3 = ((enc3 & 3) << 6) | enc4;  
            output = output + String.fromCharCode(chr1);  
            if (enc3 != 64) {  
                output = output + String.fromCharCode(chr2);  
            }  
            if (enc4 != 64) {  
                output = output + String.fromCharCode(chr3);  
            }  
        }  
        output = _utf8_decode(output);  
        return output;  
    }  
   
    // private method for UTF-8 encoding  
    _utf8_encode = function (string) {  
        string = string.replace(/\r\n/g,"\n");  
        var utftext = "";  
        for (var n = 0; n < string.length; n++) {  
            var c = string.charCodeAt(n);  
            if (c < 128) {  
                utftext += String.fromCharCode(c);  
            } else if((c > 127) && (c < 2048)) {  
                utftext += String.fromCharCode((c >> 6) | 192);  
                utftext += String.fromCharCode((c & 63) | 128);  
            } else {  
                utftext += String.fromCharCode((c >> 12) | 224);  
                utftext += String.fromCharCode(((c >> 6) & 63) | 128);  
                utftext += String.fromCharCode((c & 63) | 128);  
            }  
   
        }  
        return utftext;  
    }  
   
    // private method for UTF-8 decoding  
    _utf8_decode = function (utftext) {  
        var string = "";  
        var i = 0;  
        var c = c1 = c2 = 0;  
        while ( i < utftext.length ) {  
            c = utftext.charCodeAt(i);  
            if (c < 128) {  
                string += String.fromCharCode(c);  
                i++;  
            } else if((c > 191) && (c < 224)) {  
                c2 = utftext.charCodeAt(i+1);  
                string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));  
                i += 2;  
            } else {  
                c2 = utftext.charCodeAt(i+1);  
                c3 = utftext.charCodeAt(i+2);  
                string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));  
                i += 3;  
            }  
        }  
        return string;  
    }  
}  

//data:error返回的参数; alert:true表示500后弹出alert;
function LoginNoAndError(data,alerts){
	if(data.responseText!="" && data.responseText!=null){
		var data =JSON.parse(data.responseText); 
		//500后弹出alert，未登录或没权限除外。(true表示弹出alert)
		if(alerts==true && data.errors[0].code != "NoPermission" && data.errors[0].code != "NoLogin"){
			alert(data.errors[0].message)
		}
		//未登录弹出alert 并且弹出登录模态框
		if(data.errors[0].code == "NoLogin"){
			if(top != self){ 
				var te =  window.document.location.pathname + window.location.search;
				var base = new Base64(); 
				te = base.encode(te)
				te = te.replace(/=/g, 'DENGHAO');
				console.log("改造：" + te);
				var kfc = getMgtBasePath() + "/portal/toSvr?svrUrl=" + te;
				console.log("请求：" + kfc);
				window.location.href = kfc;
			}else{
				loginmodal()
			}
		}else if(data.errors[0].code == "NoPermission"){
			window.location.href = "/member/403.html";
		}
	}
}
//打开登录窗口
function loginmodal(){
	$('#login-modal').modal({closeViaDimmer:false});
}

//提交表单
document.onkeydown = function(evt){
	var evt = window.event?window.event:evt;
	if(evt.keyCode==13){
		submitOk_a()
	}
}
//退出登录
function loginOut(){
	$('#loginout-modal').modal({closeViaDimmer:false});
}
function loginOuty(){
	$.ajax({
		url:"/member/login/loginout",
		type:"post",
		dataType:"json",
		contentType:"application/json",
		success:function(data){
			if(data.result == "success"){
				window.location.reload();
			}
		}
	})
}
//获取登录信息
function user(){
	var userdata = null;
	$.ajax({
		url:"/member/login/user",
		async:false,
		type:"post",
		dataType:"json",
		contentType:"application/json",
		success:function(data){
			userdata = data;
		},
		error:function(data){
			LoginNoAndError(data,true)
		}
	})
	return userdata;
}
//获取账号
function account(){
	if(user() != null){
		return user().account;
	}else{
		return "";
	}
}
//获取用户id
function accountId(){
	if(user() != null){
		return user().accountId;
	}else{
		return "";
	}
}
