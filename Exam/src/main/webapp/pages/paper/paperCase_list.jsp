<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>试卷实例列表</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/table.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/jquery.datetimepicker.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<main>


<div id="paperCase_tbody" class="am-u-sm-12" >
	<div class="toolbar">
		<button class="am-btn am-btn-default am-btn-xs" id="paperCase_add"><span class="add-icon" style="color:#5ab66b;">&nbsp;&nbsp;手动出卷</span></button>
		<button class="am-btn am-btn-default am-btn-xs" id="paperCase_auto_add"><span class="add-icon" style="color:#5ab66b;">&nbsp;&nbsp;自动出卷</span></button>
		<button class="am-btn am-btn-default am-btn-xs" id="paperCase_relation_add"><span class="add-icon" style="color:#5ab66b;">&nbsp;&nbsp;关联试卷</span></button>
		<button class="am-btn am-btn-default am-btn-xs" id="autoPapers_del"><span class="add-icon" style="color:#5ab66b;">&nbsp;&nbsp;清空自动卷</span></button>
	</div>
	<table></table>
</div>
<div style="clear:both"></div>

<!-- 000000000000000000000000000000000000静态试卷》试卷实例000000000000000000000000000000000000-->
<!-- 删除模态框 -->
<div id="paperCase_del_model" onclickOk="paperCase_del_yes()" onclickConsole="paperCase_no()">
	<div style="font-size:12;margin-top:20px;" class="pop-content">你，确定要删除这条记录吗？</div>
</div>
<!-- 自动出卷模态框 -->
<div id="paperCase_auto_add_model" onclickOk="paperCase_auto_add_yes()" onclickConsole="">
	<div style="font-size:12;margin-top:20px;" class="pop-content">系统会根据模版自动生成一套试卷</div>
</div>


<!-- 111111111111111111111111111111111111考试实例》试卷实例111111111111111111111111111111111111-->
<!-- 关联的模态框 -->
<div id="paperCase_relation_add_model" onload="paperCase_relation_add_load()" onclickOk="paperCase_relation_add_yes()" onclickConsole="">
	<div style="font-size:12;margin-top:20px;" class="pop-content">
		<div class="modal-title">关联试卷</div>
		<div class="am-modal-bd">
			<form class="am-form am-form-horizontal">
			  <fieldset>
			    
	    		<div class="am-form-group">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="paper_id">试卷模版: </label><!-- 静态试卷 -->
			      <select  style="width:350px;height:30px;font-size: 12px;" id="paper_id" onchange="follow(this.options[this.options.selectedIndex].value)">
				  </select>
			    </div>	    
			    			    
	    		<div class="am-form-group">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="paper_case_id">试卷: </label><!-- 静态试卷 -->
			      <select  style="width:350px;height:30px;font-size: 12px;" id="paper_case_id">
				  </select>
			    </div>	    			    
			    
			  </fieldset>
			</form>
		</div>
	</div>
</div>
<!-- 移除的模态框 -->
<div id="paperCase_remove_model" onclickOk="paperCase_remove_yes()" onclickConsole="paperCase_no()">
	<div style="font-size:12;margin-top:20px;" class="pop-content">你，确定要删除这条记录吗？</div>
</div>

<!-- 删除所有自动卷 模态框：删除 -->
<div id="autoPapers_del_model" onclickOk="autoPapers_del_yes()" onclickConsole="">
	<div style="font-size:12;margin-top:20px;" class="pop-content">你，确定要删除所有的自动卷吗？</div>
</div>	


</main>
<script src="${pageContext.request.contextPath}/static/js/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/jquery/jquery-1.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/head.js"></script>
<script src="${pageContext.request.contextPath}/static/js/onlineexam.js"></script>
<script	src="${pageContext.request.contextPath}/static/js/jquery.json-2.2.js"></script>
<script	src="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/amazeui/amazeui.datatables.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/table/table.js"></script>
<script src="${pageContext.request.contextPath}/static/js/jquery.datetimepicker.js"></script>
</body>

<script type="text/javascript">
$(function(){
	$(".down").css("background-color","rgba(255,255,255,0.3)")
})
var url=window.location.href;
var pid = url.split("?")[1].split("&")[0].split("=")[1];
var pname = decodeURI(url.split("?")[1].split("&")[1].split("=")[1]);
var pfrom = decodeURI(url.split("?")[1].split("&")[2].split("=")[1]);

