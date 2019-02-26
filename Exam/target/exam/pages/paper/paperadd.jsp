<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	    <title>增加试卷模板</title>
	   	<link href="${pageContext.request.contextPath}/static/js/amazeui/amazeui.datatables.min.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/static/css/table.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/static/css/style.css" rel="stylesheet">
	<style>
	body,th,tr,td{font-size:12px;}
	.table .am-pagination{   
		width: 600px;
	    bottom: -20px;
	    left: 485px;
	    position: absolute;
	}
	.modal-components{
		padding:20px;
		background-color:#fff;
	}
	.modal-title{
		border-bottom:1px solid #eef1f5;
		min-height:48px;
		margin-bottom:10px;
	}
	.viewmodal{
		text-align:left;
	}
	.viewmodal-list{
		font-size:14px;
		font-weight:bold;
		background-color:#32c5d2;
	}
	table>tbody>tr>td:nth-child(3){
		max-width: 60px;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}
	table, td, th{
		border: solid 1px #eee;
		border-spacing: 1px;
  		border-collapse: separate;
	}
	td{
		padding:15px;
		
	}
	th{
		background-color: #eee;
	}
	.chaptertable{
		border: solid 1px #847f7f;
	}
	
	</style>
	</head>
	
	<body>
	<main>
		<div class="modal-components">
			<div >
				<div style="font-size:18px;padding: 10px;color:#32c5d2;font-weight: 700;text-align: left;border-bottom:#fff;">
					增加试卷模板
				</div>
			</div>
		<div>
    	<hr>
        <div class="am-u-sm-10" >
        	<div>
        		<table  border="1" cellpadding="5px">
        			<tbody>
						
						<tr>
	                        <th>试卷模板名称 : </th>
	                        <td ><input type="text" name="epName" class="" size="50" maxlength="50" style="width:500px" /></td>
                   		</tr>

                   		<!-- <tr>
                   			<th>试卷说明 ：</th>
                   			<td><input type="text" name="remark" class="" size="50" maxlength="50" style="width:500px" /></td>
                   		</tr> -->

                   		<tr>
                   			<th></th>
                   			<td>
                   				<div style="margin:0 0 5px 0;">
									<input type='button' class='' value='增加章节' onclick='addChapter()'/>
								</div>
                   			</td>
                   		</tr>

                   		<tr>
                   			<th rowspan="0" id="chapterSetting">章节设定 ：</th>
                   			<td id="chapter">
                   				<!-- <table>
                   					<tbody>
                   						<tr>
                   							
                   						</tr>
                   					</tbody>
                   				</table> -->
                   				<table class="chaptertable">
	                   				<tbody>
	                   					<tr>
											<td>
												<input type="text" name="chapter_name"  size="40" maxlength="20" placeholder="章节名称">
												&nbsp;
												<select name="type" class="" style="min-width:100px">
													<option value="">请选择本章节题型</option>
													<option value="0">单选题</option>
													<option value="1">多选题</option>
												</select>
												&nbsp;
												<button class="am-icon-plus-circle addchapterPolicy" >增加章节组题规则</button>
											</td>
											<th>
												<button class="am-icon-remove">删除本章</button>
											</th>
											<!-- <th width="50" rowspan="4" style="text-align:center;">
												<a href="javascript:;" onclick="" class="am-icon-close am-icon-lg" ></a>
											</th> -->
										</tr>

										<!-- 章节策略 -->
										<tr>
											<td>
												题库 : 
												<select multiple data-am-selected="{maxHeight:170,btnWidth:'35%',btnSize:'xs'}" minchecked="1" placeholder="请选择题库" id="demo-maxchecked">
												  <option value="a">质量管理</option>
												  <option value="b">质量测试</option>
												  <option value="o">六西格玛管理</option>
												  <option value="m">王教授提供的</option>
												</select>
												&nbsp;
												知识点 :
												<select data-am-selected="{searchBox:1,maxHeight:170,btnWidth:'35%',btnSize:'xs'}">
												   <option value=""></option>
												  <option value="a">六西格玛理论</option>
												  <option value="b">李四</option>
												  <option value="o">王五</option>
												  <option value="m">赵柳</option>
												  <option value="phone">iPhone</option>
												  <option value="im">iMac</option>
												  <option value="mbp">Macbook Pro</option>
												</select>
												<br>
												<br>
												
												试题难度 : 
												<select data-am-selected="{maxHeight:170,btnWidth:'35%',btnSize:'xs'}">
												  <option value=""></option>
												  <option value="0">简单</option>
												  <option value="1">中等</option>
												  <option value="2">困难</option>
												</select>
												&nbsp;
												试题数量 : 
												<input type="text" class="" maxlength="3" size="3" name="number" value="1">
												&nbsp;
												每题分值 : 
												<input type="text" class="" maxlength="2" size="3" name="score" value="0">
											</td>
											<th>
												<button class="am-icon-remove">删除此组题规则</button>
											</th>
										</tr>

									</tbody>
								</table>

                   			</td>
                   		</tr>

        			</tbody>
        		</table>
        	</div>

        </div>
        </div>
	</body>
		
