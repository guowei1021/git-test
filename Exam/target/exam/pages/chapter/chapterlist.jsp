<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	    <title>章节管理</title>
		<link href="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/static/css/table.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/static/css/style.css" rel="stylesheet">
		
<style>

.modal-title{
	border-bottom:1px solid #eef1f5;
	min-height:48px;
	margin-bottom:10px;
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
		<div id="table" class="am-u-sm-12" ">
			<div class="toolbar">
				<button class="am-btn am-btn-default am-btn-xs" id="chapter_add"><span class="add-icon" style="color:#5ab66b;">&nbsp;&nbsp;新增</span></button>
				<button class="am-btn am-btn-default am-btn-xs" id="sort" onClick="sort()"><span class="am-icon-sort" style="color:#5ab66b;">&nbsp;&nbsp;排序</span></button>
				<button class="am-btn am-btn-default am-btn-xs" style="display:none" id="saveSort" onClick="saveSort()"><span class="am-icon-sort" style="color:blue;">&nbsp;&nbsp;保存排序</span></button>
				<button class="am-btn am-btn-default am-btn-xs" style="display:none" id="cancelSort" onClick="cancelSort()"><span class="am-icon-sort" style="color:red;">&nbsp;&nbsp;取消排序</span></button>
				<div style="color:red;text-align:left;font-size:15px;display:none" id="tips">已开启排序模式，您可以直接拖动表格数据进行排序</div>
			</div>
			<table id="chapter_table"></table>
		</div>
		<div style="clear:both;"></div>
		
		<!-- 章节模态框:添加、修改 -->
		<div id="chapter_add_model" onload="chapter_add_load()" onclickOk="chapter_add_ok()" onclickConsole="chapter_no()">
			<div style="font-size:14;font-weight:bold;margin-top:20px;" class="pop-content">
				<div class="modal-title">
					<div id="title" style="font-size:18px;padding: 3px;color:#3bb4f2;font-weight:700;text-align: center;">章节管理</div>
				</div>
				
				<div class="am-modal-bd">
					<form class="am-form am-form-horizontal">
					  <fieldset>
		
			    		<div class="am-form-group">
					      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="chapter_name">章节名称： </label>
					      <input style="width:350px;height:30px;font-size: 12px;" type="text" id="chapter_name">
					    </div>
					    
					    <div class="am-form-group">
					      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="type">题目类型： </label>
					      <select style="width:350px;height:30px;font-size: 12px;" id="type">
							  <option value="0">单选题</option>
							  <option value="1">多选题</option>
						  </select>
					    </div>
					    
					    <div class="am-form-group">
					      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="chapter_grade">章节总分：</label>
					      <input style="width:350px;height:30px;font-size: 12px;" type="number" id="chapter_grade" >
					      <div style="color:red;font-size:12px;display:none" id="tips">该分数由章节策略分数自动汇总，不可修改</div>
					    </div>
					    
					  </fieldset>
					</form>
				</div>
			</div>
			
			<!-- 章节模态框:删除-->
			<div id="chapter_del_model" onclickOk="chapter_del_yes()" onclickConsole="chapter_no()">
				<div style="font-size:12;margin-top:20px;" class="pop-content">你，确定要删除这条记录吗？</div>
			</div>
			
		</div>
		
    </main>
	</body>
	<script src="${pageContext.request.contextPath}/static/js/jquery/jquery-1.7.1.min.js"></script>
	<script	src="${pageContext.request.contextPath}/static/js/jquery.json-2.2.js"></script>
	<script	src="${pageContext.request.contextPath}/static/js/amazeui/amazeui.ie8polyfill.min.js"></script>
	<script	src="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.js"></script>
	<script	src="${pageContext.request.contextPath}/static/js/amazeui/ie&html5.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/amazeui/amazeui.datatables.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/table/table.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/head.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/onlineexam.js"></script>
	<script src="${pageContext.request.contextPath}/static/js/jquery-ui.min.js"></script>
	<script type="text/javascript">
	$(function(){
		$(".down").css("background-color","rgba(255,255,255,0.3)")
	})
//******************************Function***********************************
var paper_id = "${param.pid}";
var paper_name = "${param.pname}";

var chapter_id = "";//全局变量，用于区分新增（新增时为空）、修改、删除（修改或删除后要置空）
function setChapterId(id){
	chapter_id = id;
}

//排序
function sort(){
	$('#sort').css("display","none");
	$('#saveSort').css("display","block");
	$('#cancelSort').css("display","block");
	$('#tips').css("display","block");
	
	var fixHelper = function(e, ui) {  
		//console.log(ui)   
		ui.children().each(function() {  
			$(this).width($(this).width()); //在拖动时，拖动行的cell（单元格）宽度会发生改变。在这里做了处理就没问题了   
		});  
		return ui;  
	};
	
    $("#chapter_table tbody").sortable({ //这里是talbe的tbody，绑定 了sortable
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
    
    $("#chapter_table tbody").sortable("enable");//开启拖动排序
}

//保存排序
function saveSort(){
	$("#chapter_table tbody").sortable('disable');//关闭拖动排序
	$('#sort').css("display","block");
	$('#saveSort').css("display","none");
	$('#cancelSort').css("display","none");
	$('#tips').css("display","none");
	
	var sortList = [];
	$("#chapter_table tbody tr").each(function(i){//遍历表格
		sortList.push($(this).children('td').eq(0).html())
	});
	
	if(sortList.length == $("#chapter_table tbody tr").length){
		var parm = {
				update:"1",
				paper_id:paper_id,
				sortList:sortList
			};
		//alert(JSON.stringify(parm))
		$.ajax({
			url:"/exam/api/chapter?method=put",
	        type:"post",
	        dataType:"json",
	        data:$.toJSON(parm),
	        contentType:"application/json",
	        success:function(data){
	        	alert("排序成功！");
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
	$("#chapter_table tbody").sortable('disable');
	$('#sort').css("display","block");
	$('#saveSort').css("display","none");
	$('#cancelSort').css("display","none");
	$('#tips').css("display","none");
	table.render();
}

//模态框：加载
function chapter_add_load(){
	//判断是增加还是修改
	if(chapter_id ==""){
		
	}else{
		//回显数据
		$.ajax({
			url:"/exam/api/chapter/"+chapter_id+"?method=get",
	        type:"post",
	        dataType:"json",
	        data:$.toJSON({parameters:""}),
	        contentType:"application/json",
	        success:function(data){
	        	//alert(JSON.stringify(data));
	        	$('.content #chapter_name').val(data.row.chapter_name);
	        	$('.content #chapter_grade').val(data.row.chapter_grade);
	        	//设置可读状态
	        	if (data.row.number > 0) {//说明章节下面有策略,将章节总分设置为只读状态
	        		$('.content #chapter_grade').attr("readonly","readonly");
	        		$('.content #tips').css("display","");
				}
	        	//更改章节题型选中状态
	        	$(".content #type option").each(function(){  //遍历所有option  
	                var type = $(this).val();   //获取option值   
	                if(type == data.row.type){
	                	this.selected = true;  //修改为选中状态
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
function chapter_add_ok(){
	$("#main").modal('close');//关闭模态框
	if(chapter_id == ""){//新增
		var parm = {
			paper_id:paper_id,
			chapter_name:$('.content #chapter_name').val(),
			chapter_grade:$('.content #chapter_grade').val(),
			type:$('.content #type').val()
		};
		$.ajax({
			url:"/exam/api/chapter?method=post",
	        type:"post",
	        dataType:"json",
	        data:$.toJSON(parm),
	        contentType:"application/json",
	        success:function(data){
	        	alert("新增章节成功！");
	        	table.render();
	        },
	        error:function(data){
	        	LoginNoAndError(data);
	            alert(JSON.parse(data.responseText).errors[0].message);
	          }
        });
	}else{//修改
		var parm = {
				update:"0",
				id:chapter_id,
				chapter_name:$('.content #chapter_name').val(),
				chapter_grade:$('.content #chapter_grade').val(),
				type:$('.content #type').val()
		};
		$.ajax({
			url:"/exam/api/chapter?method=put",
	        type:"post",
	        dataType:"json",
	        data:$.toJSON(parm),
	        contentType:"application/json",
	        success:function(data){
	        	alert("修改章节成功");
	        	table.render();
	        },
	        error:function(data){
	            alert(JSON.parse(data.responseText).errors[0].message);
	          }
        });
		chapter_id="";//置空id
	}
}

//模态框：删除确定
function chapter_del_yes(){
	$("#main").modal('close');//关闭模态框
	$.ajax({
	    type: "post",
	 	url: "/exam/api/chapter/"+chapter_id+"?method=delete",
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
	chapter_id = "";//置空id
}

//模态框：取消
function chapter_no(){
	$("#main").modal('close');//关闭模态框
	chapter_id="";//置空id
}
		
//页面跳转：章节策略管理
function toChapterPolicyList(id,name){
	window.location.href="../chapter/chapterpolicylist.jsp?pid=" + id + "&pname=" + encodeURI(name);
}
		
//*********************************章节列表**************************************
		
var arr = [
	{
		data : "sort",
		title : '序号'
	},
	{
		data : "chapter_name",
		title : '章节名称'
	},
	{
		data : "type",
		title : '章节题型'
	},
	{
		data : "chapter_grade",
		title : '章节总分'
	},
	{
		data : null,
		title : "操作",
		sWidth:"25%",
		render : function(data, type, row) { // 返回自定义内容 /pro/src/main/webapp/jsp/rest/model.html  source
			 var buttonHtml = 	'<button  class="revise table_btn revise1" value="修改" onclick="setChapterId(\'' + row.id + '\')" style="float:left;margin-right:5px;"></button>'+
			 					'<button class="delete delete1 table_btn" id="'+ row.id +'" value="删 除" onclick="setChapterId(\'' + row.id + '\')" style="float:left;margin-right:5px;"></button>'+
			 					'<button class="details table_btn details1" value="配置策略" onclick="toChapterPolicyList(\'' + row.id + '\',\'' + row.chapter_name + '\')" style="float:left;margin-right:5px;"></button>';
			 return buttonHtml;										
		}
	} 
];

var url="/exam/api/chapter?method=getlist";
var page="pli"	//p代表页码   l 代表  每页显示多少条  i  代表 一共多少条，当前多少条	
var parm={paper_id:paper_id,query:1};//ajax请求的参数
var table=new DataGrid($('#table'),page,url,arr,function(rows){
		//对数据进行自定义显示
		for (var i = 0; i < rows.length; i++) {
			//添加序号
			//rows[i].no=(i+1);
			//转换：类型
			if (rows[i].type=='0') {
				rows[i].type = '单选题';
			}else if (rows[i].type=='1') {
				rows[i].type = '多选题';
			}else{
				alert("存储的的题目类型有误")
		}
	}
		return rows;
});


table.setTitle(paper_name+"的章节列表");
table.setParameters(parm);
table.setButtonEven("#chapter_add", "#chapter_add_model");//新增
table.setButtonEven(".revise1", "#chapter_add_model");//修改
table.setButtonEven(".delete1", "#chapter_del_model");//删除 
table.render();
			
	</script>
	
</html>