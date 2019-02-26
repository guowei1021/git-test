<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>考试实例列表</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/table.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/jquery.datetimepicker.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<main>


<div id="examCase_tbody" class="am-u-sm-12" >
	<div class="toolbar">
		<button class="add" id="examCase_add" value="新增"></button>
	</div>
	<table></table>
</div>
<div style="clear:both"></div>

<!-- 考试实例模态框：新增、修改 -->
<div id="examCase_add_model" onload="examCase_add_load()" onclickOk="examCase_add_yes()" onclickConsole="examCase_no()">
	<div style="font-size:12;margin-top:20px;" class="pop-content">
		<div class="modal-title">考试详细信息</div>
		<div class="am-modal-bd">
			<form class="am-form am-form-horizontal">
			  <fieldset>

	    		<div class="am-form-group">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="name">考试名称: </label>
			      <input style="width:350px;height:30px;font-size: 12px;" type="text" id="name" placeholder="">
			    </div>

	    		<div class="am-form-group">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="exam_type">考试类型: </label>
			      <select  style="width:350px;height:30px;font-size: 12px;" id="exam_type">
			      	<option value="在线考试">在线考试</option>
			      	<option value="模拟考试">模拟考试</option>
			      	<option value="竞赛">竞赛</option>
			      	<option value="自测">自测</option>
				  </select>
			    </div>

	    		<div class="am-form-group">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="is_charge">是否支持续考: </label>
			          <span style="float: left;">是&nbsp;<input type="radio" name="is_connect" value="1" placeholder="" id="c1"></span>
			          <span style="float: left;padding-left: 20px;">否&nbsp;<input type="radio" name="is_connect" value="0" placeholder="" id="c0"></span>
			    </div>

		   		<div class="am-form-group">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="topic_is_disorder">题目是否乱序: </label>
		 			<span style="float: left;">是&nbsp;<input type="radio" name="topic_is_disorder" value="1" placeholder="" id="t1"></span>
		        	<span style="float: left;padding-left: 20px;">否&nbsp;<input type="radio" name="topic_is_disorder" value="0" placeholder="" id="t0"></span>
			    </div>

		   		<div class="am-form-group">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="option_is_disorder">选项是否乱序: </label>
	  				<span style="float: left;">是&nbsp;<input type="radio" name="option_is_disorder" value="1" placeholder="" id="o1"></span>
		        	<span style="float: left;padding-left: 20px;">否&nbsp;<input type="radio" name="option_is_disorder" value="0" placeholder="" id="o0"></span>
			    </div>

	    		<div class="am-form-group">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="sorce_line">分数线: </label>
			      <input style="width:350px;height:30px;font-size: 12px;" type="text" id="sorce_line" placeholder="">
			    </div>

	    		<div class="am-form-group">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="locked_times">锁定次数: </label>
			      <input style="width:350px;height:30px;font-size: 12px;" type="text" id="locked_times" placeholder="考试中途允许离开页面的次数">
			    </div>

	    		<div class="am-form-group">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="is_charge">是否收费: </label>
			          <span style="float: left;">是&nbsp;<input type="radio" onclick="showA()" name="is_charge" value="1" placeholder="" id="a1"></span>
			          <span style="float: left;padding-left: 20px;">否&nbsp;<input type="radio" onclick="showA()" name="is_charge" value="0" placeholder="" id="a2"></span>
			    </div>

	    		<div class="am-form-group fee">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="fee">费用: </label>
			      <input style="width:350px;height:30px;font-size: 12px;" type="text" id="fee" placeholder="元">
			    </div>

	    		<div class="am-form-group account">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="account">缴费账号: </label>
			      <input style="width:350px;height:30px;font-size: 12px;" type="text" id="account" placeholder="">
			    </div>

	    		<div class="am-form-group">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="starttime">开始时间: </label>
			      <input style="width:350px;height:30px;font-size: 12px;" type="text" id="starttime" placeholder="">
			    </div>

	    		<div class="am-form-group">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="endtime">结束时间: </label>
			      <input style="width:350px;height:30px;font-size: 12px;" type="text" id="endtime" placeholder="">
			    </div>

	    		<div class="am-form-group">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="duration">考试时长: </label>
			      <input style="width:350px;height:30px;font-size: 12px;" type="text" id="duration" placeholder="分钟">
			    </div>
			    
	    		<div class="am-form-group">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="examiner_id">考试负责人: </label>
			      <input style="width:350px;height:30px;font-size: 12px;" type="text" id="examiner_id" placeholder="">
			    </div>

	    		<div class="am-form-group">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="is_beforehand">试卷策略: </label>
			      <span style="float: left;">试卷库中选&nbsp;<input type="radio" onclick="showB()" name="is_beforehand" value="0" placeholder="" id="b0"></span>
			      <span style="float: left;padding-left: 20px;">预生成&nbsp;<input type="radio" onclick="showB()" name="is_beforehand" value="1" placeholder="" id="b1"></span>
			      <span style="float: left;padding-left: 20px;">实时生成&nbsp;<input type="radio" onclick="showB()" name="is_beforehand" value="2" placeholder="" id="b2"></span>
			    </div>
			    		    			    
	    		<div class="am-form-group beforehand_number">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="beforehand_number">预先生成数量: </label>
			      <input style="width:350px;height:30px;font-size: 12px;" type="text" id="beforehand_number" placeholder="">
			    </div>
			    			    
	    		<div class="am-form-group warn_num">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="warn_num">预警数量: </label>
			      <input style="width:350px;height:30px;font-size: 12px;" type="text" id="warn_num" placeholder="">
			    </div>
			    			    
	    		<div class="am-form-group warn_supply_num">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="warn_supply_num">预警补充数量: </label>
			      <input style="width:350px;height:30px;font-size: 12px;" type="text" id="warn_supply_num" placeholder="">
			    </div>
			    			    
	    		<div class="am-form-group check_time">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="check_time">检查时间: </label>
			      <select  style="width:350px;height:30px;font-size: 12px;" id="check_time">
			      	<option value="0">00:00</option>
			      	<option value="1">01:00</option>
			      	<option value="2">02:00</option>
			      	<option value="3">03:00</option>
			      	<option value="4">04:00</option>
			      	<option value="5">05:00</option>
			      	<option value="6">06:00</option>
			      	<option value="7">07:00</option>
			      	<option value="8">08:00</option>
			      	<option value="9">09:00</option>
			      	<option value="10">10:00</option>
			      	<option value="11">11:00</option>
			      	<option value="12">12:00</option>
			      	<option value="13">13:00</option>
			      	<option value="14">14:00</option>
			      	<option value="15">15:00</option>
			      	<option value="16">16:00</option>
			      	<option value="17">17:00</option>
			      	<option value="18">18:00</option>
			      	<option value="19">19:00</option>
			      	<option value="20">20:00</option>
			      	<option value="21">21:00</option>
			      	<option value="22">22:00</option>
			      	<option value="23">23:00</option>
				  </select>
			    </div>
			    			    
	    		<div class="am-form-group trigger_num">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="trigger_num">触发补充数量: </label>
			      <input style="width:350px;height:30px;font-size: 12px;" type="text" id="trigger_num" placeholder="">
			    </div>	
			        
	    		<div class="am-form-group paper_id">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="paper_id">试卷模版: </label><!-- 静态试卷 -->
			      <select  style="width:350px;height:30px;font-size: 12px;" id="paper_id">
				  </select>
			    </div>
			    
			  </fieldset>
			</form>
		</div>
	</div>
