var funcitonname;
function fileUpload(url,successCallback,pcElement,formname){	
	funcitonname=successCallback;
	var flag = IsPC(); //true为PC端，false为手机端
	if(flag==true){//PC端
		if(formname.val()==""){
			alertOpen("请选择文件再上传")
		}else{
			
			var option = {
					url : url,
					dataType : 'text',
					clearForm : false,
					headers : {
						"ClientCallMode" : "ajax"
					}, //添加请求头部
					success : function(data) {
						var str = JSON.parse(data);
						successCallback(str);
					},
					error : function(data) {
						uploadFail();
					}
			};
			pcElement.ajaxSubmit(option);
		}
	}else if(flag==false){//手机端
		var ruixin = new RuixinApi();
		//var str = encodeURI("http://mgt.caq.org.cn"+url);//正式
		//var str = encodeURI("http://mgt-test.caq.org.cn"+url);//测试
		var str = encodeURI("http://mgt.caq.org.cn"+url);//正式
		var params = {"url":str,"success":"uploadSuccess","fail":"uploadFail"};
		ruixin.selectResourceAndUpload(params);
	}
	
}


//上传成功
function uploadSuccess(data) {
	var xx=eval(data.data);
	$(".nty_saving").css("display","none")   
	$(".nty_saving span").text("保存中");
	funcitonname(xx.data);
}
//上传失败
function uploadFail(data) {
	alert("6666")
	$(".nty_saving").css("display","none")   
	$(".nty_saving span").text("保存中")
	alertOpen("上传失败,请刷新后重试");
}
//上传中
function uploadPercent() {
	$(".nty_saving span").text("文件正在上传中")
	$(".nty_saving").css("display","block")
}

//判断PC端或者手机端
function IsPC() {
    var userAgentInfo = navigator.userAgent;
    var Agents = ["Android", "iPhone",
                "SymbianOS", "Windows Phone",
                "iPad", "iPod"];
    var flag = true;
    for (var v = 0; v < Agents.length; v++) {
        if (userAgentInfo.indexOf(Agents[v]) > 0) {
            flag = false;
            break;
        }
    }
    return flag;
}
 
