<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>考试类目列表</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/table.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<main>


<div id="exam_table_div" class="am-u-sm-12" >
	<div class="toolbar">
		<button class="add" id="exam_add" value="新增"></button>
		<button class="add" id="subject_exam_add" value="新增"></button>
	</div>
	<table></table>
</div>
<div style="clear:both"></div>

<!-- 考试模态框：新增、修改 -->
<div id="exam_add_model" onload="exam_add_load()" onclickOk="exam_add_yes()" onclickConsole="exam_no()">
	<div style="font-size:12px;margin-top:20px;" class="pop-content">
		<div class="modal-title">考试类目信息</div>
		<div class="am-modal-bd">
			<form class="am-form am-form-horizontal">
			  <fieldset>

	    		<div class="am-form-group">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="name">考试类目名称: </label>
			      <input style="width:350px;height:30px;font-size: 12px;" type="text" id="name" placeholder="">
			    </div>

			  </fieldset>
			</form>
		</div>
	</div>
</div>

<!-- 科目与考试关系模态框：新增 -->
<div id="subject_exam_add_model" onload="subject_exam_add_load()" onclickOk="subject_exam_add_yes()" onclickConsole="subject_exam_no()">
	<div style="font-size:12px;margin-top:20px;" class="pop-content">
		<div class="modal-title">关联考试类目信息</div>
		<div class="am-modal-bd">
			<form class="am-form am-form-horizontal">
			  <fieldset>

	    		<div class="am-form-group">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="subject_exam_id">考试类目: </label>
				  <select  style="width:350px;height:30px;font-size: 12px;" id="subject_exam_id">
				  </select>
			    </div>
			    
			  </fieldset>
			</form>
		</div>
	</div>
</div>

<!-- 考试模态框：删除 -->
<div id="exam_del_model" onclickOk="exam_del_yes()" onclickConsole="exam_no()">
	<div style="font-size:12px;margin-top:20px;" class="pop-content">你，确定要删除这条记录吗？</div>
</div>	

<!-- 科目与考试关系模态框：删除 -->
<div id="subject_exam_del_model" onclickOk="subject_exam_del_yes()" onclickConsole="subject_exam_no()">
	<div style="font-size:12px;margin-top:20px;" class="pop-content">你，确定要删除这条记录吗？</div>
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
var url=window.location.href;
var pid="";
var pname="";
if(url.indexOf("pfrom=sub") > 0){
	pid = url.split("?")[1].split("&")[0].split("=")[1];
	pname = decodeURI(url.split("?")[1].split("&")[1].split("=")[1]);
}

//****************************备用数据加载start************************************
var ExamList;//保存所有考试
$.ajax({
	url:"/exam/api/exam?method=getlist",
	type:"post",
	async:false,
    dataType:"json",
    contentType:"application/json",
    data:$.toJSON({
    	"parameters":{"query":0}
    }),
    success:function(data){
    	ExamList = data.rows;
    },
	error:function(data){
		alert(JSON.parse(data.responseText).errors[0].message);
	}
});
//****************************备用数据加载end************************************



//****************************根据页面来源，展示不同数据start************************************
if(pid=="" && pname==""){//***直接进来的，显示全部考试，对考试进行CRUD操作***
	$("#exam_add").show();//显示新增考试按钮
	$("#subject_exam_add").hide();//隐藏新增科目与考试关系按钮
	
	var arr= [	
			{
				data : "no",
				title : '序号'
			},
			{
				data : "name",
				title : '考试类目名称'
			},
			{
				data : null,
				title : "操作",
				sWidth:"40%",
				render : function(data, type, row) { // 返回自定义内容 /pro/src/main/webapp/jsp/rest/model.html  source
					var buttonHtml = "<button class='revise table_btn revise1' value='修改' onclick='getExamId(\"" + row.id + "\")' style='float:left;margin-left:5px;'></button>"
								   + "<button class='delete table_btn delete1' value='删除' onclick='getExamId(\"" + row.id + "\")' style='float:left;margin-right:5px;'></button>"
								   + "<button class='am-btn am-btn-default am-btn-xs am-text-secondary am-icon-eye' onclick='toExamCase(\"" + row.id + "\",\"" + row.name + "\")' style='float:left;margin-left:5px;'>考试列表</button>"
								   + "<button class='am-btn am-btn-default am-btn-xs am-text-secondary am-icon-eye' onclick='toPaper(\"" + row.id + "\",\"" + row.name + "\")' style='float:left;margin-left:5px;'>试卷模版</button>";/* 静态试卷 */
					return buttonHtml;										
				}
			} 
	  ];// table的结构
	var param={query:"0"};//ajax请求的参数
	var table=new DataGrid(
			$('#exam_table_div'), //table的id
			"pli", //分页插件，可以任意组合以下三个字母或提供一个空串："p"代表页码，"l"代表 每页显示多少条，"i"代表 一共多少条，当前多少条。
			"/exam/api/exam?method=getlist", //ajax请求的url
			arr,
			function(rows){//对数据进行自定义显示
				for(var i=0;i<rows.length;i++){
					//1.序号
					rows[i].no=(i+1);
				} 
				return rows;
			}
	);
	table.setTitle(pname + " 考试类目");
	table.setParameters(param);
	table.setButtonEven("#exam_add", "#exam_add_model");//新增
	table.setButtonEven(".revise1", "#exam_add_model");//修改
	table.setButtonEven(".delete1", "#exam_del_model");//删除
	table.render();
	
}else{//***从某科目进来的，显示科目相关考试，对科目与考试的关系进行CRUD操作***
	$("#exam_add").hide(); //隐藏新增考试按钮
	$("#subject_exam_add").show();//显示新增科目与考试关系按钮
	
	var arr= [	
		{
			data : "no",
			title : '序号'
		},
		{
			data : "name",
			title : '考试类目名称'
		},
		{
			data : null,
			title : "操作",
			render : function(data, type, row) { // 返回自定义内容 /pro/src/main/webapp/jsp/rest/model.html  source
				var buttonHtml = "<button class='delete table_btn delete2' value='删除' onclick='getExamId(\"" + row.id + "\")' style='float:left;margin-right:5px;'></button>";
				return buttonHtml;										
			}
		} 
	];// table的结构
	var param={query:"1",subject_id:pid};//ajax请求的参数
	var table=new DataGrid(
			$('#exam_table_div'), //table的id
			"pli", //分页插件，可以任意组合以下三个字母或提供一个空串："p"代表页码，"l"代表 每页显示多少条，"i"代表 一共多少条，当前多少条。
			"/exam/api/exam?method=getlist", //ajax请求的url
			arr,
			function(rows){//对数据进行自定义显示
				for(var i=0;i<rows.length;i++){
					//1.序号
					rows[i].no=(i+1);
				} 
				return rows;
			}
	);
	table.setTitle(pname + " 相关考试类目列表");
	table.setParameters(param);
	table.setButtonEven("#subject_exam_add", "#subject_exam_add_model");//新增
	table.setButtonEven(".delete2", "#subject_exam_del_model");//删除
	table.render();
	
}
//****************************根据页面来源，展示不同数据end************************************





