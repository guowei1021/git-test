	var maxNumber = 60 ;	//图片最大数量
	var delParent;	//记录当前操作对象
	var defaults = {
		fileType	: ["jpg","jpeg","png","bmp"],   // 上传文件的类型
		fileSize	: 1024 * 1024 * 10                 // 上传文件的大小 10M
	};

	/*上传文件*/
    function imgUpload(aaa){
		var file = $(".content #file").get(0); //上传文件的input元素
		var imgContainer = $(".content #imgContainer"); //存放图片的父亲元素
		var fileList = file.files; //获取的图片文件
		var imgArr = [];
		//遍历得到的图片文件
		var numUp = imgContainer.find(".up-section").length;
		var totalNum = numUp + fileList.length;  //总的图片数量
		if(fileList.length > maxNumber || totalNum > maxNumber ){
			alert("上传图片总数目不可以超过"+maxNumber+"个，请重新选择");  //一次选择上传数量或者是图片总数也不可以超过最大值
		} else {
			//校验图片
			fileList = validateUp(fileList);
			//遍历上传文件，生成预览
			for(var i = 0;i<fileList.length;i++){
				(function (i) {
                    //var imgUrl = window.URL.createObjectURL(fileList[i]);
                    var reader = new FileReader();
                    reader.readAsDataURL(fileList[i]);
                    var $section = $("<section class='up-section fl loading'>");
                    imgContainer.append($section);
                    var $span = $("<span class='up-span'>");
                    $span.appendTo($section);
                    //删除按钮×
                    var $img0 = $("<img class='close-upimg' onclick='del(this)'>");
                    $img0.attr("src","../../static/imgUpload/img/a7.png").appendTo($section);
                    var $img = $("<img class='up-img up-opcity'>");
                    $img.appendTo($section);
                    var $p = $("<p class='img-name-p'>");
                    $p.html(fileList[i].name).appendTo($section);
                    /*var $input = $("<input id='taglocation' name='taglocation' value='' type='hidden'>");
                    $input.appendTo($section);
                    var $input2 = $("<input id='tags' name='tags' value='' type='hidden'/>");
                    $input2.appendTo($section);*/

                    reader.onload = function () {
                        $img.attr("src",reader.result);
                        $(".content .up-section").removeClass("loading");
                        $(".content .up-img").removeClass("up-opcity");
                    }
                })(i);
		   }
		}


		numUp = imgContainer.find(".up-section").length;
        if(numUp > 0){
            $(".content #imgContainer").show();
        }
		if(numUp >= maxNumber){
			$(".content #file").hide();
			$(".content #imgTypeTips").hide();
			$(".content #imgUploadTips").show();
		}
	};
	/*校验文件是否为图片*/
    function validateUp(files){
        var arrFiles = [];//替换的文件数组
        for(var i = 0, file; file = files[i]; i++){
            //获取文件上传的后缀名
            var newStr = file.name.split("").reverse().join("");
            if(newStr.split(".")[0] != null){
                var type = newStr.split(".")[0].split("").reverse().join("");
                console.log("type:"+type);
                if(jQuery.inArray(type, defaults.fileType) > -1){
                    // 类型符合，可以上传
                    if (file.size >= defaults.fileSize) {
                        alert('您上传的 '+ file.name +' 文件大小过大,单张图片大小不能超过 '+(defaults.fileSize)/1024/1024+' MB');
                    } else {
                        arrFiles.push(file);
                    }
                }else{
                    alert('您这个"'+ file.name +'"上传类型不符合');
                }
            }else{
                alert('您这个"'+ file.name +'"没有类型, 无法识别');
            }
        }
        return arrFiles;
    }


    $(".z_photo").delegate(".content .close-upimg","click",function(){
		console.log("aaa");
		$(".content .works-mask").show();
		delParent = $(".content #file").parent();
	});

    //打开删除确认框
    function del(del){
        console.log("bbb");
        event.preventDefault();
        event.stopPropagation();
        $(".content .works-mask").show();
        delParent = $(del).parent();
    };

    //确认删除
    function wsdel_ok(){
		$(".content .works-mask").hide();
		var numUp = delParent.siblings().length;
		//当前数量小于最大值
		if(numUp < maxNumber){
            $(".content #file").show();
            $(".content #imgTypeTips").show();
            $(".content #imgUploadTips").hide();
		}
		//没有图片
        if(numUp == 0){
            $(".content #imgContainer").hide();
        }
		 delParent.remove();
	};

    //取消删除
	function wsdel_no(){
		$(".content .works-mask").hide();
	};

	//图片转换为base64编码
	function convertImgToBase64(file){
        var reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = function(e){
            return reader.result;
		}
	}