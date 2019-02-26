$(function() {
	if (self == top) {
		//头部
		var topPage=$("#topPage");
		var footPage=$("#footPage");
		//在线考试
		var onlineexamWrapper=$('<div class="wrapper exam-wrapper"></div>'); 
		var onlineexamHead=$('<div class="head-wrapper"></div>'); 
		var onlineexamClearfix=$('<div class="main clearfix">'
								+'<div class="logo left">'
									+'<a href="#"><img src="../../static/images/logo_exam.png" title="中国质量协会在线考试" /></a>'
								+'</div>'
							+'</div>'); 
		var onlineexamnav=$('<div class="nav-wrapper">'
				+'<ul class="nav main">'
				+'<li><a href="/exam/pages/examinee/apply-exam-list.jsp" target="">考试报名</a></li>'
				+'<li><a href="/exam/pages/examinee/exam-list.jsp"  target="">参加考试</a></li>'
				+'<li><a href="/exam/pages/examinee/exam-history.jsp"  target="">考试记录</a></li>'
			+'</ul>'
		+'</div>');  
		
		onlineexamHead.append(onlineexamClearfix);
		onlineexamHead.append(onlineexamnav);
		onlineexamWrapper.append(onlineexamHead);
		topPage.append(onlineexamWrapper);
		//在线考试按钮被选中
		$(".act-list li a.seonlineexam").addClass("selected")
		//顶部导航切换
		$(".nav li a").click(function(){
			$(".nav li a.selected").removeClass("selected")
			$(this).addClass("selected");
		})	
		
	    
		
		
		}
	            //清除浮动
	topPage.append('<div style="clear:both;"></div>')
	footPage.prepend('<div style="clear:both;"></div>')
	
	
	
    })
  