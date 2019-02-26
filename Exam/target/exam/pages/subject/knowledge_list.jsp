<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>知识点列表</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/table.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<main>


<div id="knowledge_tbody" class="am-u-sm-12" >
	<div class="toolbar">
		<button class="add" id="knowledge_add" value="新增"></button>
	</div>
	<table></table>
</div>
<div style="clear:both"></div>

<!-- 知识点模态框：新增、修改 -->
<div id="knowledge_add_model" onload="knowledge_add_load()" onclickOk="knowledge_add_yes()" onclickConsole="knowledge_no()">
	<div style="font-size:12;margin-top:20px;" class="pop-content">
		<div class="modal-title">知识点详细信息</div>
		<div class="am-modal-bd">
			<form class="am-form am-form-horizontal">
			  <fieldset>

	    		<div class="am-form-group">
			      <div style="width:477px;font-size: 12px;padding-left:127px;text-align: left;" id="parent_id"></div>
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="k_parent_id">父级知识点: </label>
			      <input style="width:350px;height:30px;font-size: 12px;" type="text" id="k_parent_id" placeholder="">
			      <div style="width:477px;font-size: 12px;padding-left:127px;text-align: left;" id="word"></div>
			    </div>

	    		<div class="am-form-group">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="k_name">知识点名称: </label>
			      <input style="width:350px;height:30px;font-size: 12px;" type="text" id="k_name" placeholder="">
			    </div>

	    		<div class="am-form-group">
			      <label class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="k_desc">知识点描述: </label>
			      <input style="width:350px;height:30px;font-size: 12px;" type="text" id="k_desc" placeholder="">
			    </div>
			    

			    
			  </fieldset>
			</form>
		</div>
	</div>
</div>
<!-- 知识点模态框：删除 -->
<div id="knowledge_del_model" onclickOk="knowledge_del_yes()" onclickConsole="knowledge_no()">
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
var url=window.location.href;
var pid = url.split("?")[1].split("&")[0].split("=")[1];
var pname = decodeURI(url.split("?")[1].split("&")[1].split("=")[1]);

//****************************某科目的相关知识点************************************
var knowledge_tbody_arr= [	
		{
			data : "no",
			title : '序号'
		},
		{
			data : "k_name",
			title : '知识点名称'
		},
		{
			data : "k_desc",
			title : '知识点描述'
		},
		{
			data : null,
			title : "操作",
			render : function(data, type, row) { // 返回自定义内容 /pro/src/main/webapp/jsp/rest/model.html  source
				var buttonHtml = "<button class='revise table_btn revise1' value='修改' onclick='getKnowledgeId(\"" + row.id + "\")' style='float:left;margin-left:5px;'></button>"
							   + "<button class='delete table_btn delete1' value='删除' onclick='getKnowledgeId(\"" + row.id + "\")' style='float:left;margin-right:5px;'></button>";
				return buttonHtml;										
			}
		} 
  ];// table的结构
var knowledge_tbody_param={query:"0",subject_id:pid};//ajax请求的参数
var knowledge_tbody_table=new DataGrid(
		$('#knowledge_tbody'), //table的id
		"", //分页插件，可以任意组合以下三个字母或提供一个空串："p"代表页码，"l"代表 每页显示多少条，"i"代表 一共多少条，当前多少条。
		"/exam/api/knowledge?method=getlist", //ajax请求的url
		knowledge_tbody_arr,
		function(rows){//对数据进行自定义显示
			for(var i=0;i<rows.length;i++){
				//1.序号
				rows[i].no=(i+1);
			} 
			return rows;
		}
);
knowledge_tbody_table.setTitle(pname + "相关知识点");
knowledge_tbody_table.setParameters(knowledge_tbody_param);
knowledge_tbody_table.setButtonEven("#knowledge_add", "#knowledge_add_model");//新增
knowledge_tbody_table.setButtonEven(".revise1", "#knowledge_add_model");//修改
knowledge_tbody_table.setButtonEven(".delete1", "#knowledge_del_model");//删除
knowledge_tbody_table.render();


//【知识点增、删、改】**************************start*********************************
var knowledge_id="";//全局变量，用于区分新增（新增时为空）、修改、删除（修改或删除后要置空）
function getKnowledgeId(id){
	knowledge_id = id;//记录点
}

