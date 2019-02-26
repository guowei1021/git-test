<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	    <title>章节策略管理</title>
		<link href="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/static/css/table.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/static/css/style.css" rel="stylesheet">
		<%-- <link href="${pageContext.request.contextPath}/static/css/jquery.dropdown.min.css" rel="stylesheet"> --%>
		
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
		<div id="table" class="am-u-sm-12" ">
			<div class="toolbar">
				<button class="add" value="新增" id="chapterPolicy_add"></button>
			</div>
			<table></table>
		</div>
		<div style="clear:both;"></div>
		
		<!-- 章节策略模态框:添加、修改 -->
		<div id="chapterPolicy_add_model" onload="chapterPolicy_add_load()" onclickOk="chapterPolicy_add_ok()" onclickConsole="chapterPolicy_no()">
			<div style="font-size:14;font-weight:bold;margin-top:20px;" class="pop-content">
			
				<div class="modal-title">
					<div id="title" style="font-size:18px;padding: 3px;color:#3bb4f2;font-weight:700;text-align: center;">章节策略管理</div>
				</div>
				
				<div class="am-modal-bd">
					<form class="am-form am-form-horizontal">
					  <fieldset>
		
			    		<div class="am-form-group">
					      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="question_bank">选题题库： </label>
					      <select style="width:350px;height:30px;font-size: 12px;" id="question_bank">
					      	<option value="" style="display:none;"></option>
						  </select>
					    </div>
					    
					    <div class="am-form-group">
					      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="knowledge">知识点： </label>
					      <select style="width:350px;height:30px;font-size: 12px;" id="knowledge">
							  <option value="" style="display:none;"></option>
						  </select>
					    </div>
					    
					    <div class="am-form-group">
					      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="level">难易程度： </label>
					      <select style="width:350px;height:30px;font-size: 12px;" id="level">
							  <option value="" style="display:none;"></option>
							  <option value="0">简单</option>
							  <option value="1">中等</option>
							  <option value="2">困难</option>
						  </select>
					    </div>
					    
					    <div class="am-form-group">
					      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="number">试题数量: </label>
					      <input style="width:350px;height:30px;font-size: 12px;" type="number" id="number">
					    </div>
					    
					    <div class="am-form-group">
					      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="score">每题分值: </label>
					      <input style="width:350px;height:30px;font-size: 12px;" type="number" id="score">
					    </div>
		
					  </fieldset>
					</form>
				</div>
			
			</div>
			
			<!-- 章节策略模态框:删除-->
			<div id="chapterPolicy_del_model" onclickOk="chapterPolicy_del_yes()" onclickConsole="chapterPolicy_no()">
				<div style="font-size:12;margin-top:20px;" class="pop-content">你，确定要删除这条记录吗？</div>
			</div>
			
		</div>
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
	
	<%-- <script src="${pageContext.request.contextPath}/static/js/jquery.dropdown.min.js"></script> --%>
	<script type="text/javascript">
	$(function(){
		$(".down").css("background-color","rgba(255,255,255,0.3)")
	})
//******************************Function***********************************
var chapter_id = "${param.pid}";
var chapter_name = "${param.pname}";

var chapterPolicy_id = "";//全局变量，用于区分新增（新增时为空）、修改、删除（修改或删除后要置空）
function setChapterPolicyId(id){
	chapterPolicy_id = id;
}

