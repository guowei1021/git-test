<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>科目列表</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/table.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<main>


<div id="subject_tbody" class="am-u-sm-12" >
	<div class="toolbar">
		<button class="add" id="subject_add" value="新增"></button>
	</div>
	<table></table>
</div>
<div style="clear:both"></div>

<!-- 科目模态框：新增、修改 -->
<div id="subject_add_model" onload="subject_add_load()" onclickOk="subject_add_yes()" onclickConsole="subject_no()">
	<div style="font-size:12;margin-top:20px;" class="pop-content">
		<div class="modal-title">科目详细信息</div>
		<div class="am-modal-bd">
			<form class="am-form am-form-horizontal">
			  <fieldset>

	    		<div class="am-form-group">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="name">科目名称: </label>
			      <input style="width:350px;height:30px;font-size: 12px;" type="text" id="name" placeholder="">
			    </div>
			    
			  </fieldset>
			</form>
		</div>
	</div>
</div>
<!-- 科目模态框：删除 -->
<div id="subject_del_model" onclickOk="subject_del_yes()" onclickConsole="subject_no()">
	<div style="font-size:12;margin-top:20px;" class="pop-content">你，确定要删除这条记录吗？</div>
</div>	






</main>
<script src="${pageContext.request.contextPath}/static/js/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/jquery/jquery-1.11.3.js"></script>
<script src="${pageContext.request.contextPath}/static/js/head.js"></script>
<script src="${pageContext.request.contextPath}/static/js/onlineexam.js"></script>
<script	src="${pageContext.request.contextPath}/static/js/jquery.json-2.2.js"></script>
<script	src="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/amazeui/amazeui.datatables.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/table/table.js"></script>
</body>

<script type="text/javascript">
$(function(){
	$(".down").css("background-color","rgba(255,255,255,0.3)")
})
//****************************所有科目的列表************************************
var subject_tbody_arr= [	
		{
			data : "no",
			title : '序号'
		},
		{
			data : "name",
			title : '科目名称'
		},
		{
			data : null,
			title : "操作",
			sWidth:"40%",
			render : function(data, type, row) { // 返回自定义内容 /pro/src/main/webapp/jsp/rest/model.html  source
				//alert(JSON.stringify(data));
				var buttonHtml = "<button class='revise table_btn revise1' value='修改' onclick='getSubjectId(\"" + row.id + "\")' style='float:left;margin-left:5px;'></button>"
							   + "<button class='delete table_btn delete1' value='删除' onclick='getSubjectId(\"" + row.id + "\")' style='float:left;margin-right:5px;'></button>"
							   + "<button class='am-btn am-btn-default am-btn-xs am-text-secondary am-icon-eye' onclick='toKnowledgeFromSubject(\"" + row.id + "\",\"" + row.name + "\")' style='float:left;margin-left:5px;'>相关知识点</button>"
							   + "<button class='am-btn am-btn-default am-btn-xs am-text-secondary am-icon-eye' onclick='toExamFromSubject(\"" + row.id + "\",\"" + row.name + "\")' style='float:left;margin-left:5px;'>考试信息</button>";
				return buttonHtml;										
			}
		} 
  ];// table的结构
var subject_tbody_param={query:"0"};//ajax请求的参数
var subject_tbody_table=new DataGrid(
		$('#subject_tbody'), //table的id
		"pli", //分页插件，可以任意组合以下三个字母或提供一个空串："p"代表页码，"l"代表 每页显示多少条，"i"代表 一共多少条，当前多少条。
		"/exam/api/subject?method=getlist", //ajax请求的url
		subject_tbody_arr,
		function(rows){//对数据进行自定义显示
			for(var i=0;i<rows.length;i++){
				//1.序号
				rows[i].no=(i+1);
			} 
			return rows;
		}
);
subject_tbody_table.setTitle("科目列表");
subject_tbody_table.setParameters(subject_tbody_param);
subject_tbody_table.setButtonEven("#subject_add", "#subject_add_model");//新增
subject_tbody_table.setButtonEven(".revise1", "#subject_add_model");//修改
subject_tbody_table.setButtonEven(".delete1", "#subject_del_model");//删除
subject_tbody_table.render();