</div>
<!-- 考试实例模态框：删除 -->
<div id="examCase_del_model" onclickOk="examCase_del_yes()" onclickConsole="examCase_no()">
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
<script src="${pageContext.request.contextPath}/static/js/jquery.datetimepicker.js"></script>

</body>

<script type="text/javascript">
$(function(){
	$(".down").css("background-color","rgba(255,255,255,0.3)")
})
var url=window.location.href;
var pid = url.split("?")[1].split("&")[0].split("=")[1];
var pname = decodeURI(url.split("?")[1].split("&")[1].split("=")[1]);

//****************************某科目的相关考试实例************************************
var examCase_tbody_arr= [	
		{
			data : "no",
			title : '序号'
		},
		{
			data : "name",
			title : '考试名称'
		},
		{
			data : "exam_type",
			title : '考试类型'
		},
		{
			data : "is_connect",
			title : '是否支持续考'
		},
		{
			data : "topic_is_disorder",
			title : '题目是否乱序'
		},
		{
			data : "option_is_disorder",
			title : '选项是否乱序'
		},
		{
			data : "sorce_line",
			title : '分数线'
		},
		{
			data : "locked_times",
			title : '锁定次数'
		},
		{
			data : "is_charge",
			title : '是否收费'
		},
		{
			data : "fee",
			title : '费用'
		},
		{
			data : "account",
			title : '缴费账号'
		},
		{
			data : "starttime",
			title : '开始时间'
		},
		{
			data : "endtime",
			title : '结束时间'
		},
		{
			data : "duration",
			title : '时长（min）'
		},
		{
			data : "examiner_id",
			title : '负责人'
		},
		{
			data : "is_beforehand",
			title : '试卷策略'
		},
		{
			data : null,
			title : "操作",
			sWidth:"240px",
			render : function(data, type, row) { // 返回自定义内容 /pro/src/main/webapp/jsp/rest/model.html  source
				//console.log(row);
				var buttonHtml = "<button class='revise table_btn revise1' value='修改' onclick='getExamCaseId(\"" + row.id + "\")' style='float:left;margin-left:5px;'></button>"
								   + "<button class='delete table_btn delete1' value='删除' onclick='getExamCaseId(\"" + row.id + "\")' style='float:left;margin-right:5px;'></button>"
								   + "<button class='am-btn am-btn-default am-btn-xs am-text-secondary am-icon-eye' onclick='toPaperCase(\"" + row.id + "\",\"" + row.name + "\")' style='float:left;margin-left:5px;'>试卷列表</button>";/* 试卷实例 */
				return buttonHtml;										
			}
		} 
  ];// table的结构
