<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>试题管理</title>

<link rel="stylesheet" href="../../static/js/amazeui/amazeui.datatables.min.css">
<link rel="stylesheet" href="../../static/js/amazeui/amazeui.min.css">
<link rel="stylesheet" href="../../static/css/table.css">
<link rel="stylesheet" href="../../static/css/style.css">
<link rel="stylesheet" href="../../static/imgUpload/imgUpload.css">

<script type="text/javascript" src="../../static/js/jquery/jquery-1.11.3.js"></script>
<script type="text/javascript" src="../../static/js/head.js"></script>
<script type="text/javascript" src="../../static/js/onlineexam.js"></script>
<script type="text/javascript" src="../../static/js/jquery.json-2.2.js"></script>
<script	type="text/javascript" src="../../static/js/amazeui/amazeui.ie8polyfill.min.js"></script>
<script	type="text/javascript" src="../../static/js/amazeui/amazeui.min.js"></script>
<script	type="text/javascript" src="../../static/js/amazeui/ie&html5.js"></script>
<script type="text/javascript" src="../../static/js/amazeui/amazeui.datatables.min.js"></script>
<script type="text/javascript" src="../../static/js/table/table.js"></script>
<script type="text/javascript" src="../../static/imgUpload/imgUpload.js"></script>
<script type="text/javascript" src="../../static/imgUpload/move.js"></script>

<style>
#viewmodal-options li{
	list-style-type: upper-alpha !important;
}
#viewmodal-knowledge li{
	list-style-type: disc !important;
}

