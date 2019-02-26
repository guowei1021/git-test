<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	    <title>试卷模板管理</title>
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
	
		<!-- 页面头部 -->
		<main>
    	 
    	<!-- 列表表格 -->
		<div id="table" class="am-u-sm-12" ">
			<div class="toolbar">
				<button class="add" value="增加" id="paper_add"></button>
			</div>
			<table></table>
		</div>
		<div style="clear:both;"></div>
		
		<!-- 试卷模板模态框:添加、修改 -->
		<div id="paper_add_model" onload="paper_add_load()" onclickOk="paper_add_ok()" onclickConsole="paper_no()">
			<div style="font-size:14;font-weight:bold;margin-top:20px;" class="pop-content">
				<div class="modal-title">
					<div id="title" style="font-size:18px;padding: 3px;color:#3bb4f2;font-weight:700;text-align: center;">试卷模板管理</div>
				</div>
				
				<div class="am-modal-bd">
					<form class="am-form am-form-horizontal">
					  <fieldset>
		
			    		<div class="am-form-group">
					      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="name">试卷模板名称: </label>
					      <input style="width:350px;height:30px;font-size: 12px;" type="text" id="name">
					    </div>
					    
					  </fieldset>
					</form>
				</div>
			</div>
			
			<!-- 试卷模板模态框:删除-->
			<div id="paper_del_model" onclickOk="paper_del_yes()" onclickConsole="paper_no()">
				<div style="font-size:12;margin-top:20px;" class="pop-content">你，确定要删除这条记录吗？</div>
			</div>
			
		</div>
		<!-- 页面底部 -->
		</main>
	</body>
	<script src="${pageContext.request.contextPath}/static/js/jquery/jquery.min.js"></script>
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
//var url=window.location.href;
//var exam_id = url.split("?")[1].split("&")[0].split("=")[1];
//var exam_name = decodeURI(url.split("?")[1].split("&")[1].split("=")[1]);


var exam_id = "${param.pid}";
var exam_name = "${param.pname}";

var paper_id = "";//全局变量，用于区分新增（新增时为空）、修改、删除（修改或删除后要置空）
function setPaperId(id){
	paper_id = id;
}


//模态框：加载
function paper_add_load(){
	//判断是增加还是修改
	if(paper_id ==""){
		
	}else{
		//回显数据
		$.ajax({
			url:"/exam/api/paper/"+paper_id+"?method=get",
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
function paper_add_ok(){
	$("#main").modal('close');//关闭模态框
	if(paper_id == ""){//新增
		var parm = {
			exam_id:exam_id,
			name:$('.content #name').val()
		};
		$.ajax({
			url:"/exam/api/paper?method=post",
	        type:"post",
	        dataType:"json",
	        data:$.toJSON(parm),
	        contentType:"application/json",
	        success:function(data){
	        	alert("新增试卷模板成功");
	        	table.render();
	        },
	        error:function(data){
	            alert(JSON.parse(data.responseText).errors[0].message);
	          }
        });
	}else{//修改
		var parm = {
				id:paper_id,
				name:$('.content #name').val(),
				exam_id:exam_id
		};
		$.ajax({
			url:"/exam/api/paper?method=put",
	        type:"post",
	        dataType:"json",
	        data:$.toJSON(parm),
	        contentType:"application/json",
	        success:function(data){
	        	alert("修改试卷模板成功");
	        	table.render();
	        },
	        error:function(data){
	            alert(JSON.parse(data.responseText).errors[0].message);
	          }
        });
	
	paper_id="";//置空id
	}
}

//模态框：删除确定
function paper_del_yes(){
	$("#main").modal('close');//关闭模态框
	$.ajax({
	    type: "post",
	 	url: "/exam/api/paper/"+paper_id+"?method=delete",
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
	paper_id="";//置空id
}

//模态框：取消
function paper_no(){
	$("#main").modal('close');//关闭模态框
	paper_id="";//置空id
}
		
//页面跳转：章节管理
function toChapterList(id,name){
	window.location.href="../chapter/chapterlist.jsp?pid=" + id + "&pname=" + encodeURI(name);
}

//页面跳转：试卷实例管理
function toPaperCaseList(id,name){
	window.location.href="../paper/paperCase_list.jsp?pid=" + id + "&pname=" + encodeURI(name) + "&pfrom=0";
}
		
//*********************************试卷模板列表**************************************
		
var arr = [
	{
		data : "no",
		title : '序号'
	},
	{
		data : "name",
		title : '试卷模板名称'
	},
	{
		data : null,
		title : "操作",
		sWidth:"25%",
		render : function(data, type, row) { // 返回自定义内容 /pro/src/main/webapp/jsp/rest/model.html  source
			 var buttonHtml = 	'<button  class="revise table_btn revise1" value="修改" onclick="setPaperId(\'' + row.id + '\')" style="float:left;margin-right:5px;"></button>'+
			 					'<button class="delete delete1 table_btn" id="'+ row.id +'" value="删 除" onclick="setPaperId(\'' + row.id + '\')" style="float:left;margin-right:5px;"></button>'+
			 					'<button class="am-btn am-btn-default am-btn-xs am-text-secondary am-icon-eye" onclick="toChapterList(\'' + row.id + '\',\'' + row.name + '\')" style="float:left;margin-right:5px;">章节管理</button>'+
			 					'<button class="am-btn am-btn-default am-btn-xs am-text-secondary am-icon-eye"  onclick="toPaperCaseList(\'' + row.id + '\',\'' + row.name + '\')" style="float:left;margin-right:5px;">查看试卷</button>';
			 return buttonHtml;
		}
	} 
];


var url="/exam/api/paper?method=getlist";
var page="pli"	//p代表页码   l 代表  每页显示多少条  i  代表 一共多少条，当前多少条	
var parm={exam_id:exam_id,query:"1"};//ajax请求的参数
var table=new DataGrid($('#table'),page,url,arr,function(rows){
		//对数据进行自定义显示
		for (var i = 0; i < rows.length; i++) {
			//添加序号
			rows[i].no=(i+1);
		}
		return rows;
});

table.setTitle(exam_name+"的试卷模板列表");
table.setParameters(parm);
table.setButtonEven("#paper_add", "#paper_add_model");//新增
table.setButtonEven(".revise1", "#paper_add_model");//修改
table.setButtonEven(".delete1", "#paper_del_model");//删除 
table.render();

			
	</script>
	
</html>