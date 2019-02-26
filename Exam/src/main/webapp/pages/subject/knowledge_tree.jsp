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
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/ztree/css/metroStyle.css">
</head>
<body>
<main>

<!-- 知识点新增、修改表单 -->
<table>
	<tr>
		<td style="vertical-align: top;">
			<div id="k_left" style="padding-left: 20px;padding-top: 15px;width: 350px;">
				<button id="k_add" class="am-btn am-btn-default am-btn-xs"><span class="am-icon-plus" style="color:#5ab66b;">&nbsp;&nbsp;新增知识点</span></button>
				<ul id="k-ztree" class="ztree"></ul>
			</div>
		</td>
		<td style="vertical-align: top;">
			<div id="k_right">
					<div id="s_title" style="font-size: 16px;text-align: center;color: #000000;margin-top: 20px;margin-bottom: 10px;">知识点详细信息</div>
					<form class="am-form am-form-horizontal">
					  <fieldset>
					  
						<input id="k_id" type="hidden">
						
			    		<div class="am-form-group">
					      <div style="width:477px;font-size: 12px;padding-left:127px;text-align: left;" id="parent_id"></div>
					      <span class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;font-weight: normal;" for="k_parent_id">父级知识点: </span>
					      <input style="width:350px;height:30px;font-size: 12px;" type="text" id="k_parent_id" placeholder="搜索以进行添加（非必填）">
					      <div style="width:477px;font-size: 12px;padding-left:127px;text-align: left;" id="word"></div>
					    </div>
		
			    		<div class="am-form-group">
					      <span class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="k_name">知识点名称: </span>
					      <input style="width:350px;height:30px;font-size: 12px;" type="text" id="k_name" placeholder="">
					    </div>
		
			    		<div class="am-form-group">
					      <span class="am-u-sm-3 am-form-label" style="line-height:12px;font-size: 14px;" for="k_desc">知识点描述: </span>
					      <input style="width:350px;height:30px;font-size: 12px;" type="text" id="k_desc" placeholder="">
					    </div>
					    
					    <div style="text-align: center;color: #ffffff;">
					    	<button id="k_delete" type="button" class="am-btn am-btn-xs" style="background-color: #a9a9a9;width:80px;margin-right: 10px;">删除</button>
							<button id="k_submit" type="button" class="am-btn am-btn-xs" style="background-color: #59b56a;width:80px;margin-left: 10px;">保存</button>
					    </div>
					    
					  </fieldset>
					</form>
			</div>
		</td>
	</tr>
</table>


<!-- 知识点模态框：删除 -->
<div class="am-modal am-modal-confirm" tabindex="-1" id="my-confirm">
  <div class="am-modal-dialog">
    <div class="am-modal-hd">知识点详细信息</div>
    <div class="am-modal-bd">
      你，确定要删除这条记录吗？
    </div>
    <div class="am-modal-footer">
      <span class="am-modal-btn" data-am-modal-cancel>取消</span>
      <span class="am-modal-btn" data-am-modal-confirm>确定</span>
    </div>
  </div>
</div>


<div id="knowledge_add_model" onload="knowledge_add_load()" onclickOk="knowledge_add_yes()" onclickConsole="knowledge_no()">


</div>
<script src="${pageContext.request.contextPath}/static/js/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/jquery/jquery-1.11.3.js"></script>
<script src="${pageContext.request.contextPath}/static/js/head.js"></script>
<script src="${pageContext.request.contextPath}/static/js/onlineexam.js"></script>
<script	src="${pageContext.request.contextPath}/static/js/jquery.json-2.2.js"></script>
<script	src="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/amazeui/amazeui.datatables.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/table/table.js"></script>
<script	src="${pageContext.request.contextPath}/static/ztree/js/jquery.ztree.all.js"></script>
</body>