//****************************页面预加载数据***********************************
//
if(pfrom=="0"){//***********静态试卷-->试卷实例************，只有[关联试卷]和[批量生成]两个按钮
	$("#paperCase_add").show();
	$("#paperCase_auto_add").show();
	$("#paperCase_relation_add").hide();
	$("#autoPapers_del").hide();
	
	var paperCase_tbody_arr= [	
		{
			data : "no",
			title : '序号'
		},
		{
			data : "name",
			title : '试卷名称'
		},
		{
			data : "count",
			title : '可用次数'
		},
		{
			data : "count_used",
			title : '已用次数'
		},
		{
			data : "type",
			title : '试卷类型'
		},
		{
			data : null,
			title : "操作",
			sWidth:"180px",
			render : function(data, type, row) { // 返回自定义内容 /pro/src/main/webapp/jsp/rest/model.html  source
				var buttonHtml = "<button class='revise table_btn' value='修改' onclick='paperCase_edit(\"" + row.id + "\")' style='float:left;margin-left:5px;'></button>"
							   + "<button class='delete table_btn delete1' value='删除' onclick='getPaperCaseId(\"" + row.id + "\")' style='float:left;margin-right:5px;'></button>";
				return buttonHtml;										
			}
		} 
	];// table的结构
	var paperCase_tbody_param={query:"1",paper_id:pid};//ajax请求的参数
	var paperCase_tbody_table=new DataGrid(
			$('#paperCase_tbody'), //table的id
			"pli", //分页插件，可以任意组合以下三个字母或提供一个空串："p"代表页码，"l"代表 每页显示多少条，"i"代表 一共多少条，当前多少条。
			"/exam/api/paperCase?method=getlist", //ajax请求的url
			paperCase_tbody_arr,
			function(rows){//对数据进行自定义显示
				for(var i=0;i<rows.length;i++){
					//1.序号
					rows[i].no=(i+1);
					//2.如果为空，则为不限
					if(rows[i].count==null){
						rows[i].count="不限";
					}
					//2.已用次数，如果为空，则为0
					if(rows[i].count_used==null){
						rows[i].count_used="0";
					}
					//3.试卷类型
					rows[i].type = (rows[i].type=="1" ? "手动卷":"自动卷");
				} 
				return rows;
			}
	);
	paperCase_tbody_table.setTitle(pname + " [试卷列表]");
	paperCase_tbody_table.setParameters(paperCase_tbody_param);
	paperCase_tbody_table.setButtonEven("#paperCase_auto_add", "#paperCase_auto_add_model");//自动出卷模态框
	paperCase_tbody_table.setButtonEven(".delete1", "#paperCase_del_model");//删除
	paperCase_tbody_table.render();

}else if(pfrom=="1"){//***********考试实例-->试卷实例************，只有[手动添加]和[自动生成]两个按钮
	$("#paperCase_add").hide();
	$("#paperCase_auto_add").hide();
	$("#paperCase_relation_add").show();
	$("#autoPapers_del").show();
	
	var paperCase_tbody_arr= [	
		{
			data : "no",
			title : '序号'
		},
		{
			data : "name",
			title : '试卷名称'
		},
		{
			data : "count",
			title : '可用次数'
		},
		{
			data : "count_used",
			title : '已用次数'
		},
		{
			data : "type",
			title : '试卷类型'
		},
		{
			data : null,
			title : "操作",
			sWidth:"180px",
			render : function(data, type, row) { // 返回自定义内容 /pro/src/main/webapp/jsp/rest/model.html  source
				var buttonHtml = "<button class='delete table_btn remove1' value='移除' onclick='getPaperCaseId(\"" + row.id + "\")' style='float:left;margin-right:5px;'></button>";
				return buttonHtml;										
			}
		} 
	];// table的结构
	var paperCase_tbody_param={query:"0",exam_case_id:pid};//ajax请求的参数
	var paperCase_tbody_table=new DataGrid(
			$('#paperCase_tbody'), //table的id
			"pli", //分页插件，可以任意组合以下三个字母或提供一个空串："p"代表页码，"l"代表 每页显示多少条，"i"代表 一共多少条，当前多少条。
			"/exam/api/paperCase?method=getlist", //ajax请求的url
			paperCase_tbody_arr,
			function(rows){//对数据进行自定义显示
				for(var i=0;i<rows.length;i++){
					//1.序号
					rows[i].no=(i+1);
					//2.已用次数，如果为空，则为0
					if(rows[i].count_used==null){
						rows[i].count_used="0";
					}
					//3.试卷类型
					rows[i].type = (rows[i].type=="1" ? "手动卷":"自动卷");
				} 
				return rows;
			}
	);
	paperCase_tbody_table.setTitle(pname + " [试卷列表]");
	paperCase_tbody_table.setParameters(paperCase_tbody_param);
	paperCase_tbody_table.setButtonEven("#paperCase_relation_add", "#paperCase_relation_add_model");//关联的模态框
	paperCase_tbody_table.setButtonEven(".remove1", "#paperCase_remove_model");//移除的模态框
	paperCase_tbody_table.setButtonEven("#autoPapers_del", "#autoPapers_del_model");//删除自动卷的模态框
	paperCase_tbody_table.render();

}




