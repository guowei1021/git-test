/*$(function(){
	$(".flip1").click(function(){
		flip1()
  	});
	$(".flip2").click(function(){
		flip2()
  	});
	$(".flip3").click(function(){
		flip3()
  	});
	$(".flip4").click(function(){
		flip4()
  	});
	var t = getParam("t");
	if(t == "1"){
		flip1()
	}else if(t == "2"){
		flip3()
	}else if(t == "3"){
		flip4()
	}else if(t == "4" && new Date($.ajax({async: false}).getResponseHeader("Date")).getTime() < getParam("time")){
		flip5()
	}else{
		flip2()
	}
})*/
/*
function flip1(){
	if($(".panel2").is(":hidden")){
	    document.getElementById('codeimage_b').src='/member/img/code?' + Math.random();
    }
    $(".panel2").slideDown("slow");
    $(".panel1,.panel3,.panel4,.panel5").slideUp("slow");
}
function flip2(){
	if($(".panel1").is(":hidden")){
	    document.getElementById('codeimage_a').src='/member/img/code?' + Math.random();
    }
	$(".panel1").slideDown("slow");
	$(".panel2,.panel3,.panel4,.panel5").slideUp("slow");
}
function flip3(){
	if($(".panel3").is(":hidden")){
	    document.getElementById('codeimage_c').src='/member/img/code?' + Math.random();
    }
	$(".panel3").slideDown("slow");
	$(".panel1,.panel2,.panel4,.panel5").slideUp("slow");
}
function flip4(){
	if($(".panel4").is(":hidden")){
	    document.getElementById('codeimage_d').src='/member/img/code?' + Math.random();
    }
	$(".panel4").slideDown("slow");
	$(".panel1,.panel2,.panel3,.panel5").slideUp("slow");
}
function flip5(){
	$(".panel5").slideDown("slow");
	$(".panel1,.panel2,.panel3,.panel4").slideUp("slow");
	$.ajax({
		url:"/member/login/mailBut",
		type:"post",
		dataType:"json",
		contentType:"application/json",
		data:$.toJSON({account:getParam("mail"),password:getParam("code")}),
		success:function(data){
			console.log(data);
			if(data.result == "success"){
				goToUrl()
			}
		},
		error:function(data){
			$(".error_e").html(JSON.parse(data.responseText).errors[0].message)
			$(".mailBut").html("");
			$(".mailButton").html('<input onclick="flipBut()" type="button" style="width: 160px" class="dxyzm" value="重新获取验证码">');
		}
	}) 
}
function flipBut(){
	$(".user_d").val(getParam("mail"));
	flip4()

}*/

function loading(t){
	if(t != undefined){
		if($(t).is(":hidden")){
			$(t).css("display","block")
			$(t).nextAll().css("display","none")
		}else{
			$(t).css("display","none")
			$(t).nextAll().css("display","block")
		}
	}else{
		var t = $(".submita");
		if(!$(".panel2").is(":hidden")){
			t= $(".submitb")
		}else if(!$(".panel3").is(":hidden")){
			t= $(".submitc")
		}else if(!$(".panel4").is(":hidden")){
			t= $(".submitd")
		}
		if(t.is(":hidden")){
			t.css("display","block")
			t.nextAll().css("display","none")
		}else{
			t.css("display","none")
			t.nextAll().css("display","block")
		}
	}
}
function sysmail_loading(t,s){
	if(t.is(":hidden")){
		t.css("display","block")
		s.css("display","none")
	}else{
		t.css("display","none")
		s.css("display","block")
	}
}

/*============================================================================*/
//普通登录
function submitOk_a(t) {
	if ($(".user_a").val() == "") {  
	    $(".error_a").html("请输入账号！")
        return false;  
    }
	if ($(".pass_a").val() == "") {  
	    $(".error_a").html("请输入密码！")
        return false;  
    }
	/*if ($(".tpyzm_a").val() == "") {
	    $(".error_a").html("请输入图形验证码！")
        return false;
    }*/
	loading(t)
	$.ajax({
		url:"/exam/login/login",
		type:"post",
		dataType:"json",
		//contentType:"application/json",
		data:{
		    "account":$(".user_a").val(),
            "password":$(".pass_a").val()
        },
		success:function(data){
			//console.log(data);
			if(data.result == "success"){
				loading(t)
				goToUrl()
			}
		},
		error:function(data){
			$(".error_a").html(JSON.parse(data.responseText).errors[0].message)
			//document.getElementById('codeimage_a').src='/member/img/code?' + Math.random();
			//$(".tpyzm_a").val("")
			loading(t)
		}
	})
}
/*================================================================*/