var examCase_tbody_param={query:"0",exam_id:pid};//ajax请求的参数
var examCase_tbody_table=new DataGrid(
		$('#examCase_tbody'), //table的id
		"pli", //分页插件，可以任意组合以下三个字母或提供一个空串："p"代表页码，"l"代表 每页显示多少条，"i"代表 一共多少条，当前多少条。
		"/exam/api/examCase?method=getlist", //ajax请求的url
		examCase_tbody_arr,
		function(rows){//对数据进行自定义显示
			for(var i=0;i<rows.length;i++){
				//1.序号
				rows[i].no=(i+1);
				//2.是否支持续考
				rows[i].is_connect = (rows[i].is_connect=="1" ? "是":"否");
				//3.题目是否乱序
				rows[i].topic_is_disorder = (rows[i].topic_is_disorder=="1" ? "是":"否");
				//4.选项是否乱序
				rows[i].option_is_disorder = (rows[i].option_is_disorder=="1" ? "是":"否");
				//5.是否需要费用
				if(rows[i].is_charge=="1"){
					rows[i].is_charge = "是";
				}else if(rows[i].is_charge=="0"){
					rows[i].is_charge = "否";
					rows[i].fee = "";
					rows[i].account = "";
				}
				//6.时间格式化
				rows[i].starttime = getMyDateTime(rows[i].starttime);
				rows[i].endtime = getMyDateTime(rows[i].endtime);
				//7.是否
				if(rows[i].is_beforehand=="0"){
					rows[i].is_beforehand="试卷库中选";
				}else if(rows[i].is_beforehand=="1"){
					rows[i].is_beforehand="预生成";
				}else if(rows[i].is_beforehand=="2"){
					rows[i].is_beforehand="实时生成";
				}
			} 
			return rows;
		}
);
examCase_tbody_table.setTitle(pname + " [考试列表]");
examCase_tbody_table.setParameters(examCase_tbody_param);
examCase_tbody_table.setButtonEven("#examCase_add", "#examCase_add_model");//新增
examCase_tbody_table.setButtonEven(".revise1", "#examCase_add_model");//修改
examCase_tbody_table.setButtonEven(".delete1", "#examCase_del_model");//删除
examCase_tbody_table.render();


//【考试实例增、删、改】**************************start*********************************
var examCase_id="";//全局变量，用于区分新增（新增时为空）、修改、删除（修改或删除后要置空）
function getExamCaseId(id){
	examCase_id = id;//记录点
}