//****************************共用部分-->试卷实例************************************
var paperCase_id="";//全局变量
function getPaperCaseId(id){
	paperCase_id = id;//记录点
}
function paperCase_no(){//取消
	paperCase_id="";//置空id
}

//****************************静态试卷-->试卷实例************************************
//试卷实例删除事件
function paperCase_del_yes(){//删除试卷实例与考试实例的关系、删除试卷实例的详细、删除试卷实例
	var param = {
			operate:1,
			id:paperCase_id
	};
	$.ajax({
		url:"/exam/api/paperCase?method=put",
		type:"post",
	    dataType:"json",
	    contentType:"application/json",
	    data:$.toJSON(param),
	    success:function(data){
	    	alert("删除试卷实例成功！");
	    	$("#main").modal('close');
	    	paperCase_tbody_table.render();	
	    },
		error:function(data){
			alert(JSON.parse(data.responseText).errors[0].message);
		}
	});
	paperCase_id="";//置空id
}

//试卷实例修改事件
function paperCase_edit(id){
	window.location.href="paperCase_add.jsp?pid=" + pid + "&pname=" + encodeURI(pname) + "&qid=" + id;//修改
}

//手动出卷新增事件
$("#paperCase_add").click(function(){
	//如果没有章节不能手动出卷
	var param = {
	   	  "parameters":{"query":1,"paper_id":pid}
	};
	$.ajax({
		url:"/exam/api/chapter?method=getlist",
		type:"post",
		async:false,
	    dataType:"json",
	    contentType:"application/json",
	    data:$.toJSON(param),
	    success:function(data){
	    	//alert(JSON.stringify(data));
			if(data.rows.length>0){
				//有章节，那就去出卷子吧！
				window.location.href="paperCase_add.jsp?pid=" + pid + "&pname=" + encodeURI(pname) + "&qid=0";//新增
			}else{
				alert("没有章节不能手动出卷！");
			}
	    },
		error:function(data){
			alert(JSON.parse(data.responseText).errors[0].message);
		}
	});
})
//自动出卷事件
function paperCase_auto_add_yes(){
 	var param = {
			operate:2,
			paper_id:pid
	};
	$.ajax({
		url:"/exam/api/paperCase?method=put",
		type:"post",
	    dataType:"json",
	    contentType:"application/json",
	    data:$.toJSON(param),
	    success:function(data){
	    	alert("自动出卷成功！");
	    	$("#main").modal('close');
	    	paperCase_tbody_table.render();	
	    },
		error:function(data){
			alert(JSON.parse(data.responseText).errors[0].message);
		}
	});
}




