<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	    <title>题库管理</title>
		<link href="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/static/css/table.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/static/css/style.css" rel="stylesheet">
		
<style>

.modal-title{
	border-bottom:1px solid #eef1f5;
	min-height:48px;
	margin-bottom:10px;
}
</style>

</head>
	<body>
	
		<main>
    	 
    	<!-- 列表表格 -->
		<div id="table" class="am-u-sm-12">
			<div class="toolbar">
				<button class="add" value="新增" id="questionbank_add"></button>
			</div>
			<table></table>
		</div>
		<div style="clear:both;"></div>
		
		<!-- 题库模态框:添加、修改 -->
		<div id="questionbank_add_model" onload="questionbank_add_load()" onclickOk="questionbank_add_ok()" onclickConsole="questionbank_no()">
			<div style="font-size:14px;font-weight:bold;margin-top:20px;" class="pop-content">
				<div class="modal-title">
					<div id="title" style="font-size:18px;padding: 3px;color:#3bb4f2;font-weight:700;text-align: center;">题库管理</div>
				</div>
				
				<div class="am-modal-bd">
					<form class="am-form am-form-horizontal">
					  <fieldset>
		
			    		<div class="am-form-group">
					      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="name">题库名称: </label>
					      <input style="width:350px;height:30px;font-size: 12px;" type="text" id="name">
					    </div>
					    
			    		<div class="am-form-group">
					      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="remark">题库说明: </label>
					      <input style="width:350px;height:30px;font-size: 12px;" type="text" id="remark">
					    </div>
					    
					  </fieldset>
					</form>
				</div>
			</div>
			
			<!-- 题库模态框:删除-->
			<div id="questionbank_del_model" onclickOk="questionbank_del_yes()" onclickConsole="questionbank_no()">
				<div style="font-size:12px;margin-top:20px;" class="pop-content">你，确定要删除这条记录吗？</div>
			</div>
			
		</div>
		<!-- 页面底部 -->
		</main>
	</body>
	<script src="${pageContext.request.contextPath}/static/js/jquery/jquery-1.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/jquery/jquery-1.11.3.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/head.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/onlineexam.js"></script>
	<script	src="${pageContext.request.contextPath}/static/js/jquery.json-2.2.js"></script>
	<script	src="${pageContext.request.contextPath}/static/js/amazeui/amazeui.ie8polyfill.min.js"></script>
	<script	src="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.js"></script>
	<script	src="${pageContext.request.contextPath}/static/js/amazeui/ie&html5.js"></script>	
	<script src="${pageContext.request.contextPath}/static/js/amazeui/amazeui.datatables.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/table/table.js"></script>
	<script type="text/javascript">
	$(function(){
		$(".down").css("background-color","rgba(255,255,255,0.3)")
	})
//******************************Function***********************************
var questionbank_id = "";//全局变量，用于区分新增（新增时为空）、修改、删除（修改或删除后要置空）
function setQuestionbankId(id){
	questionbank_id = id;
}


//模态框：加载
function questionbank_add_load(){
	//判断是增加还是修改
	if(questionbank_id ==""){
		
	}else{
		//回显数据
		$.ajax({
			url:"/exam/api/questionBank/"+questionbank_id+"?method=get",
	        type:"post",
	        dataType:"json",
	        data:$.toJSON({parameters:""}),
	        contentType:"application/json",
	        success:function(data){
	        	//alert(JSON.stringify(data));
	        	$('.content #name').val(data.row.name);
	        	$('.content #remark').val(data.row.remark);
	        },
	        error:function(data){
	            alert(JSON.parse(data.responseText).errors[0].message);
	          }
        });
	}
	
}


//模态框：确定
function questionbank_add_ok(){
	$("#main").modal('close');//关闭模态框
	if(questionbank_id == ""){//新增
		var parm = {
			name:$('.content #name').val(),
			remark:$('.content #remark').val()
		};
		$.ajax({
			url:"/exam/api/questionBank?method=post",
	        type:"post",
	        dataType:"json",
	        data:$.toJSON(parm),
	        contentType:"application/json",
	        success:function(data){
	        	alert("新增题库成功！");
	        	table.render();
	        },
	        error:function(data){
	            alert(JSON.parse(data.responseText).errors[0].message);
	          }
        });
	}else{//修改
		var parm = {
				id:questionbank_id,
				name:$('.content #name').val(),
				remark:$('.content #remark').val()
		};
		$.ajax({
			url:"/exam/api/questionBank?method=post",
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
		questionbank_id="";//置空id
	}
}

//模态框：删除确定
function questionbank_del_yes(){
	$("#main").modal('close');//关闭模态框 
	$.ajax({
	    type: "post",
	 	url: "/exam/api/questionBank/"+questionbank_id+"?method=delete",
	    dataType:"json", 
	    contentType : 'application/json;charset=utf-8',
	    success: function(data){
	    	alert("删除成功");
	    	table.render();
	    }, 
	    error:function(data){
	    	alert(JSON.parse(data.responseText).errors[0].message);
	    	table.render();
          }
	});
	questionbank_id="";//置空id
}

//模态框：取消
function questionbank_no(){
	$("#main").modal('close');//关闭模态框
	questionbank_id="";//置空id
}
		
//页面跳转：试题管理
function toQuestionList(id,name){
	window.location.href="../question/questionlist.jsp?pid=" + id + "&pname=" + encodeURI(name);
}
		
//*********************************题库列表**************************************
		
var arr = [
	{
		data : "no",
		title : '序号'
	},
	{
		data : "name",
		title : '题库名称'
	},
	{
		data : "remark",
		title : '题库说明'
	},
	{
		data : "questionNumber",
		title : '试题数量'
	},
	{
		data : null,
		title : "操作",
		sWidth:"25%",
		render : function(data, type, row) { // 返回自定义内容 /pro/src/main/webapp/jsp/rest/model.html  source
			 var buttonHtml = 	'<button  class="revise table_btn revise1" value="修改" onclick="setQuestionbankId(\'' + row.id + '\')" style="float:left;margin-right:5px;"></button>'+
			 					'<button class="delete delete1 table_btn" id="'+ row.id +'" value="删 除" onclick="setQuestionbankId(\'' + row.id + '\')" style="float:left;margin-right:5px;"></button>'+
			 					'<button class="details table_btn details1" value="试题管理" onclick="toQuestionList(\'' + row.id + '\',\'' + row.name + '\')" style="float:left;margin-right:5px;"></button>';
			 return buttonHtml;										
		}
	} 
];

var url="/exam/api/questionBank?method=getlist";
var page="pli"	//p代表页码   l 代表  每页显示多少条  i  代表 一共多少条，当前多少条	
var parm={query:"0"};//ajax请求的参数
var table=new DataGrid($('#table'),page,url,arr,function(rows){
		//对数据进行自定义显示
		for (var i = 0; i < rows.length; i++) {
			//添加序号
			rows[i].no=(i+1);
		}
		return rows;
});

table.setTitle("题库列表");
table.setParameters(parm);
table.setButtonEven("#questionbank_add", "#questionbank_add_model");//新增
table.setButtonEven(".revise1", "#questionbank_add_model");//修改
table.setButtonEven(".delete1", "#questionbank_del_model");//删除 
table.render();

			
	</script>
	
</html>