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
<style>
	table tr td {line-height: 30px;}
	.tt {width:800px;background-color:#d1edfc;border-radius:5px 0px 0px 0px;border:1px solid #3bb4f2;word-break:keep-all;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;}
	.jj {background-color:#fcd1e2;border-radius:0px 0px 0px 5px;border:1px solid #f23b86;}
</style>
<body>
<main>

<div style="padding:20px 50px 20px 50px;">

	<!-- 1.大标题 -->
	<div style="font-size:16px;color:#19A97B;font-weight:700px;text-align:left;">
		试卷详情
	</div>
  	<hr>
  	
  	<!-- 2.基本信息 -->
 	<div style="font-size: 14px;font-weight:bold;margin-top: 10px;margin-bottom: 10px;">
 		<td>▶&nbsp;&nbsp;基本信息</td>
 	</div>
  	<table class="am-form" style="margin-left: 20px;">
  		<tr style="height: 50px;">
  			<td style="width: 75px;">试卷名称:</td>
  			<td><input class="am-radius" style="width:350px;height:30px;font-size: 12px;" type="text" id="name" placeholder=""></td>
  		</tr>
<!--   		<tr>
  			<td style="width: 75px;">可用次数: </td>
  			<td><input class="am-radius" style="width:350px;height:30px;font-size: 12px;" type="text" id="count" placeholder="默认没有限制"></td>
  		</tr> -->
  	</table>
  	
  	<!-- 3.题目信息 -->
 	<div style="font-size: 14px;font-weight:bold;margin-top: 20px;margin-bottom: 10px;">
 		<td>▶&nbsp;&nbsp;题目信息</td>
 	</div>
 	<div id="chapter_zone"></div>
 	<div style="font-size: 12px;font-weight:bold;margin-top: 10px;">
 		<button class="am-btn am-btn-success am-radius am-btn-xs" onclick="paperCaseSubmit()">保存试卷</button>
 	</div>
 	
</div>


<!-- 题目模态框 -->
<div id="question_add_model" onload="question_add_load()" onclickOk="question_add_yes()" onclickConsole="question_add_no()">
	<div style="font-size:12;margin-top:20px;" class="pop-content">
		<div class="modal-title">题目添加</div>
		<div class="am-modal-bd">
			<form class="am-form am-form-horizontal">
			  <fieldset>
			    
	    		<div class="am-form-group">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="question_bank_id">题库: </label>
			      <select style="width:320px;height:30px;font-size: 12px;" id="question_bank_id" onchange="follow(this.options[this.options.selectedIndex].value)" >
				  </select>
			    </div>
			    			    
	    		<div class="am-form-group">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="question_id">题目: </label>
			      <select style="width:320px;height:30px;font-size: 12px;" id="question_id">
				  </select>
			    </div>  			    
			    
			  </fieldset>
			</form>
		</div>
	</div>
</div>

<!-- 附加无用 -->
<div id="t3" style="display:none;"><table></table></div>


</main>
<script src="${pageContext.request.contextPath}/static/js/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/jquery/jquery-1.11.3.js"></script>
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
var paper_id = url.split("?")[1].split("&")[0].split("=")[1];
var pname = url.split("?")[1].split("&")[1].split("=")[1];
var qid = url.split("?")[1].split("&")[2].split("=")[1];//"0"代表新增

//****************************预加载start*********************************


//****************************新增start***********************************
//1.先根据试卷模版读取章节信息
var param = {
	   	  "parameters":{"query":1,"paper_id":paper_id}
   };
$.ajax({
	url:"/exam/api/chapter?method=getlist",
	type:"post",
	async:false,
    dataType:"json",
    contentType:"application/json",
    data:$.toJSON(param),
    success:function(data){
    	//alertOpen(JSON.stringify(data));
		$("#chapter_zone").html("");
		if(data.rows.length>0){
			for(var j=0;j<data.rows.length;j++){
				var type = (data.rows[j].type=="0" ? "单选题":"多选题");
		    	$("#chapter_zone").append("<div style='padding-left: 20px;margin-top: 10px;'>"
		    		 + "<div>章节名称：<span style='color:red;display:inline-block;margin-right:20px;'>" + data.rows[j].chapter_name 
		    		 + "</span>章节分数：<span style='color:red;display:inline-block;margin-right:20px;'>" + data.rows[j].chapter_grade 
		    		 + "</span>章节题型：<span style='color:red;display:inline-block;margin-right:20px;'>" + type 
		    		 + "</span><span class='sta' style='color:green;display:inline-block;margin-right:20px;'>" 
		    		 + "</span></div>"
		    		 + "<div><button class='am-btn-default abc' style='width: 75px;height: 20px;' onclick='getBut(this)'><span class='add-icon' style='color:#5ab66b;'> 增加试题</span></button></div>"
		    		 + "<div class='question_zone' chapter_id='" + data.rows[j].id + "' chapter_grade='" + data.rows[j].chapter_grade + "' type='" + data.rows[j].type + "' ></div>"
		    		 + "</div>"
		    	);
			}
		}
    },
	error:function(data){
		alertOpen(JSON.parse(data.responseText).errors[0].message);
	}
});

//2.给按钮关联模态框
var btn;//记录点的哪个按钮
var type;//记录题目类型
function getBut(ele){
	btn = ele;
	type = $(btn).parent().next("div").attr("type");
}
	
var dataSet3 = [];
var arr3= [
	{
		data : "name",
		title : '名称'
	}
];
var page3=""
var table3=new DataGrid($('#t3'),page3,"",arr3);
table3.setData(dataSet3);
table3.setButtonEven(".abc","#question_add_model");
table3.render(); 



//****************************修改start***********************************
if(qid!="0"){//修改试卷实例
	//回显试卷实例数据
	$.ajax({
		url:"/exam/api/paperCase/"+qid+"?method=get",
		type:"post",
		dataType:"json",
		contentType:"application/json",
		data:$.toJSON({"":""}),
		success:function(data2){
			$("#name").val(data2.row.name);
		},
		error:function(data){
			alertOpen(JSON.parse(data.responseText).errors[0].message);
		}
	});
	//回显题目数据
	$("#chapter_zone").find(".question_zone").each(function(){
		var obj = $(this);
		var param = {
			   	  "parameters":{"query":3,"id":qid,"chapter_id":obj.attr("chapter_id")}
		   };
		$.ajax({
			url:"/exam/api/paperCase?method=getlist",
			type:"post",
			async:false,
		    dataType:"json",
		    contentType:"application/json",
		    data:$.toJSON(param),
		    success:function(data){
				if(data.rows.length>0){
			    	for(var j=0;j<data.rows.length;j++){
			    		obj.append("<div style='margin-bottom:2px;' f='wow'>"
				    			+ "<div class='tt' question_id='" + data.rows[j].question_id + "' onclick='up(this)' >➦ " + data.rows[j].topic + "</div>"
				    			+ "<div class='jj' style='display:inline;'>设定分数：<input type='text' style='width:50px;' value='" + data.rows[j].grade + "' onblur='checkGrade(this)'/></div>"
				    			+ "</div>"
						);
			    	}
				}
		    },
			error:function(data){
				alertOpen(JSON.parse(data.responseText).errors[0].message);
			}
		});
	})
}



//****************************通用start***********************************
//3.给模态框初始化内容
function question_add_load(){
	//下拉框赋值
	var question_bank_first;
	//所有题库
	var param = {
		   	  "parameters":{"query":0}
	   };
	$.ajax({
		url:"/exam/api/questionBank?method=getlist",
		type:"post",
		async:false,
	    dataType:"json",
	    contentType:"application/json",
	    data:$.toJSON(param),
	    success:function(data){
				$(".content #question_bank_id").html("");
				if(data.rows.length>0){
					question_bank_first = data.rows[0].id;
			    	for(var j=0;j<data.rows.length;j++){
			    		$(".content #question_bank_id").append(
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
			alertOpen(JSON.parse(data.responseText).errors[0].message);
		}
	});
	//根据默认的题库加载题目
	var param2 = {
		   	  "parameters":{"query":3,"question_bank_id":question_bank_first,"type":type}
	   };
	$.ajax({
		url:"/exam/api/question?method=getlist",
		type:"post",
		async:false,
	    dataType:"json",
	    contentType:"application/json",
	    data:$.toJSON(param2),
	    success:function(data){
			$(".content #question_id").html("");
			if(data.rows.length>0){
		    	for(var j=0;j<data.rows.length;j++){
		    		$(".content #question_id").append(
			             	  "<option value='"
			             	  + data.rows[j].id
			             	  + "'>"
			             	  + data.rows[j].topic
			             	  + "</option>"
					);
		    	}
			}
	    },
		error:function(data){
			alertOpen(JSON.parse(data.responseText).errors[0].message);
		}
	});
}
//4.再切换题库时加载题目
function follow(v){
	var param2 = {
		   	  "parameters":{"query":3,"question_bank_id":v,"type":type}
	   };
	$.ajax({
		url:"/exam/api/question?method=getlist",
		type:"post",
	    dataType:"json",
	    contentType:"application/json",
	    data:$.toJSON(param2),
	    success:function(data){
				$(".content #question_id").html("");
				if(data.rows.length>0){
			    	for(var j=0;j<data.rows.length;j++){
			    		$(".content #question_id").append(
				             	  "<option value='"
				             	  + data.rows[j].id
				             	  + "'>"
				             	  + data.rows[j].topic
				             	  + "</option>"
						);
			    	}
				}else{
					alertOpen("当前题库没有题目！");
				}
	    },
		error:function(data){
			alertOpen(JSON.parse(data.responseText).errors[0].message);
		}
	});
}

//5.点击确定按钮进行题目添加
function question_add_yes(){
 	  if($(".content #question_id").val()!=null){//选择题目后添加到页面
 		 //不能添加重复的题目
	     var cur = 0;
		 $(btn).parent().next("div").find("div").each(function(){
  			if($(this).attr("question_id")==$(".content #question_id").val()){
		    	cur += 1;
			}
		 });
		 if(cur>0){
				alertOpen("不能添加重复的题目！");
		 }else{
			 	$(btn).parent().next("div").append("<div style='margin-bottom:2px;' f='wow' >"
		    			+ "<div class='tt' question_id='" + $(".content #question_id").val() + "' onclick='up(this)' >➦ " + $(".content #question_id").find("option:selected").text() + "</div>"
		    			+ "<div class='jj' style='display:inline;'>设定分数：<input type='text' style='width:50px;' onblur='checkGrade(this)'/></div>"
		    			+ "</div>"
		      	);
		 }
      }
 	 btn = null;
}
function question_add_no(){
 	 btn = null;
}

//6.点击排序事件
function up(jjj){
	var obj = $(jjj).parent();//这个题的div
	if(obj.prev().attr("f")=="wow"){//如果前面还有题目div，就挪到它前面
		obj.insertBefore(obj.prev())
	}
}

//7.设定分数失去焦点事件
function checkGrade(vvv){
	//$(vvv).val();//当前题目设定分数
	var count = 0;//记录题目总分
	var flag = 0;//记录题目分数是否合法
	$(vvv).parent().parent().parent().find("input").each(function(){//取出该章节所有题目的分数
		if($(this).val()!=null && $(this).val()!=0){
		    count += parseInt($(this).val());
		}else{
			flag += 1;
		}
	});
	if(flag>0){
		$(vvv).parent().parent().parent().parent().find(".sta").html("✘");//如果分数不满足要求，进行提示！
	}else{
		var chapterGrade =$(vvv).parent().parent().parent().attr("chapter_grade");//章节分数
		if(parseInt(chapterGrade)!=count){
			$(vvv).parent().parent().parent().parent().find(".sta").html("✘");//如果分数不满足要求，进行提示！
		}else{
			$(vvv).parent().parent().parent().parent().find(".sta").html("✔");//如果分数满足要求，ok！
		}
	}
}

//8.最后的提交事件
function paperCaseSubmit(){
	
	//验证分数是否正确
	var flag = true;
	$("#chapter_zone ").find(".question_zone").each(function(){
		var chapter_grade = $(this).attr("chapter_grade");
		var f=0;
		$(this).find("input").each(function(){
			f += parseInt($(this).val());
		});
		if(f!=chapter_grade){
			flag = false;
		}
	});
	
	if(flag){//可以提交
		if(qid=="0"){//新增
			//取题目的各项值
			var bl = [];
			$("#chapter_zone").find(".question_zone").each(function(){
				var bm = {};
				bm.chapter_id = $(this).attr("chapter_id");
				var sl = [];
				$(this).children().each(function(){
					var sm = {};
					sm.question_id = $(this).children().eq(0).attr("question_id");
					sm.grade = $(this).children().eq(1).find("input").val();
					sl.push(sm);
				});
				bm.info = sl;
				bl.push(bm);
			});
			//console.log(bl);
			var param = {
					paper_id:paper_id,
					name:$("#name").val(),
					count:$("#count").val(),
					pp:bl
				};
			$.ajax({
				url:"/exam/api/paperCase?method=post",
				type:"post",
			    dataType:"json",
			    contentType:"application/json",
			    data:$.toJSON(param),
			    success:function(data){
			    	alertOpen("新增试卷成功！");
			    	$("#main").modal('close');
			    	window.location.href="../paper/paperCase_list.jsp?pid=" + paper_id + "&pname=" + pname + "&pfrom=0"
			    },
				error:function(data){
					alertOpen(JSON.parse(data.responseText).errors[0].message);
				}
			});
		}else{//修改
			//取题目的各项值
			var bl = [];
			$("#chapter_zone").find(".question_zone").each(function(){
				var bm = {};
				bm.chapter_id = $(this).attr("chapter_id");
				var sl = [];
				$(this).children().each(function(){
					var sm = {};
					sm.question_id = $(this).children().eq(0).attr("question_id");
					sm.grade = $(this).children().eq(1).find("input").val();
					sl.push(sm);
				});
				bm.info = sl;
				bl.push(bm);
			});
			//console.log(bl);
			var param = {
					operate:0,
					id:qid,
					name:$("#name").val(),
					count:$("#count").val(),
					pp:bl
				};
			$.ajax({
				url:"/exam/api/paperCase?method=put",
				type:"post",
			    dataType:"json",
			    contentType:"application/json",
			    data:$.toJSON(param),
			    success:function(data){
			    	alertOpen("修改试卷成功！");
			    	$("#main").modal('close');
			    	window.location.href="../paper/paperCase_list.jsp?pid=" + paper_id + "&pname=" + pname + "&pfrom=0"
			    },
				error:function(data){
					alertOpen(JSON.parse(data.responseText).errors[0].message);
				}
			});
		}
	}else{
		alertOpen("请补充章节题目及分数！");
	}
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