<script type="text/javascript">
$(function(){
	$(".down").css("background-color","rgba(255,255,255,0.3)")
})
var url=window.location.href;
var pid = url.split("?")[1].split("&")[0].split("=")[1];
var pname = decodeURI(url.split("?")[1].split("&")[1].split("=")[1]);

$("#s_title").html(pname + "相关知识点");
//****************************某科目的相关知识点************************************
//初始化Tree
$.ajax({
	url:"/exam/api/knowledge?method=getlist",
	type:"post",
    dataType:"json",
    contentType:"application/json",
    data:$.toJSON({
    	  "parameters":{query:"3",subject_id:pid}
    }),
    success:function(data){
    	//alert(JSON.stringify(data));
		var setting = {
            	callback: {
	            	onClick: selectK
            	},
            	data:{
	            	key: {name: "k_name"},//设置节点名称字段
	            	simpleData: {enable: true, idKey: "id", pIdKey: "k_parent_id"}//设置节点id、父节点id
	            }
		};
        $.fn.zTree.init($("#k-ztree"),setting,data.rows);//调用初始化方法init创建ztree
        var treeObj = $.fn.zTree.getZTreeObj("k-ztree"); 
        //全部展开
         treeObj.expandAll(true);
    },
	error:function(){
		alert("请求错误");
	}
})

// 点击树某节点触发修改操作
function selectK(event, treeId, treeNode) {
	//清空k_id
	$("#k_id").val("");
	//清空表单信息
	$('#parent_id').empty().show();
	$("#k_parent_id").val("");
	$('#word').empty().show();
	$("#k_name").val("");
	$("#k_desc").val("");
	
  	//给k_id赋值
	$("#k_id").val(treeNode.id);
	//显示表单删除按钮
	$("#k_delete").show();
	//回显知识点
	$.ajax({
		url:"/exam/api/knowledge/"+treeNode.id+"?method=get",
		type:"post",
	    dataType:"json",
	    contentType:"application/json",
	    data:$.toJSON({"":""}),
	    success:function(data){
	    	//alert(JSON.stringify(data));
	    	$("#k_name").val(data.row.k_name);
	    	$("#k_desc").val(data.row.k_desc);
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
	    	  "parameters":{"query":2,"k_kid_id":treeNode.id}
	    }),
	    success:function(data){
	    	//alert(JSON.stringify(data));
	    	var list = data.rows;
	    	if(list!=null && list.length>0){
		    	for(var i=0;i<list.length;i++){
			    	$('#parent_id').append("<button class='has_work' type='button' style='background-color:#d1edfc;border:1px solid #3bb4f2;margin-right:5px;' value='" + list[i].k_parent_id + "'>" + list[i].k_name + "</button>");
	    		}
	    	}
	    },
		error:function(data){
			alert(JSON.parse(data.responseText).errors[0].message);
		}
	});
   	//给回显的父级配置点击移除事件
	for(var i=0;i<$('#parent_id button').length;i++){
		$('#parent_id button').eq(i).click(function(){
			$(this).remove();
		})
	}
};
//****************************新增按钮事件************************************
$("#k_delete").hide();//页面进来默认隐藏表单的删除按钮
$("#k_add").click(function(){
	//清空k_id
	$("#k_id").val("");
	//清空表单信息
	$('#parent_id').empty().show();
	$("#k_parent_id").val("");
	$('#word').empty().show();
	$("#k_name").val("");
	$("#k_desc").val("");
	//隐藏表单的删除按钮
	$("#k_delete").hide();
})