//注册
function submitOk_b(t) {
	$(".error_b").html("")
	if(!$(".checkbox_b").is(":checked")){
		$(".error_b").html("请阅读并同意用户协议！")
		return false;
	}
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
    loading(t)
	$.ajax({
		url:"/member/login/register",
		type:"post",
		dataType:"json",
		contentType:"application/json",
		data:$.toJSON({account:$(".user_b").val(),password:$(".pass_b").val(),code:$(".tpyzm_b").val()}),
		success:function(data){
			console.log(data);
			if(data.result == "success"){
				loading(t)
				goToUrl()
			}
		},
		error:function(data){
			$(".error_b").html(JSON.parse(data.responseText).errors[0].message)
			document.getElementById('codeimage_b').src='/member/img/code?' + Math.random();
			$(".tpyzm_b").val("");
			loading(t)
		}
	})
}
//手机登录（发送验证码）
function sys_c(){
	if(check_c()){
		$(".btnSendCode_c").attr("disabled", "true"); 
		sysmail_loading($(".btnSendCode_c"),$(".sys_loading"))
		$.ajax({
			url:"/member/logincode/sys",
			type:"post",
			dataType:"json",
			contentType:"application/json",
			data:$.toJSON({account:$(".user_c").val(),code:$(".tpyzm_c").val()}),
			success:function(data){
				console.log(data);
				if(data.result == "success"){
					sendMessage_c();//验证码倒计时
		            $(".error_c").html("<span style='color:green'>验证码已发送,请注意查看!");
					document.getElementById('codeimage_c').src='/member/img/code?' + Math.random();
					$(".tpyzm_c").val("");
					sysmail_loading($(".btnSendCode_c"),$(".sys_loading"))
				}
			},
			error:function(data){
				$(".error_c").html(JSON.parse(data.responseText).errors[0].message)
				document.getElementById('codeimage_c').src='/member/img/code?' + Math.random();
				$(".tpyzm_c").val("");
				$(".btnSendCode_c").removeAttr("disabled");//启用按钮 
				sysmail_loading($(".btnSendCode_c"),$(".sys_loading"))
			}
		})
	}
}
function submitOk_c(t) {
	if(check_c()){
		if ($(".dxyzm_c").val() == "") {  
		    $(".error_c").html("请输入短信验证码！")
	        return false;  
	    }
		loading(t)
		$.ajax({
			url:"/member/login/sys",
			type:"post",
			dataType:"json",
			contentType:"application/json",
			data:$.toJSON({tel:$(".user_c").val(),yzm:$(".dxyzm_c").val(),code:$(".tpyzm_c").val()}),
			success:function(data){
				console.log(data);
				if(data.result == "success"){
					loading(t)
					goToUrl()
				}
			},
			error:function(data){
				$(".error_c").html(JSON.parse(data.responseText).errors[0].message)
				document.getElementById('codeimage_c').src='/member/img/code?' + Math.random();
				$(".tpyzm_c").val("")
				loading(t)
			}
		}) 
	}
}
//手机校验
function check_c(){
	if ($(".user_c").val() == "") {  
	    $(".error_c").html("请输入手机号！")
        return false;  
    }
	if (!/^[1][3,4,5,7,8][0-9]{9}$/.test($(".user_c").val())) { 
	    $(".error_c").html("手机号格式错误！")
        return false;  
    }
	if ($(".tpyzm_c").val() == "") {  
	    $(".error_c").html("请输入图片验证码！")
        return false;  
    }
	if(!$(".checkbox_c").is(":checked")){
		$(".error_c").html("请阅读并同意用户协议！")
		return false;
	}
	return true;
}
/*限制发送邮件*/
var InterValObj_c; //timer变量，控制时间 
var count_c = 60; //间隔函数，1秒执行 
var curCount_c = getCookie("curCount_c");//当前剩余秒数 
if(curCount_c>0){
	sendMessage_c()
}
function sendMessage_c() { 
	if(curCount_c<1){
		curCount_c = count_c; 
	}
   	$(".btnSendCode_c").addClass("dxyzms"); 
   	$(".btnSendCode_c").attr("disabled", "true"); 
   	$(".btnSendCode_c").val("重新发送("+curCount_c+") "); 
   	InterValObj_c = window.setInterval(SetRemainTime_c, 1000); //启动计时器，1秒执行一次 
} 
//timer处理函数 
function SetRemainTime_c() { 
   if (curCount_c == 0) {         
     window.clearInterval(InterValObj_c);//停止计时器 
 	 $(".btnSendCode_c").removeClass("dxyzms"); 
     $(".btnSendCode_c").removeAttr("disabled");//启用按钮 
     $(".btnSendCode_c").val("重新发送"); 
   } 
   else { 
     curCount_c--; 
     var date=new Date(); 
     date.setTime(date.getTime()+curCount_c*1000); 
     document.cookie="curCount_c="+curCount_c+";expires="+date.toGMTString();
     $(".btnSendCode_c").val("重新发送("+curCount_c+") "); 
   } 
 }
