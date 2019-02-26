<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>tree</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="<c:url value='/static/js/tree/js/jquery-1.4.4.min.js'/>"></script>
<script src="<c:url value='/static/js/jquery/jquery.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/static/js/tree/js/jquery.ztree.core.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/static/js/tree/js/jquery.ztree.excheck.js'/>"></script>
<script type="text/javascript" src="<c:url value='/static/js/tree/tree.js'/>"></script>
<script type="text/javascript" src="<c:url value='/static/js/jquery.json-2.2.js'/>"></script>
<script type="text/javascript" src="<c:url value='/static/js/amazeui/amazeui.min.js'/>"></script>
<link href="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/js/tree/css/zTreeStyle/zTreeStyle.css" type="text/css">
</head>
<body>	

<ul id="treeDemo" class="ztree"></ul>

<script type="text/javascript">

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
	
    //tree.setInput("选择相关部门 :","选择相关部门")  
    
	tree.render();
	
</script>
</body>
</html>