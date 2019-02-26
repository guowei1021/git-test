<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>input</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="<c:url value='/static/js/tree/js/jquery-1.4.4.min.js'/>"></script>
<script src="../static/js/jquery/jquery.min.js"></script>
<script type="text/javascript" src="<c:url value='/static/js/tree/js/jquery.ztree.core.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/static/js/tree/js/jquery.ztree.excheck.js'/>"></script>
<script type="text/javascript" src="<c:url value='/static/js/tree/tree.js'/>"></script>
<script type="text/javascript" src="<c:url value='/static/js/jquery.json-2.2.js'/>"></script>
<script type="text/javascript" src="<c:url value='/static/js/amazeui/amazeui.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/static/js/laydate/laydate.js'/>"></script>
<script type="text/javascript" src="<c:url value='/static/js/load/load.js'/>"></script>
<script type="text/javascript" src="input.js"></script>

<script type="text/javascript" src="jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="jquery-ui/jquery.multiselect.js"></script>

<link href="jquery-ui/jquery-ui.min.css" rel="stylesheet">
<link href="jquery-ui/jquery.multiselect.css" rel="stylesheet">

<link href="input.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/js/tree/css/zTreeStyle/zTreeStyle.css" type="text/css">
</head>
<body>	

<!-- 输入框 -->
<div style="width:500px;">
<input name="name" type="text" lable="姓名" value="" placeholder="请输入姓名" class="input" id="aa" require="true">
<input name="name" type="text" lable="啥空间的哈可接受的" value="阿萨法" placeholder="请输入姓名" class="input"   id="bb"  require="true" >
<input name="name" type="text" lable="赛区电话㔿" value="案说法是否打算" placeholder="请输入姓名" class="input" require="false">
<button class="btn">奥术大师多</button>
</div>
<!-- 下拉单选/多选 -->
<div style="width:500px;">
<select id="select" lable="请选择部门" style="font-size:12px;"><select>
<select id="select1" lable="请选择部门" style="font-size:12px;"><select>

<button class="btn">奥术大师多</button>
</div>
<!-- 下拉多选 -->
<div style="margin:50px;">

<select id="select_checkbox" multiple="multiple">  
      
</select>



</div>
<!-- 树形菜单 -->
<div style="width:500px;">
<input name="org" type="tree" lable="部门" placeholder="请选择部门" class="input tree_input" tree_ok="ok()" tree_nok="nok()" data-am-modal="{target: '#doc-modal-1', closeViaDimmer: 0}">
</div>


<div style="width:500px">
<input type="text" lable="生日" placeholder="点击选择出生日期" id="laydate" class="input" readonly>
</div>


<!-- 日期：年月日 -->
<!-- <input name="birthday" type="date" lable="生日" value="1994-03-05" placeholder="请选择出生日期"> -->
<!-- 时间：时分  是否用秒 -->
<!-- <input name="onwork" type="time" lable="上班时间" value="09:00:00" placeholder="请选择上班时间" 是否用秒="true"> -->
<!-- 日期时间： 年月日时分  是否用秒 -->
<!-- <input name="dksj" type="dateTime" lable="打卡时间" value="1994-03-05 09:00:00" placeholder="请选择打卡时间" 是否用秒="true"> -->
<!-- 年月 -->
<!-- <input name="yearMonth" type="yearMonth" lable="统计月份" value="1994-03" placeholder="请选择月份"> -->
<!-- 起止时间 年月日 -->
<!-- <input startname="s" endname="e" type="betweenDate" lable="起止时间" startvalue="1994-03-05" endvalue="1994-04-05" placeholder="请选择起止时间"> -->

<div class="box" style="width:500px;"></div>
<div class="project" style="width:300px;"></div>
<div id="load" style="width:500px;"></div>

<script type="text/javascript">
function ok(){
	//alert(1)
}
function nok(){
	//alert(2)
}

/* loadHTML($("#load"),"load.html")
loadHTML($("#load"),"load1.html")*/
$("#load").load("load.html")
$("#load").load("load1.html")
/* for(var i=0;i<5;i++){
	$("#load").append("<div class='bbb"+i+"'></div>")
	loadHTML($(".bbb"+i),"load.html",function(response,status,xhr){
    if(status=="success"){			    	    	
    	radio2.render();
    }		
})  
} */
/*loadHTML($("#load"),"load.html",function(response,status,xhr){
		    if(status=="success"){			    	
		    	
		    	radio2.render();
		    }		
}) */  

	 
/* $("#load").load("load.html",function(response,status,xhr){
		console.log(response)
		console.log(status)
		console.log(xhr)
	}) */
		
/* $("#btn_load1").click(function(){
	loadHTML($("#load"),"load.html #qqq")
})  */
/* $(function(){ */
	
	
	
	
	$(".btn2").click(function(){
		// alert($(".radio select").val())
	})
	/* 输入框错误回显 */
	
	if($("#aa").val()!="哈哈哈"){
		inputErroe($("#aa"),"出错了")
	}
	if($("#bb").val()!="哈哈哈"){
		inputErroe($("#bb"),"出打错了")
	}
		
	
	/* 下拉单选菜单 */		
	var radio=new inputRadio($("#select"),"/attendance/api/costOrg?method=getlist",{other:""},{"val":"cost_org_id","txt":"org_name_show"})
	radio.render();
	
	var array=[
		{"a":"asdasd","b":"奥术大师多"},
		{"a":"ewqrweq","b":"水电费水电费"},
		{"a":"fdgsfg","b":"天天合伙人"},
		{"a":"yturtyu","b":"回家工会经费"}
	]
	var radio1=new inputRadio($("#select1"),"","",{"val":"a","txt":"b"},array)
	radio1.render("fdgsfg");
	$(".btn").click(function(){
		alert($("#select").val())
		alert($("#select1").val())
	})
	
	/* 下拉多选菜单 */
	
	/* 树形菜单 */
	var tree = new Tree($("#treeDemo"),
			"/attendance/api/person?method=getlist", 
			true,	//是否复选 
			{
				name : "org_full_name",//设置节点名称对应的数据库字段名
				isParent : "isParent",//设置节点是否为父节点的数据库字段名（1：有子节点，0：没有子节点）
				idKey : "org_ucode",//设置节点id对应的数据库字段名
				pIdKey : "parent_ucode"//设置父节点id对应的数据库字段名
			})
	tree.setNodeType("type", //节点类型对应的数据库字段名
		{
			"0" : {"icon" : "../static/images/download.jpg"},	//节点类型的值为0,其图标地址
			"1" : {"icon" : "../static/images/person.jpg"}		//节点类型的值为1,其图标地址
		}, 
		{"icon" : "../static/images/2.png"}						//其他情况图标地址
	)
	tree.setClick(function zTreeOnClick(event, treeId, treeNode){
	   console.log(treeNode)
	})//单击节点事件
	tree.setCheck(function zTreeOnCheck(event, treeId, treeNode) {	    
		console.log(treeNode)
	})//单击多选框事件
	
	
	
	tree.render();
/* }) */
	
 $(function(){
	 laydate.render({
		  elem: '#laydate' //指定元素
		});
 })	
</script>
</body>
</html>