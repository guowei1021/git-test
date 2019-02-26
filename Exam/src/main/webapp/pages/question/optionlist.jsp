<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	    <title>选项管理</title>
		<link href="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/static/css/table.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/static/css/style.css" rel="stylesheet">
		
<style>

 table>tbody>tr>td{
	max-width: 100px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.toolbar button{
	float:left;
	margin-right:5px;
}

</style>

</head>
	<body>
	
		<main>
    	 
    	<!-- 列表表格 -->
		<div id="table" class="am-u-sm-12">
			<div class="toolbar">
				<div style="color:red;text-align:center;font-size:15px;display:none" id="tips">该试题尚无正确选项，不能被选用</div>
				<div style="color:red;text-align:center;font-size:15px;display:none" id="tips2">该试题为单选题，正确选项过多，不能被选用</div>
				<button class="am-btn am-btn-default am-btn-xs" id="option_add"><span class="add-icon" style="color:#5ab66b;">&nbsp;&nbsp;新增</span></button>
				<button class="am-btn am-btn-default am-btn-xs" id="sort" onClick="sort()"><span class="am-icon-sort" style="color:#5ab66b;">&nbsp;&nbsp;排序</span></button>
				<button class="am-btn am-btn-default am-btn-xs" style="display:none" id="saveSort" onClick="saveSort()"><span class="am-icon-sort" style="color:blue;">&nbsp;&nbsp;保存排序</span></button>
				<button class="am-btn am-btn-default am-btn-xs" style="display:none" id="cancelSort" onClick="cancelSort()"><span class="am-icon-sort" style="color:red;">&nbsp;&nbsp;取消排序</span></button>
				<div style="color:red;text-align:left;font-size:15px;display:none" id="tips3">已开启排序模式，您可以直接拖动表格数据进行排序</div>
			</div>
			<table id="option_table"></table>
		</div>
		<div style="clear:both;"></div>
		
		<!-- 选项模态框:添加、修改 -->
		<div id="option_add_model" onload="option_add_load()" onclickOk="option_add_ok()" onclickConsole="option_no()">
			<div style="font-size:14;font-weight:bold;margin-top:20px;" class="pop-content">
				<div class="modal-title">
					<div id="title" style="font-size:18px;padding: 3px;color:#3bb4f2;font-weight:700;text-align: center;">选项管理</div>
				</div>
				
				<div class="am-modal-bd">
					<form class="am-form am-form-horizontal">
					  <fieldset>
					    
					    <div class="am-form-group">
					      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="topic">选项内容: </label>
					      <input style="width:350px;height:30px;font-size: 12px;" type="text" id="option_content" >
					    </div>
					    
					    <div class="am-form-group">
					      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="is_true">选项是否正确: </label>
					      <span style="float: left;">正确&nbsp;<input type="radio" name="is_true" value="1"id="true"></span>
			          	  <span style="float: left;padding-left: 20px;">错误&nbsp;<input type="radio" name="is_true" value="0" id="false"></span>
					    </div>
					   
					  </fieldset>
					</form>
				</div>
			</div>
			
			<!-- 选项模态框:删除-->
			<div id="option_del_model" onclickOk="option_del_yes()" onclickConsole="option_no()">
				<div style="font-size:12;margin-top:20px;" class="pop-content">你，确定要删除这条记录吗？</div>
			</div>
			
		</div>
		<!-- 页面底部 -->
		</main>
	</body>
	<script src="${pageContext.request.contextPath}/static/js/jquery/jquery-1.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/jquery/jquery-1.11.3.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/head.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/onlineexam.js"></script>2W1`234
	<script	src="${pageContext.request.contextPath}/static/js/jquery.json-2.2.js"></script>
	<script	src="${pageContext.request.contextPath}/static/js/amazeui/amazeui.ie8polyfill.min.js"></script>
	<script	src="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.js"></script>
	<script	src="${pageContext.request.contextPath}/static/js/amazeui/ie&html5.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/amazeui/amazeui.datatables.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/table/table.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/jquery-ui.min.js"></script>
	<script type="text/javascript">
	$(function(){
		$(".down").css("background-color","rgba(255,255,255,0.3)")
	})
//******************************Function***********************************
var question_id = "${param.pid}";
var question_type = "${param.ptype}";

var option_id = "";//全局变量，用于区分新增（新增时为空）、修改、删除（修改或删除后要置空）
function setOptionId(id){
	option_id = id;
}

//排序
function sort(){
	$('#sort').css("display","none");
	$('#saveSort').css("display","block");
	$('#cancelSort').css("display","block");
	$('#tips3').css("display","block");
	
	var fixHelper = function(e, ui) {  
		//console.log(ui)   
		ui.children().each(function() {  
			$(this).width($(this).width()); //在拖动时，拖动行的cell（单元格）宽度会发生改变。在这里做了处理就没问题了   
		});  
		return ui;  
	};
	
    $("#option_table tbody").sortable({ //这里是talbe的tbody，绑定 了sortable
 	   cursor: "move", //拖动的时候鼠标样式 
        helper: fixHelper, //调用fixHelper   
        axis:"y",
        start:function(e, ui){  
            ui.helper.css({"background":"#fff"})//拖动时的行，要用ui.helper
            return ui;
        },  
        stop:function(e, ui){
            return ui;
        }  
   }).disableSelection();//防止选中文字
    
  	$("#option_table tbody").sortable("enable");//开启拖动排序
}

//保存排序
function saveSort(){
	$("#option_table tbody").sortable('disable');//关闭拖动排序
	$('#sort').css("display","block");
	$('#saveSort').css("display","none");
	$('#cancelSort').css("display","none");
	$('#tips3').css("display","none");
	
	var sortList = [];
	$("#option_table tbody tr").each(function(i){//遍历表格
		sortList.push($(this).children('td').eq(0).html())
	});
	
	if(sortList.length == $("#option_table tbody tr").length){
		var parm = {
				update:"1",
				question_id:question_id,
				sortList:sortList
			};
		//alert(JSON.stringify(parm))
		$.ajax({
			url:"/exam/api/option?method=put",
	        type:"post",
	        dataType:"json",
	        data:$.toJSON(parm),
	        contentType:"application/json",
	        success:function(data){
	        	table.render();
	        },
	        error:function(data){
	            alert(JSON.parse(data.responseText).errors[0].message);
	            table.render();
	          }
	    });
	}else{
		alert("排序有误，请刷新页面后重试");
	}
	
	
}

//取消排序
function cancelSort(){
	$("#option_table tbody").sortable('disable');
	$('#sort').css("display","block");
	$('#saveSort').css("display","none");
	$('#cancelSort').css("display","none");
	$('#tips3').css("display","none");
	table.render();
}


//模态框：加载
function option_add_load(){
	//判断是增加还是修改
	if(option_id ==""){
		
	}else{
		//回显数据
		$.ajax({
			url:"/exam/api/option/"+option_id+"?method=get",
	        type:"post",
	        dataType:"json",
	        data:$.toJSON({parameters:""}),
	        contentType:"application/json",
	        success:function(data){
	        	//alert(JSON.stringify(data));
	        	$('.content #option_content').val(data.row.option_content);
	        	//更改正确选项选中状态
	        	$(".content input[name='is_true']").each(function(){  
	                var is_true = $(this).val();  
	                if(is_true == data.row.is_true){
	                	this.checked='checked' //修改选中状态
	                }
	           	});
	        	
	        },
	        error:function(data){
	            alert(JSON.parse(data.responseText).errors[0].message);
	          }
        });
	}
	
}

//模态框：确定
function option_add_ok(){
	$("#main").modal('close');//关闭模态框
	if(option_id == ""){//新增
		var parm = {
			question_id:question_id,
			option_content:$('.content #option_content').val(),
			is_true:$(".content input[name='is_true']:checked").val()
		};
		$.ajax({
			url:"/exam/api/option?method=post",
	        type:"post",
	        dataType:"json",
	        data:$.toJSON(parm),
	        contentType:"application/json",
	        success:function(data){
	        	table.render(checkTrueOption());
	        },
	        error:function(data){
	            alert(JSON.parse(data.responseText).errors[0].message);
	          }
        });
	}else{//修改
		var parm = {
				update:"0",
				id:option_id,
				question_id:question_id,
				option_content:$('.content #option_content').val(),
				is_true:$(".content input[name='is_true']:checked").val()
		};
		$.ajax({
			url:"/exam/api/option?method=put",
	        type:"post",
	        dataType:"json",
	        data:$.toJSON(parm),
	        contentType:"application/json",
	        success:function(data){
	        	table.render(checkTrueOption());
	        },
	        error:function(data){
	            alert(JSON.parse(data.responseText).errors[0].message);
	          }
        });
		option_id="";//置空id
	}
}

//模态框：删除确定
function option_del_yes(){
	$("#main").modal('close');//关闭模态框
	$.ajax({
	 	url: "/exam/api/option/"+option_id+"?method=delete",
	    type: "post",
	    dataType:"json", 
	    contentType: 'application/json;charset=utf-8',
	    success: function(data){
	    	table.render(checkTrueOption());
	    }, 
	    error:function(data){
	    	alert(JSON.parse(data.responseText).errors[0].message);
          }
	});
	option_id="";//置空id
}

//模态框：取消
function option_no(){
	$("#main").modal('close');//关闭模态框
	option_id="";//置空id
}

//校验当前试题的正确选项，给出提示
function checkTrueOption(){
	$.ajax({
	    type: "post",
	 	url: "/exam/api/option?method=getlist",
	    dataType:"json", 
	    data:$.toJSON({"parameters":{question_id:question_id,query:"2"}}),
	    contentType: 'application/json;charset=utf-8',
	    success: function(data){
	    	if(data.rows[0].trueNumber == 0){
	    		$('#tips').css('display','block');
	    	}else{
	    		$('#tips').css('display','none');
	    	}
	    	if(data.rows[0].type == 0 && data.rows[0].trueNumber > 1){
	    		$('#tips2').css('display','block');
	    	}else{
	    		$('#tips2').css('display','none');
	    	}
	    },
	    error:function(data){
	    	alert("提示信息显示失败");
	    	
          }
	});
}
//*********************************试题选项列表**************************************

var arr = [
	{
		data : "sort",
		title : '序号'
	},
	{
		data : "option_content",
		title : '选项内容'
	},
	{
		data : "is_true",
		title : '是否正确'
	},
	{
		data : null,
		title : "操作",
		sWidth:"25%",
		render : function(data, type, row) { // 返回自定义内容 /pro/src/main/webapp/jsp/rest/model.html  source
			 var buttonHtml =   '<button  class="revise table_btn revise1" value="修改" onclick="setOptionId(\'' + row.id + '\')" style="float:left;margin-right:5px;"></button>'+ 
			 					'<button class="delete delete1 table_btn" id="'+ row.id +'" value="删 除" onclick="setOptionId(\'' + row.id + '\')" style="float:left;margin-right:5px;"></button>'
			 return buttonHtml;										
		}
	} 
];

var url="/exam/api/option?method=getlist";
var page="pli"	//p代表页码   l 代表  每页显示多少条  i  代表 一共多少条，当前多少条	
var parm={question_id:question_id,query:"1"};//ajax请求的参数
var table=new DataGrid($('#table'),page,url,arr,function(rows){
		//对数据进行自定义显示
		for (var i = 0; i < rows.length; i++) {
			//增加序号
			//rows[i].no=(i+1);
			//转换：是否为正确选项
			if (rows[i].is_true=='0') {
				rows[i].is_true = '错误';
			}else if (rows[i].is_true=='1') {
				rows[i].is_true = '正确';
			}else{
				alert("存储的的正确选项有误")
			}
		}
		return rows;
});


table.setTitle("试题选项列表");
table.setParameters(parm);
table.setButtonEven("#option_add", "#option_add_model");//新增
table.setButtonEven(".revise1", "#option_add_model");//修改
table.setButtonEven(".delete1", "#option_del_model");//删除 
table.render(checkTrueOption());
	</script>
	
</html>