//****************************考试实例-->试卷实例************************************
//关联按钮相关事件
var paper_case_id_first;
function paperCase_relation_add_load(){
	//根据考试实例id查询相关静态试卷模版
	var param = {
		   	  "parameters":{"query":2,"id":pid}
	   };
	$.ajax({
		url:"/exam/api/paperCase?method=getlist",
		type:"post",
		async:false,
	    dataType:"json",
	    contentType:"application/json",
	    data:$.toJSON(param),
	    success:function(data){
				$(".content #paper_id").html("");
				if(data.rows.length>0){
					paper_case_id_first = data.rows[0].id;
			    	for(var j=0;j<data.rows.length;j++){
			    		$(".content #paper_id").append(
				             	  "<option value='"
				             	  + data.rows[j].id
				             	  + "'>"
				             	  + data.rows[j].name
				             	  + "</option>"
						);
			    	}
				}
	    },
		error:function(data){
			alert(JSON.parse(data.responseText).errors[0].message);
		}
	});
	//根据上面选择的静态模版加载对应试卷
	var param2 = {
		   	  "parameters":{"query":1,"paper_id":paper_case_id_first}
	   };
	$.ajax({
		url:"/exam/api/paperCase?method=getlist",
		type:"post",
	    dataType:"json",
	    contentType:"application/json",
	    data:$.toJSON(param2),
	    success:function(data){
				$(".content #paper_case_id").html("");
				if(data.rows.length>0){
			    	for(var j=0;j<data.rows.length;j++){
			    		$(".content #paper_case_id").append(
				             	  "<option value='"
				             	  + data.rows[j].id
				             	  + "'>"
				             	  + data.rows[j].name
				             	  + "</option>"
						);
			    	}
				}
	    },
		error:function(data){
			alert(JSON.parse(data.responseText).errors[0].message);
		}
	});
	
}
function follow(v){
	//根据上面选择的静态模版加载对应试卷
	var param2 = {
		   	  "parameters":{"query":1,"paper_id":v}
	   };
	$.ajax({
		url:"/exam/api/paperCase?method=getlist",
		type:"post",
	    dataType:"json",
	    contentType:"application/json",
	    data:$.toJSON(param2),
	    success:function(data){
				$(".content #paper_case_id").html("");
				if(data.rows.length>0){
			    	for(var j=0;j<data.rows.length;j++){
			    		$(".content #paper_case_id").append(
				             	  "<option value='"
				             	  + data.rows[j].id
				             	  + "'>"
				             	  + data.rows[j].name
				             	  + "</option>"
						);
			    	}
				}
	    },
		error:function(data){
			alert(JSON.parse(data.responseText).errors[0].message);
		}
	});
}
function paperCase_relation_add_yes(){
	var param = {
			operate:3,
			exam_case_id:pid,
			paper_case_id:$(".content #paper_case_id").val()
		};
	$.ajax({
		url:"/exam/api/paperCase?method=put",
		type:"post",
		dataType:"json",
		contentType:"application/json",
		data:$.toJSON(param),
		success:function(data){
			alert("关联试卷成功！");
			$("#main").modal('close');
			paperCase_tbody_table.render();	
		},
		error:function(data){
			alert(JSON.parse(data.responseText).errors[0].message);
		}
	});
}

//移除按钮确定事件
function paperCase_remove_yes(){//删除试卷实例与考试实例的关系
	var param = {
			operate:4,
			exam_case_id:pid,
			paper_case_id:paperCase_id
		};
	$.ajax({
		url:"/exam/api/paperCase?method=put",
		type:"post",
		dataType:"json",
		contentType:"application/json",
		data:$.toJSON(param),
		success:function(data){
			alert("删除试卷成功！");
			$("#main").modal('close');
			paperCase_tbody_table.render();	
		},
		error:function(data){
			alert(JSON.parse(data.responseText).errors[0].message);
		}
	});
	paperCase_id="";//置空id
}

//删除所有自动卷事件
function autoPapers_del_yes(){
	var param = {
			operate:5,
			exam_case_id:pid,
			paper_case_id:paperCase_id
		};
	$.ajax({
		url:"/exam/api/paperCase?method=put",
		type:"post",
		dataType:"json",
		contentType:"application/json",
		data:$.toJSON(param),
		success:function(data){
			alert("删除试卷成功！");
			$("#main").modal('close');
			paperCase_tbody_table.render();	
		},
		error:function(data){
			alert(JSON.parse(data.responseText).errors[0].message);
		}
	});
}

















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
    oTime = oYear +'-'+ getzf(oMonth) +'-'+ getzf(oDay) +' '+ getzf(oHour) +':'+ getzf(oMin)/*  +':'+ getzf(oSen) */;  
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