//****************************提交按钮事件************************************
$("#k_submit").click(function(){
	if($("#k_id").val()==""){//新增提交
		var param = {
			subject_id:pid,
			k_name:$("#k_name").val(),
			k_desc:$("#k_desc").val(),
			k_parent_ids:[]
		};
		for(var i=0;i<$('#parent_id button').length;i++){
			param.k_parent_ids.push({"k_parent_id":$('#parent_id button').eq(i).val()})
		}
	
		$.ajax({
			url:"/exam/api/knowledge?method=post",
			type:"post",
		    dataType:"json",
		    contentType:"application/json",
		    data:$.toJSON(param),
		    success:function(data){
		    	alert("新增知识点成功！");
				//刷新页面
		    	window.location.href = window.location.href;
		    },
			error:function(data){
				alert(JSON.parse(data.responseText).errors[0].message);
			}
		});
	}else{//修改提交
		var param = {
				operate:0,
				id:$("#k_id").val(),
				k_name:$("#k_name").val(),
				k_desc:$("#k_desc").val(),
				k_parent_ids:[]
		};
		for(var i=0;i<$('#parent_id button').length;i++){
			param.k_parent_ids.push({"k_parent_id":$('#parent_id button').eq(i).val()})
		}
		
		$.ajax({
			url:"/exam/api/knowledge?method=put",
			type:"post",
		    dataType:"json",
		    contentType:"application/json",
		    data:$.toJSON(param),
		    success:function(data){
		    	alert("修改知识点成功！");
				//刷新页面
				window.location.href = window.location.href;
		    },
			error:function(data){
				alert(JSON.parse(data.responseText).errors[0].message);
			}
		});
	}
})

//****************************删除按钮事件************************************
$('#k_delete').click(function(){
	$('#my-confirm').modal({
		relatedTarget: this,
		onConfirm: function(options) {
			var param = {
					operate:1,
					id:$("#k_id").val()
			};
			console.log(param);
			$.ajax({
				url:"/exam/api/knowledge?method=put",
				type:"post",
			    dataType:"json",
			    contentType:"application/json",
			    data:$.toJSON(param),
			    success:function(data){
			    	alert("删除知识点成功！");
					//刷新页面
					window.location.href = window.location.href;
			    },
				error:function(data){
					alert(JSON.parse(data.responseText).errors[0].message);
				}
			});
		},
		// closeOnConfirm: false,
		onCancel: function() {
		}
	});	 
})



//【下拉提示、动态添加框】**************************start*********************************
	//当键盘键被松开时发送Ajax获取数据
	$('#k_parent_id').keyup(function(){
	 	var keywords = $(this).val();
		if (keywords=='') { $('#word').hide(); return };
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
				$('#word').append('<div>正在加载。。。</div>');
			},
		    success:function(data){
		    	//console.log(JSON.stringify(data));
				$('#word').empty().show();
				if (data.rows.length>0){
					for (i=0; i<data.rows.length;i++){
						$('#word').append("<div class='click_work' onclick='tie(\"" + data.rows[i].id + "\",\"" + data.rows[i].k_name +"\")'" + 'onmouseover="this.style.backgroundColor=\'#cce5ff\'" onmouseout="this.style.backgroundColor=\'#FFFFFF\'">'+ data.rows[i].k_name +'</div>');
					}
				}else{
					$('#word').append('<div class="error">没有发现  "' + keywords + '"</div>');
				}
			},
			error:function(){
				$('#word').empty().show();
				$('#word').append('<div class="click_work">搜索关键词 "' + keywords + '"失败！</div>');
			}
		});
	})
	//点击搜索数据时
	function tie(id,name){
		//重复添加remove掉原来的
		for(var i=0;i<$('#parent_id button').length;i++){			
			if($('#parent_id button').eq(i).val()==id){
				$('#parent_id button').eq(i).remove();
			}
		}
		//添加标签并隐藏下拉选择
		if($("#k_id").val()!=id){//自己不让添加自己
			$('#parent_id').append("<button class='has_work' type='button' style='background-color:#d1edfc;border:1px solid #3bb4f2;margin-right:5px;' value='" + id + "'>" + name + "</button>");
			$('#word').hide();
		}
		//
		//点击移除标签
		for(var i=0;i<$('#parent_id button').length;i++){
			$('#parent_id button').eq(i).click(function(){
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