$(function(){
	
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
	           alert("查询题库失败");
	       }
		});
	
	//初始化知识点选项框内容
	$.ajax({
		url:"/exam/api/chapterPolicy?method=getlist",
	       type:"post",
	       dataType:"json",
	       data:$.toJSON({parameters:{query:"3",chapter_id:chapter_id}}),
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

//模态框：加载
function chapterPolicy_add_load(){
	//判断是增加还是修改
	if(chapterPolicy_id ==""){
		
	}else{
		//回显数据
		$.ajax({
			url:"/exam/api/chapterPolicy/"+chapterPolicy_id+"?method=get",
	        type:"post",
	        dataType:"json",
	        data:$.toJSON({parameters:""}),
	        contentType:"application/json",
	        success:function(data){
	        	//alert(JSON.stringify(data));
	        	//修改题库选中状态
	        	var question_bank_id = data.row.question_bank_ids.split(',');
	        	$(".content #question_bank option").each(function(){ //遍历所有option  
	                var question_bank = $(this).val(); //获取option值   
	                if($.inArray(question_bank,question_bank_id)!=-1){
	                	this.selected = true;  //修改为选中状态
	                }
	           	});
	        	//修改知识点选中状态
	        	$(".content #knowledge option").each(function(){ //遍历所有option  
	                var knowledge = $(this).val(); //获取option值   
	                if(knowledge == data.row.knowledge_id){
	                	this.selected = true;  //修改为选中状态
	                }
	           	});
	        	//修改难易程度选中状态
	        	$(".content #level option").each(function(){ //遍历所有option  
	                var level = $(this).val(); //获取option值   
	                if(level == data.row.level){
	                	this.selected = true;  //修改为选中状态
	                }
	           	});
	        	//修改试题数量
	        	$(".content #number").val(data.row.number);
	        	//修改每题分数
	        	$(".content #score").val(data.row.score);
	        },
	        error:function(data){
	            alert(JSON.parse(data.responseText).errors[0].message);
	          }
        });
	}
	
}


//模态框：确定
function chapterPolicy_add_ok(){
	$("#main").modal('close');//关闭模态框
	if(chapterPolicy_id == ""){//新增
		var parm = {
			chapter_id:chapter_id,
			question_bank_ids:$('.content #question_bank option:selected').val(),
			knowledge_id:$('.content #knowledge option:selected').val(),
			level:$('.content #level option:selected').val(),
			number:$('.content #number').val(),
			score:$('.content #score').val()
		};
		//alert(JSON.stringify(parm));
		$.ajax({
			url:"/exam/api/chapterPolicy?method=post",
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
	}else{//修改
		var parm = {
				id:chapterPolicy_id,
				chapter_id:chapter_id,
				question_bank_ids:$('.content #question_bank option:selected').val(),
				knowledge_id:$('.content #knowledge option:selected').val(),
				level:$('.content #level option:selected').val(),
				number:$('.content #number').val(),
				score:$('.content #score').val()
			};
		$.ajax({
			url:"/exam/api/chapterPolicy?method=put",
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
		chapterPolicy_id="";//置空id
	}
}

//模态框：删除确定
function chapterPolicy_del_yes(){
	$("#main").modal('close');//关闭模态框
	$.ajax({
	    type: "post",
	 	url: "/exam/api/chapterPolicy/"+chapterPolicy_id+"?method=delete",
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
	chapterPolicy_id="";//置空id
}

//模态框：取消
function chapterPolicy_no(){
	$("#main").modal('close');//关闭模态框
	chapterPolicy_id="";//置空id
}

//遍历多选select，拼接被选中项
function getOptions(){
	
}

		
//*********************************章节策略列表**************************************
		
var arr = [
	{
		data : "no",
		title : '序号'
	},
	{
		data : "name",
		title : '选题题库'
	},
	{
		data : "k_name",
		title : '所属知识点'
	},
	{
		data : "level",
		title : '难易程度'
	},
	{
		data : "number",
		title : '题目数量'
	},
	{
		data : "score",
		title : '每题分值'
	},
	{
		data : null,
		title : "操作",
		sWidth:"25%",
		render : function(data, type, row) { // 返回自定义内容 /pro/src/main/webapp/jsp/rest/model.html  source
			 var buttonHtml = 	'<button  class="revise table_btn revise1" value="修改" onclick="setChapterPolicyId(\'' + row.id + '\')" style="float:left;margin-right:5px;"></button>'+
			 					'<button class="delete delete1 table_btn" id="'+ row.id +'" value="删 除" onclick="setChapterPolicyId(\'' + row.id + '\')" style="float:left;margin-right:5px;"></button>'
			 return buttonHtml;										
		}
	} 
];

var url="/exam/api/chapterPolicy?method=getlist";
var page="pli"	//p代表页码   l 代表  每页显示多少条  i  代表 一共多少条，当前多少条	
var parm={chapter_id:chapter_id,query:1};//ajax请求的参数
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
	}	
		return rows;
});

table.setTitle(chapter_name+"的章节策略列表");
table.setParameters(parm);
table.setButtonEven("#chapterPolicy_add", "#chapterPolicy_add_model");//新增
table.setButtonEven(".revise1", "#chapterPolicy_add_model");//修改
table.setButtonEven(".delete1", "#chapterPolicy_del_model");//删除 
table.render();

			
	</script>
	
</html>