function examCase_add_load(){//模态框打开后初始化数据
	//初始化下拉框、日期插件
	$(".content #starttime").datetimepicker({//开始日期
		lang: "ch", //语言选择中文 注：旧版本 新版方法：$.datetimepicker.setLocale('ch');
		minView: 0,//精确到分
		format: "Y-m-d H:i", //格式化日期
		yearStart: 1900, //设置最小年份
		yearEnd: 2050, //设置最大年份
		todayButton: true //关闭选择今天按钮
	});
	$(".content #endtime").datetimepicker({//结束日期
		lang: "ch", //语言选择中文 注：旧版本 新版方法：$.datetimepicker.setLocale('ch');
		minView: 0,//精确到分
		format: "Y-m-d H:i", //格式化日期
		yearStart: 1900, //设置最小年份
		yearEnd: 2050, //设置最大年份
		todayButton: true //关闭选择今天按钮
	});
	//隐藏费用选项
	$(".content .fee").hide();
	$(".content .account").hide();
	//隐藏试卷策略选项
	$(".content .beforehand_number").hide();
	$(".content .warn_num").hide();
	$(".content .warn_supply_num").hide();
	$(".content .check_time").hide();
	$(".content .trigger_num").hide();
	$(".content .paper_id").hide();
	//根据pid查关联的静态试卷模版给select赋值
	var param = {
		   	  "parameters":{"query":2,"id":pid}
	   };
	$.ajax({
		url:"/exam/api/exam?method=getlist",
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
	//如果是修改，要回显信息
   	if(examCase_id!=""){
   		$.ajax({
   			url:"/exam/api/examCase/"+examCase_id+"?method=get",
   			type:"post",
   		    dataType:"json",
   		    contentType:"application/json",
   		    data:$.toJSON({"":""}),
   		    success:function(data){
   		    	//alert(JSON.stringify(data));
   		    	$(".content #name").val(data.row.name);
   		    	$(".content #exam_type").val(data.row.exam_type);
   		    	if(data.row.is_connect=="1"){
   		    		$(".content #c1").prop("checked","checked");
   		    	}else if(data.row.is_connect=="0"){
   		    		$(".content #c0").prop("checked","checked");
   		    	}
   		    	if(data.row.topic_is_disorder=="1"){
   		    		$(".content #t1").prop("checked","checked");
   		    	}else if(data.row.topic_is_disorder=="0"){
   		    		$(".content #t0").prop("checked","checked");
   		    	}
   		    	if(data.row.option_is_disorder=="1"){
   		    		$(".content #o1").prop("checked","checked");
   		    	}else if(data.row.option_is_disorder=="0"){
   		    		$(".content #o0").prop("checked","checked");
   		    	}
   		    	$(".content #sorce_line").val(data.row.sorce_line);
   		    	$(".content #locked_times").val(data.row.locked_times);
   		    	if(data.row.is_charge=="1"){
   		    		$(".content #a1").prop("checked","checked");
	   		 		$(".content .fee").show();
	   				$(".content .account").show();
   		    	}else if(data.row.is_charge=="0"){
   		    		$(".content #a2").prop("checked","checked");
   		 			$(".content .fee").hide();
   					$(".content .account").hide();
   		    	}
   		    	$(".content #fee").val(data.row.fee);
   		    	$(".content #account").val(data.row.account);
   		    	$(".content #starttime").val(getMyDateTime(data.row.starttime));
   		    	$(".content #endtime").val(getMyDateTime(data.row.endtime));
   		    	$(".content #duration").val(data.row.duration);
   		    	$(".content #examiner_id").val(data.row.examiner_id);
   		    	
   		    	var l = data.row.is_beforehand;
   		    	if(l=="0"){
   		    		$(".content #b0").prop("checked","checked");
	   		 		$(".content .beforehand_number").hide();
	   				$(".content .warn_num").hide();
	   				$(".content .warn_supply_num").hide();
	   				$(".content .check_time").hide();
	   				$(".content .trigger_num").hide();
	   				$(".content .paper_id").hide();
   		    	}else{
   		    		var examPolicyObj;
   		    		$.ajax({
   		    			url:"/exam/api/examPolicy/"+examCase_id+"?method=get",
   		    			type:"post",
   		    		    dataType:"json",
   		    		    contentType:"application/json",
   		    		    data:$.toJSON({"":""}),
   		    		    success:function(data2){
   		    		    	examPolicyObj = data2.row;
		   		    		if(l=="1"){
		   	   		    		$(".content #b1").prop("checked","checked");
		   		   		 		$(".content .beforehand_number").show();
		   		   				$(".content .warn_num").show();
		   		   				$(".content .warn_supply_num").show();
		   		   				$(".content .check_time").show();
		   		   				$(".content .trigger_num").show();
		   		   				$(".content .paper_id").show();
		   		   				$(".content #beforehand_number").val(examPolicyObj.beforehand_number);
		   		   				$(".content #warn_num").val(examPolicyObj.warn_num);
		   		   				$(".content #warn_supply_num").val(examPolicyObj.warn_supply_num);
		   		   				$(".content #check_time").val(examPolicyObj.check_time);
		   		   				$(".content #trigger_num").val(examPolicyObj.trigger_num);
		   		   				$(".content #paper_id").val(examPolicyObj.paper_id);
		   		    		}else if(l=="2"){
		   	   		    		$(".content #b2").prop("checked","checked");
		   		   		 		$(".content .beforehand_number").hide();
		   		   				$(".content .warn_num").hide();
		   		   				$(".content .warn_supply_num").hide();
		   		   				$(".content .check_time").hide();
		   		   				$(".content .trigger_num").hide();
		   		   				$(".content .paper_id").show();
		   		   				$(".content #paper_id").val(examPolicyObj.paper_id);
		   		    		}
   		    		    },
   		    			error:function(data){
   		    				alert(JSON.parse(data.responseText).errors[0].message);
   		    			}
   		    		});
   		    	}
   		    },
   			error:function(data){
   				alert(JSON.parse(data.responseText).errors[0].message);
   			}
   		});
   	}
}

function examCase_add_yes(){//提交
	if(examCase_id==""){//新增提交
		var IsCharge = $(".content input[name='is_charge']:checked").val();
		var Fee = "";
		var Account = "";
		if(IsCharge=="1"){
			Fee = $(".content #fee").val();
			Account = $(".content #account").val();
		}
		var IsBeforehand = $(".content input[name='is_beforehand']:checked").val();
		var Paper_id = "";
		var BeforehandNumber = "";
		var WarnNum = "";
		var WarnSupplyNum = "";
		var CheckTime = "";
		var TriggerNum = "";
		if(IsBeforehand=="1"){
			Paper_id=$(".content #paper_id").val();
			BeforehandNumber = $(".content #beforehand_number").val();
			WarnNum = $(".content #warn_num").val();
			WarnSupplyNum = $(".content #warn_supply_num").val();
			CheckTime = $(".content #check_time").val();
			TriggerNum = $(".content #trigger_num").val();
		}else if(IsBeforehand=="2"){
			Paper_id=$(".content #paper_id").val();
		}
		var param = {
			exam_id:pid,
			name:$(".content #name").val(),
			exam_type:$(".content #exam_type").val(),
			is_connect:$(".content input[name='is_connect']:checked").val(),
			topic_is_disorder:$(".content input[name='topic_is_disorder']:checked").val(),
			option_is_disorder:$(".content input[name='option_is_disorder']:checked").val(),
			sorce_line:$(".content #sorce_line").val(),
			locked_times:$(".content #locked_times").val(),
			is_charge:IsCharge,
			fee:Fee,
			account:Account,
			starttime:$(".content #starttime").val(),
			endtime:$(".content #endtime").val(),
			duration:$(".content #duration").val(),
			examiner_id:$(".content #examiner_id").val(),
			is_beforehand:IsBeforehand,
			paper_id:Paper_id,
			beforehand_number:BeforehandNumber,
			warn_num:WarnNum,
			warn_supply_num:WarnSupplyNum,
			check_time:CheckTime,
			trigger_num:TriggerNum
		};
		$.ajax({
			url:"/exam/api/examCase?method=post",
			type:"post",
		    dataType:"json",
		    contentType:"application/json",
		    data:$.toJSON(param),
		    success:function(data){
		    	alert("新增考试成功！");
		    	$("#main").modal('close');
		    	examCase_tbody_table.render();	
		    },
			error:function(data){
				alert(JSON.parse(data.responseText).errors[0].message);
			}
		});
	}else{//修改提交
		var IsCharge = $(".content input[name='is_charge']:checked").val();
		var Fee = "";
		var Account = "";
		if(IsCharge=="1"){
			Fee = $(".content #fee").val();
			Account = $(".content #account").val();
		}
		var IsBeforehand = $(".content input[name='is_beforehand']:checked").val();
		var Paper_id = "";
		var BeforehandNumber = "";
		var WarnNum = "";
		var WarnSupplyNum = "";
		var CheckTime = "";
		var TriggerNum = "";
		if(IsBeforehand=="1"){
			Paper_id=$(".content #paper_id").val();
			BeforehandNumber = $(".content #beforehand_number").val();
			WarnNum = $(".content #warn_num").val();
			WarnSupplyNum = $(".content #warn_supply_num").val();
			CheckTime = $(".content #check_time").val();
			TriggerNum = $(".content #trigger_num").val();
		}else if(IsBeforehand=="2"){
			Paper_id=$(".content #paper_id").val();
		}
		var param = {
				operate:0,
				id:examCase_id,
				name:$(".content #name").val(),
				exam_type:$(".content #exam_type").val(),
				is_connect:$(".content input[name='is_connect']:checked").val(),
				topic_is_disorder:$(".content input[name='topic_is_disorder']:checked").val(),
				option_is_disorder:$(".content input[name='option_is_disorder']:checked").val(),
				sorce_line:$(".content #sorce_line").val(),
				locked_times:$(".content #locked_times").val(),
				is_charge:IsCharge,
				fee:Fee,
				account:Account,
				starttime:$(".content #starttime").val(),
				endtime:$(".content #endtime").val(),
				duration:$(".content #duration").val(),
				examiner_id:$(".content #examiner_id").val(),
				is_beforehand:IsBeforehand,
				paper_id:Paper_id,
				beforehand_number:BeforehandNumber,
				warn_num:WarnNum,
				warn_supply_num:WarnSupplyNum,
				check_time:CheckTime,
				trigger_num:TriggerNum
		};
		$.ajax({
			url:"/exam/api/examCase?method=put",
			type:"post",
		    dataType:"json",
		    contentType:"application/json",
		    data:$.toJSON(param),
		    success:function(data){
		    	alert("修改考试成功！");
		    	$("#main").modal('close');
		    	examCase_tbody_table.render();	
		    },
			error:function(data){
				alert(JSON.parse(data.responseText).errors[0].message);
			}
		});
	}
	examCase_id="";//置空id
}

function examCase_del_yes(){//删除
	var param = {
			operate:1,
			id:examCase_id
	};
	$.ajax({
		url:"/exam/api/examCase?method=put",
		type:"post",
	    dataType:"json",
	    contentType:"application/json",
	    data:$.toJSON(param),
	    success:function(data){
	    	alert("删除考试成功！");
	    	$("#main").modal('close');
	    	examCase_tbody_table.render();	
	    },
		error:function(data){
			alert(JSON.parse(data.responseText).errors[0].message);
		}
	});
	examCase_id="";//置空id
}

function examCase_no(){//取消
	examCase_id="";//置空id
}

//是否有费用触发事件
function showA(){
	var v = $(".content input[name='is_charge']:checked").val();
	if(v=="1"){
		$(".content .fee").show();
		$(".content .account").show();
	}
	if(v=="0"){
		$(".content .fee").hide();
		$(".content .account").hide();
	}
}
//改变试卷策略触发事件
function showB(){
	var v = $(".content input[name='is_beforehand']:checked").val();
	if(v=="0"){
		$(".content .beforehand_number").hide();
		$(".content .warn_num").hide();
		$(".content .warn_supply_num").hide();
		$(".content .check_time").hide();
		$(".content .trigger_num").hide();
		$(".content .paper_id").hide();
	}
	if(v=="1"){
		$(".content .beforehand_number").show();
		$(".content .warn_num").show();
		$(".content .warn_supply_num").show();
		$(".content .check_time").show();
		$(".content .trigger_num").show();
		$(".content .paper_id").show();
	}
	if(v=="2"){
		$(".content .beforehand_number").hide();
		$(".content .warn_num").hide();
		$(".content .warn_supply_num").hide();
		$(".content .check_time").hide();
		$(".content .trigger_num").hide();
		$(".content .paper_id").show();
	}
}



//【其它】**************************start*****************************
//跳转到试卷实例界面
function toPaperCase(id,name){
	window.location.href="../paper/paperCase_list.jsp?pid=" + id + "&pname=" + encodeURI(name) + "&pfrom=1";
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