//【科目增、删、改】**************************start*********************************
var subject_id="";//全局变量，用于区分新增（新增时为空）、修改、删除（修改或删除后要置空）
function getSubjectId(id){
	subject_id = id;//记录点
}

function subject_add_load(){//模态框打开后初始化数据
	//初始化下拉框、日期插件
	
	//如果是修改，要回显信息
   	if(subject_id!=""){
   		$.ajax({
   			url:"/exam/api/subject/"+subject_id+"?method=get",
   			type:"post",
   		    dataType:"json",
   		    contentType:"application/json",
   		    data:$.toJSON({"":""}),
   		    success:function(data){
   		    	//alert(JSON.stringify(data));
   		    	$(".content #name").val(data.row.name);
   		    },
   			error:function(data){
   				alert(JSON.parse(data.responseText).errors[0].message);
   			}
   		});
   	}
}

function subject_add_yes(){//提交
	if(subject_id==""){//新增提交
		var param = {
			name:$(".content #name").val()
		};
		$.ajax({
			url:"/exam/api/subject?method=post",
			type:"post",
		    dataType:"json",
		    contentType:"application/json",
		    data:$.toJSON(param),
		    success:function(data){
		    	alert("新增科目成功！");
		    	$("#main").modal('close');
		    	subject_tbody_table.render();	
		    },
			error:function(data){
				alert(JSON.parse(data.responseText).errors[0].message);
			}
		});
	}else{//修改提交
		var param = {
				operate:0,
				id:subject_id,
				name:$(".content #name").val()
		};
		$.ajax({
			url:"/exam/api/subject?method=put",
			type:"post",
		    dataType:"json",
		    contentType:"application/json",
		    data:$.toJSON(param),
		    success:function(data){
		    	alert("修改科目成功！");
		    	$("#main").modal('close');
		    	subject_tbody_table.render();	
		    },
			error:function(data){
				alert(JSON.parse(data.responseText).errors[0].message);
			}
		});
	}
	subject_id="";//置空id
}

function subject_del_yes(){//删除
	var param = {
			operate:1,
			id:subject_id
	};
	$.ajax({
		url:"/exam/api/subject?method=put",
		type:"post",
	    dataType:"json",
	    contentType:"application/json",
	    data:$.toJSON(param),
	    success:function(data){
	    	alert("删除科目成功！");
	    	$("#main").modal('close');
	    	subject_tbody_table.render();	
	    },
		error:function(data){
			alert(JSON.parse(data.responseText).errors[0].message);
		}
	});
	subject_id="";//置空id
}

function subject_no(){//取消
	subject_id="";//置空id
}

function toKnowledgeFromSubject(id,name){//跳转到知识点页面查看相关知识点
	//window.location.href="knowledge_list.jsp?pid=" + id + "&pname=" + encodeURI(name);
	window.location.href="knowledge_tree.jsp?pid=" + id + "&pname=" + encodeURI(name);
}

function toExamFromSubject(id,name){//跳转到考试页面查看考试表（只读）
	window.location.href="../exam/exam_list.jsp?pid=" + id + "&pname=" + encodeURI(name)+ "&pfrom=sub";
}
//【科目增、删、改】**************************end*********************************







//时间戳转日期
function getMyDate(str){  
    var oDate = new Date(str),  
    oYear = oDate.getFullYear(),  
    oMonth = oDate.getMonth()+1,  
    oDay = oDate.getDate(),  
    oHour = oDate.getHours(),  
    oMin = oDate.getMinutes(),  
    oSen = oDate.getSeconds(),  
    oTime = oYear +'-'+ getzf(oMonth) +'-'+ getzf(oDay);
    return oTime;  
};  
function getMyDateTime(str){  
    var oDate = new Date(str),  
    oYear = oDate.getFullYear(),  
    oMonth = oDate.getMonth()+1,  
    oDay = oDate.getDate(),  
    oHour = oDate.getHours(),  
    oMin = oDate.getMinutes(),  
    oSen = oDate.getSeconds(),  
    oTime = oYear +'-'+ getzf(oMonth) +'-'+ getzf(oDay) +' '+ oHour +':'+ oMin +':'+ oSen;  
    return oTime;  
};  
//补0操作  
function getzf(num){  
    if(parseInt(num) < 10){  
        num = '0'+num;  
    }  
    return num;  
}


</script>
</html>