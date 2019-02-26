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
				+'<li><a href="/rs/reviewmanage/review_work_resume.jsp" target="rightFrame" class="seexpertre"  style="font-size: 12px">专家评审</a></li>'
				+'<li><a href="/exam/pages/examinee/apply-exam-list.jsp"  target="rightFrame" class="seonlineexam" style="border-right: 1px solid #ccc;font-size: 12px">在线考试</a></li>'
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
	$("body").append(
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
//跳转登录
function loginmodal(){
	window.location.href = "/member/login/login.jsp?url=" + escape(window.location.href)
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
