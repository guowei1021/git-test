<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>tree2</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="<c:url value='/static/js/tree/js/jquery-1.4.4.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/static/js/tree/js/jquery.ztree.core.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/static/js/tree/js/jquery.ztree.excheck.js'/>"></script>
<script type="text/javascript" src="<c:url value='/static/js/tree/tree2.js'/>"></script>
<script type="text/javascript" src="<c:url value='/static/js/jquery.json-2.2.js'/>"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/js/tree/css/zTreeStyle/zTreeStyle.css" type="text/css">

</head>
<body>	
 <button id="hahaha">点击输出样式</button> 
<ul id="treeDemo" class="ztree"></ul>

<style>

</style>
<script type="text/javascript">
/* $("#hahaha").click(function(){
	/* $(".ztree").find("a").each(function(idx,item){
		
		$($(item).find("span")[0]).style="margin-right:2px;background-image:url('../static/images/download.jpg');background-repeat: no-repeat;"+
		     " "+
		        ";background-size:cover;vertical-align:top;*vertical-align:middle";
		});
	}) */
 /* $(".ztree").find("a").each(function(idx,item){
	$($(item).find("span")[0]).bind("click",function(event){
		console.log(event);
	    event.target.style="margin-right:2px;background-image:url('../static/images/download.jpg');background-repeat: no-repeat;"+
	     " "+
	        ";background-size:cover;vertical-align:top;*vertical-align:middle";
	});
})
});  */


</script>
</body>
</html>