<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport"
        content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>Selected</title>
  <!-- <link rel="stylesheet" href="http://cdn.amazeui.org/amazeui/2.4.1/css/amazeui.min.css"/> -->
  <link href="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.css" rel="stylesheet">
  
</head>
<body>

<select data-am-selected="{maxHeight: 200}" id="select" lable="请选择部门" style="font-size:12px;"><select>
<select data-am-selected="{maxHeight: 200}" id="select1" lable="请选择部门" style="font-size:12px;"><select>
<button class="btn">奥术大师多</button>
<script src="<c:url value='/static/js/jquery/jquery.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/static/js/jquery.json-2.2.js'/>"></script>
<script src="<c:url value='/static/js/amazeui/amazeui.min.js'/>"></script>
<script>
var inputRadio=function(element,url,par,arr,array){
	var radio_lable=element.attr("lable");
	element.wrap('<div class="radio_wrap"></div>')
	element.before('<lable>'+radio_lable+"："+'</lable>')
	this.render=function(backVal){
		if(url!=""){
			$.ajax({
			    url:url,
			    type:"post",
			    dataType:"json",
			    data:$.toJSON(par),
			    contentType:"application/json",
			    success:function(data){
			    	//var data=JSON.stringify(data.rows);
			    $("#select").append("<option value=''>"+'请选择...'+"</option>")
			    $("#select1").append("<option value=''>"+'请选择...'+"</option>")
			    for(var i=0;i<data.rows.length;i++){       	 
			    	element.append("<option value="+data.rows[i][arr.val]+">"+data.rows[i][arr.txt]+"</option>");
			    }
			    
			    for(var i=0;i<element.find("option").length;i++){
			    	var val=element.find("option").eq(i).val();
			    	if(val==backVal){
			    		element.find("option").eq(i).attr('selected', true);
			    	}
			    }
			    },        
			    error:function(data){
			    	alert(JSON.parse(data.responseText).errors[0].message)
			        alert("保存失败")
			    }
			})
		}else{
			for(var i=0;i<array.length;i++){       	 
		    	element.append("<option value="+array[i][arr.val]+">"+array[i][arr.txt]+"</option>");
		    }
			for(var i=0;i<element.find("option").length;i++){
		    	var val=element.find("option").eq(i).val();
		    	if(val==backVal){
		    		element.find("option").eq(i).attr('selected', true);
		    	}
		    }
		}
		
	}
	
}

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

</script>
</body>
</html>