function knowledge_add_load(){//模态框打开后初始化数据
	//当键盘键被松开时发送Ajax获取数据
	$('.content #k_parent_id').keyup(function(){
	 	var keywords = $(this).val();
		if (keywords=='') { $('.content #word').hide(); return };
		$.ajax({
			url:"/exam/api/knowledge?method=getlist",
			type:"post",
			async:false,
		    dataType:"json",
		    contentType:"application/json",
		    data:$.toJSON({
		    	"parameters":{"query":1,"subject_id":pid,"k_name":keywords}
		    }),
			beforeSend:function(){
				$('.content #word').append('<div>正在加载。。。</div>');
			},
		    success:function(data){
		    	//console.log(JSON.stringify(data));
				$('.content #word').empty().show();
				if (data.rows.length>0){
					for (i=0; i<data.rows.length;i++){
						$('.content #word').append("<div class='click_work' onclick='tie(\"" + data.rows[i].id + "\",\"" + data.rows[i].k_name +"\")'" + 'onmouseover="this.style.backgroundColor=\'#cce5ff\'" onmouseout="this.style.backgroundColor=\'#FFFFFF\'">'+ data.rows[i].k_name +'</div>');
					}
				}else{
					$('.content #word').append('<div class="error">没有发现  "' + keywords + '"</div>');
				}
			},
			error:function(){
				$('.content #word').empty().show();
				$('.content #word').append('<div class="click_work">搜索关键词 "' + keywords + '"失败！</div>');
			}
		});
	})
	
	//初始化下拉框、日期插件
	
	//如果是修改，要回显信息
   	if(knowledge_id!=""){
   		//回显知识点
   		$.ajax({
   			url:"/exam/api/knowledge/"+knowledge_id+"?method=get",
   			type:"post",
   		    dataType:"json",
   		    contentType:"application/json",
   		    data:$.toJSON({"":""}),
   		    success:function(data){
   		    	//alert(JSON.stringify(data));
   		    	$(".content #k_name").val(data.row.k_name);
   		    	$(".content #k_desc").val(data.row.k_desc);
   		    },
   			error:function(data){
   				alert(JSON.parse(data.responseText).errors[0].message);
   			}
   		});
   		//回显知识点父级
		$.ajax({
			url:"/exam/api/knowledge?method=getlist",
			type:"post",
			async:false,
		    dataType:"json",
		    contentType:"application/json",
		    data:$.toJSON({
		    	  "parameters":{"query":2,"k_kid_id":knowledge_id}
		    }),
		    success:function(data){
		    	//alert(JSON.stringify(data));
		    	var list = data.rows;
		    	if(list!=null && list.length>0){
			    	for(var i=0;i<list.length;i++){
				    	$('.content #parent_id').append("<button class='has_work' type='button' style='background-color:#d1edfc;border:1px solid #3bb4f2;margin-right:5px;' value='" + list[i].k_parent_id + "'>" + list[i].k_name + "</button>");
		    		}
		    	}
		    },
			error:function(data){
				alert(JSON.parse(data.responseText).errors[0].message);
			}
		});
   		//给回显的父级配置点击移除事件
		for(var i=0;i<$('.content #parent_id button').length;i++){
			$('.content #parent_id button').eq(i).click(function(){
				$(this).remove();
			})
		}
   	}
}

function knowledge_add_yes(){//提交
	if(knowledge_id==""){//新增提交
		var param = {
			subject_id:pid,
			k_name:$(".content #k_name").val(),
			k_desc:$(".content #k_desc").val(),
			k_parent_ids:[]
		};
		for(var i=0;i<$('.content #parent_id button').length;i++){
			param.k_parent_ids.push({"k_parent_id":$('.content #parent_id button').eq(i).val()})
		}
	
		$.ajax({
			url:"/exam/api/knowledge?method=post",
			type:"post",
		    dataType:"json",
		    contentType:"application/json",
		    data:$.toJSON(param),
		    success:function(data){
		    	alert("新增知识点成功！");
		    	$("#main").modal('close');
		    	knowledge_tbody_table.render();	
		    },
			error:function(data){
				alert(JSON.parse(data.responseText).errors[0].message);
			}
		});
	}else{//修改提交
		var param = {
				operate:0,
				id:knowledge_id,
				k_name:$(".content #k_name").val(),
				k_desc:$(".content #k_desc").val(),
				k_parent_ids:[]
		};
		for(var i=0;i<$('.content #parent_id button').length;i++){
			param.k_parent_ids.push({"k_parent_id":$('.content #parent_id button').eq(i).val()})
		}
		
		$.ajax({
			url:"/exam/api/knowledge?method=put",
			type:"post",
		    dataType:"json",
		    contentType:"application/json",
		    data:$.toJSON(param),
		    success:function(data){
		    	alert("修改知识点成功！");
		    	$("#main").modal('close');
		    	knowledge_tbody_table.render();	
		    },
			error:function(data){
				alert(JSON.parse(data.responseText).errors[0].message);
			}
		});
	}
	knowledge_id="";//置空id
}

function knowledge_del_yes(){//删除
	var param = {
			operate:1,
			id:knowledge_id
	};
	$.ajax({
		url:"/exam/api/knowledge?method=put",
		type:"post",
	    dataType:"json",
	    contentType:"application/json",
	    data:$.toJSON(param),
	    success:function(data){
	    	alert("删除知识点成功！");
	    	$("#main").modal('close');
	    	knowledge_tbody_table.render();	
	    },
		error:function(data){
			alert(JSON.parse(data.responseText).errors[0].message);
		}
	});
	knowledge_id="";//置空id
}

function knowledge_no(){//取消
	knowledge_id="";//置空id
}

//【知识点增、删、改】**************************end*********************************



//【下拉提示、动态添加框】**************************start*********************************
	//点击搜索数据时
	function tie(id,name){
		//重复添加remove掉原来的
		for(var i=0;i<$('.content #parent_id button').length;i++){			
			if($('.content #parent_id button').eq(i).val()==id){
				$('.content #parent_id button').eq(i).remove();
			}
		}
		//添加标签并隐藏下拉选择
		if(knowledge_id!=id){//自己不让添加自己
			$('.content #parent_id').append("<button class='has_work' type='button' style='background-color:#d1edfc;border:1px solid #3bb4f2;margin-right:5px;' value='" + id + "'>" + name + "</button>");
			$('.content #word').hide();
		}
		//
		//点击移除标签
		for(var i=0;i<$('.content #parent_id button').length;i++){
			$('.content #parent_id button').eq(i).click(function(){
				$(this).remove();
			})
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