var exam_id="";//全局变量，用于区分新增（新增时为空）、修改、删除（修改｜删除｜取消后要置空）
function getExamId(id){
	exam_id = id;//记录点
}

//【考试增、删、改】**************************start*********************************
function exam_add_load(){//模态框打开后初始化数据
	//初始化下拉框、日期插件
	
	//如果是修改，要回显信息
   	if(exam_id!=""){
   		$.ajax({
   			url:"/exam/api/exam/"+exam_id+"?method=get",
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

function exam_add_yes(){//提交
	if(exam_id==""){//新增提交
		var param = {
			subject_id:pid,
			name:$(".content #name").val()
		};
		$.ajax({
			url:"/exam/api/exam?method=post",
			type:"post",
		    dataType:"json",
		    contentType:"application/json",
		    data:$.toJSON(param),
		    success:function(data){
		    	alert("新增考试类目成功！");
		    	$("#main").modal('close');
		    	table.render();	
		    },
			error:function(data){
				alert(JSON.parse(data.responseText).errors[0].message);
			}
		});
	}else{//修改提交
		var param = {
				operate:0,
				id:exam_id,
				name:$(".content #name").val()
		};
		$.ajax({
			url:"/exam/api/exam?method=put",
			type:"post",
		    dataType:"json",
		    contentType:"application/json",
		    data:$.toJSON(param),
		    success:function(data){
		    	alert("修改考试类目成功！");
		    	$("#main").modal('close');
		    	table.render();	
		    },
			error:function(data){
				alert(JSON.parse(data.responseText).errors[0].message);
			}
		});
	}
	exam_id="";//置空id
}

function exam_del_yes(){//删除
	var param = {
			operate:1,
			id:exam_id
	};
	$.ajax({
		url:"/exam/api/exam?method=put",
		type:"post",
	    dataType:"json",
	    contentType:"application/json",
	    data:$.toJSON(param),
	    success:function(data){
	    	alert("删除考试类目成功！");
	    	$("#main").modal('close');
	    	table.render();	
	    },
		error:function(data){
			alert(JSON.parse(data.responseText).errors[0].message);
		}
	});
	exam_id="";//置空id
}

function exam_no(){//取消
	exam_id="";//置空id
}

//【考试增、删、改】**************************end*********************************


//【科目与考试关系增、删】**************************start*********************************
function subject_exam_add_load(){//模态框打开后初始化数据
	//初始化下拉框（所有考试）
	$(".content #subject_exam_id").html("");
	for(var j=0;j<ExamList.length;j++){
		$(".content #subject_exam_id").append(
             	  "<option value='"
             	  + ExamList[j].id
             	  + "'>"
             	  + ExamList[j].name
             	  + "</option>"
		);
	}
}

function subject_exam_add_yes(){//提交
	var param = {
		exam_id:$(".content #subject_exam_id").val()
	};
	$.ajax({
		url:"/exam/api/subject/" + pid + "/exam?method=post",
		type:"post",
	    dataType:"json",
	    contentType:"application/json",
	    data:$.toJSON(param),
	    success:function(data){
	    	alert("新增成功！");
	    	$("#main").modal('close');
	    	table.render();	
	    },
		error:function(data){
			alert(JSON.parse(data.responseText).errors[0].message);
		}
	});
	exam_id="";//置空id
}

function subject_exam_del_yes(){//删除
	$.ajax({
		url:"/exam/api/subject/" + pid + "/exam/" + exam_id + "?method=delete",
		type:"post",
	    dataType:"json",
	    contentType:"application/json",
	    data:$.toJSON(param),
	    success:function(data){
	    	alert("删除成功！");
	    	$("#main").modal('close');
	    	table.render();	
	    },
		error:function(data){
			alert(JSON.parse(data.responseText).errors[0].message);
		}
	});
	exam_id="";//置空id
}

function subject_exam_no(){//取消
	exam_id="";//置空id
}

//【考试增、删、改】**************************end*********************************



//【其它】**************************start*******************************
function toExamCase(id,name){//跳转到考试实例页面
	window.location.href="examCase_list.jsp?pid=" + id + "&pname=" + encodeURI(name);
}
function toPaper(id,name){//跳转到考试静态试卷
	window.location.href="../paper/paperlist.jsp?pid=" + id + "&pname=" + encodeURI(name);
}
//【其它】**************************end*********************************




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