//邮箱登录（发送验证码）
function mail_d(t){
	if(check_d()){
		$(".btnSendCode_d").attr("disabled", "true"); 
		sysmail_loading($(".btnSendCode_d"),$(".mail_loading"))
		$.ajax({
			url:"/member/logincode/mail",
			type:"post",
			dataType:"json",
			contentType:"application/json",
			data:$.toJSON({account:$(".user_d").val(),code:$(".tpyzm_d").val(),url:url()}),
			success:function(data){
				console.log(data);
				if(data.result == "success"){
					sendMessage_d();//验证码倒计时
					
					var uurl = $(".user_d").val();//生成登录邮箱链接
		            uurl = gotoEmail(uurl);
		            if (uurl != "") {
		                $(".error_d").html("<span style='color:green'>验证码已发送, <a href='http://"+uurl+"' target='_blank' style='color:#0061b0'>登录邮箱</a> 查看!  (可能被误认为垃圾邮件)</apan>");
		            }else{
		            	$(".error_d").html("<span style='color:green'>验证码已发送,请注意查看!");
		            }
		            
					document.getElementById('codeimage_d').src='/member/img/code?' + Math.random();
					$(".tpyzm_d").val("");
					sysmail_loading($(".btnSendCode_d"),$(".mail_loading"))
				}
			},
			error:function(data){
				$(".error_d").html(JSON.parse(data.responseText).errors[0].message)
				document.getElementById('codeimage_d').src='/member/img/code?' + Math.random();
				$(".tpyzm_d").val("");
				$(".btnSendCode_d").removeAttr("disabled");//启用按钮 
				sysmail_loading($(".btnSendCode_d"),$(".mail_loading"))
			}
		})
	}
}
function submitOk_d(t) {
	if(check_d()){
		if ($(".dxyzm_d").val() == "") {  
		    $(".error_d").html("请输入邮箱验证码！")
	        return false;  
	    }
		loading(t)
		$.ajax({
			url:"/member/login/mail",
			type:"post",
			dataType:"json",
			contentType:"application/json",
			data:$.toJSON({account:$(".user_d").val(),password:$(".dxyzm_d").val(),code:$(".tpyzm_d").val()}),
			success:function(data){
				console.log(data);
				if(data.result == "success"){
					loading(t)
					goToUrl()
				}
			},
			error:function(data){
				$(".error_d").html(JSON.parse(data.responseText).errors[0].message)
				document.getElementById('codeimage_d').src='/member/img/code?' + Math.random();
				$(".tpyzm_d").val("")
				loading(t)
			}
		}) 
	}
}
//邮箱校验
function check_d(){
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
	if(!$(".checkbox_d").is(":checked")){
		$(".error_d").html("请阅读并同意用户协议！")
		return false;
	}
	return true;
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


$("body").keydown(function (){
	$(".error_a,.error_b,.error_c,.error_d,.error_e").html("")
})

//跳回登录前地址
function goToUrl(){
	$.ajax({
		url:unescape(getParam("url")),
		success:function(){
			window.location.href = unescape(getParam("url"));
		},
		error:function(){
			window.location.href="/exam/pages/examinee/ex_enroll.html";
		}
	})
}
//用户协议
function protocol(){
	window.location.href="/member/user/protocol.html";
}
//提交表单
document.onkeydown = function(evt){
	var evt = window.event?window.event:evt;
	if(evt.keyCode==13){
		if(!$(".panel1").is(":hidden")){
			submitOk_a()
		}else if(!$(".panel2").is(":hidden")){
			submitOk_b()
		}else if(!$(".panel3").is(":hidden")){
			submitOk_c()
		}else if(!$(".panel4").is(":hidden")){
			submitOk_d()
		}
	}
}
//获取url 参数值
function getParam(name) {
    var search = document.location.search;
    var pattern = new RegExp("[?&]" + name + "\=([^&]+)", "g");
    var matcher = pattern.exec(search);
    var items = null;
    if (null != matcher) {
        try {
            items = decodeURIComponent(decodeURIComponent(matcher[1]));
        } catch (e) {
            try {
                items = decodeURIComponent(matcher[1]);
            } catch (e) {
                items = matcher[1];
            }
        }
    }
    return items;
};
function url(){
	if(getParam("url")!=null){
		return getParam("url");
	}else{
		return "";
	}
}

//打开登录窗口
function loginmodal(){
    $('#login-modal').modal({closeViaDimmer:false});
}