<script src="<c:url value='/static/js/jquery.min.js'/>"></script>
<script src="${pageContext.request.contextPath}/static/js/jquery/jquery-1.11.3.js"></script>
<script src="${pageContext.request.contextPath}/static/js/head.js"></script>
<script src="${pageContext.request.contextPath}/static/js/onlineexam.js"></script>
<script src="<c:url value='/static/js/jquery/jquery.min.js'/>"></script>
<script src="<c:url value='/static/js/jquery.json-2.2.js'/>"></script>
<script src="<c:url value='/static/js/amazeui/amazeui.min.js'/>"></script>
<script src="<c:url value='/static/js/amazeui/amazeui.datatables.min.js'/>"></script>
<script src="<c:url value='/static/js/table/table.js'/>"></script>	
<script type="text/javascript">
$(function(){
	$(".down").css("background-color","rgba(255,255,255,0.3)")
})
//*******************************方法*********************************************
var chapterContent = " "; 
//点击添加章节
function addChapter(){
	//增加章节设定格的跨行数量
	$('#chapterSetting').attr("rowspan",parseInt($('#chapterSetting').attr("rowspan"))+1);
	//alert($('#chapterSetting').attr("rowspan"));
	//追加章节内容
	$('#chapter').append('&nbsp;<table class="chaptertable"<tbody><tr><td><input type="text" name="p_section_names"  size="40" maxlength="20" placeholder="章节名称">&nbsp;<select name="p_qtypes" class="" style="min-width:100px"><option value="">请选择本章节题型</option><option value="201">单选题</option><option value="202">多选题</option></select>&nbsp;<button class="am-icon-plus-circle addchapterPolicy" >添加章节组题规则</button></td><th width="50" rowspan="2" style="text-align:center;"><a href="javascript:;" onclick="" class="am-icon-close am-icon-lg" ></a></th></tr><tr><td><a href="javascript:;" onclick="" class="am-icon-minus-circle" ></a><input type="text" name="p_dbids_view" id="p_dbids_view_0"  readonly="" size="50" placeholder="请选择题库" onclick="javascript:tm_show_db_selector();"><input type="hidden" name="p_dbids" id="p_dbids_0"><select name="p_levels" class="validate[required] tm_select" style="min-width:100px"><option value="">选择难度</option><option value="1">简单</option><option value="3">中等</option><option value="4">困难</option></select>试题数量 : <input type="text" class="validate[required,custom[integer],min[1],max[500]] tm_txt" maxlength="3" size="3" name="p_qnums" value="1">每题分值 : <input type="text" class="validate[required,custom[integer],min[1]] tm_txt" maxlength="2" size="3" name="p_scores" value="0"></td></tr></tbody></table>')
	//alert( $(".addchapterPolicy").length)
	$(".addchapterPolicy").eq($(".addchapterPolicy").length-1).click(function(){
		console.log($(this));
		console.log(this);
		$(this).parent().parent().parent().append('<tr><td>11111</td><th>111</th></tr>');
 	})
		
	
}
/* function aab(xxx){
	$(xxx).parent().parent().parent().append('<tr><td>11111</td><th>111</th></tr>');
} */
//添加章节组题规则
function addChapterPolicy(){
	
}

//删除章节组题规则
function deleteChapterPolicy(){
	
}


$(function(){
	//addChapter();
	/* for (var i = 0; i < $(".am-icon-plus-circle").length; i++) {
		$(".am-icon-plus-circle").eq(i).click(function(){
			$(this).parent().parent().parent().append('<tr><td>11111</td></tr>')
		})
	} */
});


		
</script>
		
</html>