.viewmodal{
	text-align:left;
	
}
.viewmodal-list{
	font-size:14px;
	font-weight:bold;
	background-color:#32c5d2;
}
table>tbody>tr>td:nth-child(2){
	max-width: 100px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

</style>
</head>
	
	<body>
		<main>
    	 
    	<!-- 列表表格 -->
		<div id="table" class="am-u-sm-12">
			<div class="toolbar">
				<button class="add" value="新增" id="question_add"></button>
			</div>
			<table></table>
		</div>
		<div style="clear:both;"></div>
		
				<!-- 题库模态框:添加、修改 -->
		<div id="question_add_model" onload="question_add_load()" onclickOk="question_add_ok()" onclickConsole="question_no()">
			<div style="font-size:14px;font-weight:bold;margin-top:20px;" class="pop-content">
				<div class="modal-title">
					<div id="title" style="font-size:18px;padding: 10px;color:#32c5d2;font-weight: 700;text-align: center;">题目管理</div>
				</div>
				
				<div class="am-modal-bd">
					<form class="am-form am-form-horizontal">
						<fieldset>
                       	
							<div class="am-form-group">
								<label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="topic">试题题干: </label>
								<input class="input-clear" style="width:350px;height:30px;font-size: 12px;" type="text" id="topic" >
							</div>
					    
							<div class="am-form-group">
								<label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="analysis">试题解析: </label>
								<input class="input-clear" style="width:350px;height:30px;font-size: 12px;" type="text" id="analysis" >
							</div>
					    
							<div class="am-form-group">
								<label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="knowledge">知识点： </label>
								<select style="width:350px;height:30px;font-size: 12px;" id="knowledge">
									<option value="" style="display:none;"></option>
								</select>
							</div>

							<div class="am-form-group">
								<label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="type">试题类型:： </label>
								<select style="width:350px;height:30px;font-size: 12px;" id="type" onChange="typeChange()">
									<option value="0">单选</option>
									<option value="1">多选</option>
								</select>
							</div>
					    
							<div class="am-form-group">
								<label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="level">难易程度： </label>
								<select style="width:350px;height:30px;font-size: 12px;" id="level">
									<option value="0">简单</option>
									<option value="1">中等</option>
									<option value="2">困难</option>
								</select>
							</div>

							<div class="am-form-group">
								<label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="file">题目图片： </label>
								<input type="file" name="file" id="file" style="width: 60px;" onchange="imgUpload(this)" value="" accept="image/jpg,image/jpeg,image/png,image/bmp" multiple />
								<span style="width: 100px;"><p id="imgTypeTips" style="line-height: 12px;font-size: 12px;text-align: left;">(上传支持格式jpg、jpeg、png、bmp)</p></span>
								<p id="imgUploadTips" style="display: none;line-height: 28px;font-size: 14px;text-align: left;">已达到最大上传数量</p>
							</div>

							<%--上传图片--%>
							<div class="img-box full">
								<section class=" img-section">
									<div class="z_photo upimg-div clear" style="height: auto;display: none" id="imgContainer">
										<!--<section class="up-section fl">
											<span class="up-span"></span>
											<img src="img/buyerCenter/a7.png" class="close-upimg">
											<img src="img/buyerCenter/3c.png" class="type-upimg" alt="添加标签">
											<img src="img/test2.jpg" class="up-img">
											<p class="img-namep"></p>
											<input id="taglocation" name="taglocation" value="" type="hidden">
											<input id="tags" name="tags" value="" type="hidden">
										</section>-->
										<%--<section class="z_file fl">
											<img src="../../static/imgUpload/img/a11.png" class="add-img">
											<input type="file" name="file" id="file" class="file" onchange="imgUpload(this)" value="" accept="image/jpg,image/jpeg,image/png,image/bmp" multiple />
										</section>--%>
									</div>
								</section>
							</div>
							<aside class="mask works-mask">
								<div class="mask-content">
									<p class="del-p ">您确定要删除这张图片吗？</p>
									<p class="check-p"><span class="del-com wsdel-ok" onclick="wsdel_ok()">确定</span><span class="wsdel-no" onclick="wsdel_no()">取消</span></p>
								</div>
							</aside>
					    
						</fieldset>
					</form>
				</div>
			</div>
			
			<!-- 题库模态框:删除-->
			<div id="question_del_model" onclickOk="question_del_yes()" onclickConsole="question_no()">
				<div style="font-size:12px;margin-top:20px;" class="pop-content">你，确定要删除这条记录吗？</div>
			</div>
			
		</div>
		
		<!-- view modal -->
		<div class="am-modal am-modal-no-btn" tabindex="-1" id="viewmodal">
		  <div class="am-modal-dialog" style="width:450px">
				<div class="modal-components">
					<div class="modal-title">
						<div style="font-size:18px;padding: 10px;color:#32c5d2;font-weight: 700;text-align: left;">
							试题预览
						</div>
					</div>

					<div>
						<div class="am-g">
	                        <div class="am-u-sm-12 ">
	                            <div class="viewmodal">
	                            	<div style="margin-bottom:1rem">
	                            		<div class="viewmodal-list" >试题题干</div>
	                            		<div id="viewmodal-topic" style="margin-left:10px"></div>
	                            	</div>
	                            		                            	
	                            	<div style="margin-bottom:1rem">
		                            	<div class="viewmodal-list">选项</div>
		                            	<div>
		                            		<ol type="A" style="margin:0rem;" id="viewmodal-options"></ol>
		                            	</div>
		                            		
	                            	</div>
	                            	
	                            	<div style="margin-bottom:1rem">
	                            		<div class="viewmodal-list">试题解析</div>
	                            		<div id="viewmodal-analysis" style="margin-left:10px">
	                            			  
		                            	</div>
	                            	</div>
	                            	
	                            	<div style="margin-bottom:1rem">
	                            		<div class="viewmodal-list">相关知识点</div>
	                            		<div>
		                            		<ul id="viewmodal-knowledge" style="margin-left: 25px;"></ul>
		                            	</div>
	                            	</div>


	                                <div class="am-form-group">
	                                    <div class="am-u-sm-3 am-u-sm-push-5">
	                                        <button type="button" class="am-btn am-btn-primary"  onclick="modalcancel()" >关闭</button>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
					</div>

				</div>
           
		  </div>
		</div>
		
		<!-- 页面底部 -->
		</main>
		
	</body>
	
	<script type="text/javascript">

/*=============================================global variable=============================================*/
    /* 1.申报记录id */
    var question_bank_id = getUrlPara("pid");
    var question_bank_name = getUrlPara("pname");
    console.log("question_bank_id:"+question_bank_id+",question_bank_name:"+question_bank_name);

	/*2.用于区分新增（新增时为空）、修改、删除（修改或删除后要置空）*/
    var question_id = "";
    var question_code = "";

/*=============================================Function=============================================*/
    /*1.正则获取Url参数*/
    function getUrlPara (key){
        var ret = location.search.match(new RegExp('(\\?|&)' + key + '=(.*?)(&|$)'));
        return ret && decodeURIComponent(ret[2]);
    }

    /*2.判断字符串是否为JSON格式*/
    function isJSON(str) {
        if (typeof str == 'string') {
            try {
                var obj=JSON.parse(str);
                if(typeof obj == 'object' && obj ){
                    return true;
                }else{
                    return false;
                }
            } catch(e) {
                console.log('error：'+str+'!!!'+e);
                return false;
            }
        }else{
            return false;
        }
    }

    /*3.为全局变量赋值*/
    function setQuestionId(id,question_code1){
        question_id = id;
        question_code = question_code1;
    }

    /*4.模态框：加载*/
    function question_add_load(){
        //判断是增加还是修改
        if(question_id == ""){

        }else{
            //回显数据
            $.ajax({
                url:"/exam/api/question/"+question_id+"?method=get",
                type:"post",
                dataType:"json",
                data:$.toJSON({parameters:""}),
                contentType:"application/json",
                success:function(data){
                    //修改题目类型
                    $(".content #type option").each(function(){  //遍历所有option
                        var type = $(this).val();   //获取option值
                        if(type == data.row.type){
                            this.selected = true;  //修改为选中状态
                            typeChange();//修改选项框
                        }
                    });
                    //修改题目难易程度
                    $(".content #level option").each(function(){ //遍历所有option
                        var level = $(this).val();   //获取option值
                        if(level == data.row.level){
                            this.selected = true;  //修改为选中状态
                        }
                    });
                    //修改知识点
                    var knowledge_ids = data.row.knowledges.split(',');
                    $(".content #knowledge option").each(function(){  //遍历所有知识点
                        var knowledge_id = $(this).val();   //获取option值
                        if($.inArray(knowledge_id,knowledge_ids)!=-1){
                            this.selected = true;  //修改为选中状态
                        }
                    });
                    //添加题干内容
                    $('.content #topic').val(data.row.topic);
                    //添加解析内容
                    $('.content #analysis').val(data.row.analysis);
                    //添加图片
					if (data.row.imgs) {
                        var imgs = JSON.parse(data.row.imgs);
                        for (var i = 0; i < imgs.length; i++) {
                            var imgContainer = $(".content #imgContainer");
                            imgContainer.show();
							var $section = $("<section class='up-section fl'>");
                            imgContainer.append($section);
                            var $span = $("<span class='up-span'>");
                            $span.appendTo($section);
                            var $img0 = $("<img class='close-upimg' onclick='del(this)'>");
                            $img0.attr("src","../../static/imgUpload/img/a7.png").appendTo($section);
                            var $img = $("<img class='up-img'>");
                            $img.attr("src",imgs[i].src);
                            $img.appendTo($section);
                            var $p = $("<p class='img-name-p'>");
                            $p.html(imgs[i].name).appendTo($section);
                        }
                    }
                },
                error:function(data){
                    alert(JSON.parse(data.responseText).errors[0].message);
                }
            });
        }
    }

    /*5.模态框：确定*/
    function question_add_ok(){
        $("#main").modal('close');//关闭模态框
		var imgJson = [];
		$("#imgContainer section").each(function () {
			var name = $(this).children("p:eq(0)").text();
			var src = $(this).children("img:eq(1)").attr("src");
			var img = '{"name":"'+name+'","src":"'+src+'"}';
			imgJson.push(img);
        });
		//console.log(imgJson);
        var parm = {
            id:question_id,
            question_bank_id:question_bank_id,
            question_code:question_code,
            knowledges:$('.content #knowledge option:selected').val(),
            type:$('.content #type option:selected').val(),
            level:$('.content #level option:selected').val(),
            topic:$('.content #topic').val(),
            analysis:$('.content #analysis').val(),
			imgs:"["+imgJson.join(",")+"]"
        };
        //alert(JSON.stringify(parm));
       $.ajax({
            url:"/exam/api/question?method=post",
            type:"post",
            dataType:"json",
            data:$.toJSON(parm),
            contentType:"application/json",
            success:function(data){
                table.render();
            },
            error:function(data){
                alert(JSON.parse(data.responseText).errors[0].message);
            }
        });
        question_id="";//置空id
        question_code="";
    }


    /*6.模态框：删除确定*/
    function question_del_yes(){
        $("#main").modal('close');//关闭模态框
        $.ajax({
            type: "post",
            url: "/exam/api/question/"+question_id+"?method=delete",
            dataType:"json",
            contentType : 'application/json;charset=utf-8',
            success: function(data){
                table.render();
            },
            error:function(data){
                alert(JSON.parse(data.responseText).errors[0].message);
                table.render();
            }
        });
        question_id="";//置空id
    }

    /*7.模态框：取消*/
    function question_no(){
        $("#main").modal('close');//关闭模态框
        question_id="";//置空id
        question_code="";
    }


    /*8.预览模态框关闭*/
    function modalcancel(){
        $('#modal').modal('close');
        $('#viewmodal').modal('close');
    }

    /*9.清空预览模态框内容*/
    function clearViewModal(){
        $('#viewmodal-topic').html();
        $('#viewmodal-analysis').html();
        $('#viewmodal-options').empty();
        $('#viewmodal-knowledge').empty();
    }

    /*10.题目类型变更，选项按钮变化，切换单选框与复选框*/
    function typeChange(){
        //获取题目类型
        var type = $('.content #type').val();
        if(type=="0"){
            $('input[name="option-button"]').attr('type','radio')
        }
        if(type=="1"){
            $('input[name="option-button"]').attr('type','checkbox')
        }
    }

    /*11.点击预览*/
    function details(id){
        //调用方法清空预览模态窗口
        clearViewModal();
        $.ajax({
            url:"/exam/api/question/"+id+"?method=get",
            type:"post",
            dataType:"json",
            data:$.toJSON({parameters:""}),
            contentType:"application/json",
            success:function(data){
                $('#viewmodal-topic').html(data.row.topic);//显示题干
                //显示解析
                var analysis = data.row.analysis || "该试题无解析";
                $('#viewmodal-analysis').html(analysis);

                //显示选项
                if(data.row.options == null || data.row.options == ""){
                    $('#viewmodal-options').append('<li>该试题无选项</li>');
                }else{
                    for (var i = 0; i < data.row.options.length; i++) {
                        if (data.row.options[i].is_true == 1) {
                            $('#viewmodal-options').append('<li>'+data.row.options[i].sort+':'+data.row.options[i].option_content+'<strong>√</strong></li>');
                        }else{
                            $('#viewmodal-options').append('<li>'+data.row.options[i].sort+':'+data.row.options[i].option_content+'</li>');
                        }
                    }
                }
                //显示知识点
                var knowledge_names = data.row.knowledge_names.split(',');
                //alert(knowledge_names);
                for (var i = 0; i < knowledge_names.length; i++) {
                    $("#viewmodal-knowledge").append("<li>"+knowledge_names[i]+"</li>");

                }
                //显示markdown
                /* $('#markdown').append(data.row.markdown); */
            },
            error:function(){
                alert("预览时，查询试题失败");
            }
        });
        $('#viewmodal').modal('open');
    }

    /*12.页面跳转：选项管理*/
    function toOptionList(id,type){
        window.location.href="../question/optionlist.jsp?pid=" + id + "&ptype=" + encodeURI(type);
    }

/*==============================页面加载完成==========================================*/
$(function(){
	//不知道干什么用的
    $(".down").css("background-color","rgba(255,255,255,0.3)")

	//初始化题库选项框内容
	$.ajax({
		url:"/exam/api/chapterPolicy?method=getlist",
	       type:"post",
	       dataType:"json",
	       data:$.toJSON({parameters:{query:"2"}}),
	       contentType:"application/json",
	       success:function(data){
	       	//alert(JSON.stringify(data));
	       	for (var i = 0; i < data.rows.length; i++) {
				//alert(JSON.stringify(data.rows[i]));
				$("#question_bank").append("<option value='"+data.rows[i].id+"'>"+data.rows[i].name+"</option>")
			}
	       	
	       },
	       error:function(data){
	           //alert(JSON.parse(data.responseText).errors[0].message);
	       }
		});
	
	//初始化知识点选项框内容
	$.ajax({
		url:"/exam/api/question?method=getlist",
	       type:"post",
	       dataType:"json",
	       data:$.toJSON({parameters:{query:"2"}}),
	       contentType:"application/json",
	       success:function(data){
	       	//alert(JSON.stringify(data));
	       	for (var i = 0; i < data.rows.length; i++) {
				//alert(JSON.stringify(data.rows[i]));
				$("#knowledge").append("<option value='"+data.rows[i].id+"'>"+data.rows[i].k_name+"</option>")
			}
	       	
	       },
	       error:function(data){
	           alert("查询知识点失败");
	       }
		});
})

/*=================================事件===============================================*/

/*=============================================init table=============================================*/
var arr = [
    {
        data : "no",
        title : '序号'
    },
    {
        data : "topic",
        title : '试题题干',
        sWidth:"40%"
    },
    {
        data : "type",
        title : '题目类型'
    },
    {
        data : "level",
        title : '难易程度'
    },
    {
        data : "status",
        title : '试题状态'
    },
    {
        data : null,
        title : "操作",
        sWidth:"30%",
        render : function(data, type, row) { // 返回自定义内容 /pro/src/main/webapp/jsp/rest/model.html  source
            var buttonHtml = 	'<button  class="revise table_btn revise1" value="修改" onclick="setQuestionId(\'' + row.id + '\',\'' + row.question_code + '\')" style="float:left;margin-right:5px;"></button>'+
                '<button class="delete delete1 table_btn" value="删除" onclick="setQuestionId(\'' + row.id + '\')" style="float:left;margin-right:5px;"></button>'+
                '<button class="am-btn am-btn-default am-btn-xs am-text-secondary am-icon-eye" onclick="toOptionList(\'' + row.id + '\',\'' + row.type + '\')" style="float:left;margin-right:5px;">选项管理</button>'+
                '<button class="am-btn am-btn-default am-btn-xs am-text-secondary am-icon-eye"  onclick="details(\'' + row.id + '\')" style="float:left;margin-right:5px;">预览</button>';
            return buttonHtml;
        }
    }
];


var url="/exam/api/question?method=getlist";
var page="pli"	//p代表页码   l 代表  每页显示多少条  i  代表 一共多少条，当前多少条
var parm={question_bank_id:question_bank_id,query:"1"};
var table=new DataGrid($('#table'),page,url,arr,function(rows){
    //对数据进行自定义显示
    for (var i = 0; i < rows.length; i++) {
        //添加序号
        rows[i].no=(i+1);
        //转换：难易程度
        if (rows[i].level== 0) {
            rows[i].level = '简单';
        }else if (rows[i].level=='1') {
            rows[i].level = '中等';
        }else if (rows[i].level=='2') {
            rows[i].level = '困难';
        }else{
            alert("存储的的题目难易程度有误")
        }
        //转换：类型
        if (rows[i].type=='0') {
            rows[i].type = '单选题';
        }else if (rows[i].type=='1') {
            rows[i].type = '多选题';
        }else{
            alert("存储的的题目类型有误")
        }
        //转换：试题状态
        if (rows[i].status=='1') {
            rows[i].status = '可用';
        }else if (rows[i].status=='2') {
            rows[i].status = '不可用，该试题无选项';
        }else if (rows[i].status=='3') {
            rows[i].status = '不可用，该试题无正确选项';
        }else if (rows[i].status=='4') {
            rows[i].status = '不可用，单选题正确选项过多';
        }else{
            alert("存储的的试题状态有误")
        }
    }
    return rows;
});

table.setTitle(question_bank_name+"试题列表");
table.setParameters(parm);
table.setButtonEven("#question_add", "#question_add_model");//新增
table.setButtonEven(".revise1", "#question_add_model");//修改
table.setButtonEven(".delete1", "#question_del_model");//删除
table.render();
	</script>
</html>