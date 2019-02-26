<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>table</title>
<meta name="keywords" content="index">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="renderer" content="webkit">
<meta name="apple-mobile-web-app-title" content="Amaze UI" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Cache-Control" content="no-siteapp" />
 




<link href="${pageContext.request.contextPath}/static/js/amazeui/amazeui.datatables.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/js/amazeui/amazeui.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/css/table.css" rel="stylesheet">
<style>
table.dataTable.dtr-inline.collapsed>tbody>tr>td:first-child:before, table.dataTable.dtr-inline.collapsed>tbody>tr>th:first-child:before{top: 0;}
</style>
</head>
<body>

<div id="t1" class="am-u-sm-8">

<div class="toolbar"><button id="add" class="add www"  value="增加"  onclick="add()"></button></div>

<table></table>

<div id="add-content" onload="load1()" onclickOk="ok1()" onclickConsole="nok1()">
<div style="font-size:14;font-weight:bold;margin-top:20px;" class="pop-content">增加</div>
</div>

<div id="delete-content" onload="load2()" onclickOk="ok2()" onclickConsole="nok2()">
<div style="font-size:14;font-weight:bold;margin-top:20px;" class="pop-content">你，确定要删除这条记录吗？</div>
</div>

<div id="revise-content" onload="load3()" onclickOk="ok3()" onclickConsole="nok3()">
<div style="font-size:14;font-weight:bold;margin-top:20px;" class="pop-content">修改</div>
</div>

<div id="details-content" onload="load4()" onclickOk="ok4()" onclickConsole="nok4()">
<div style="font-size:14;font-weight:bold;margin-top:20px;" class="pop-content">查看</div>
</div>
</div>




<div id="t2" class="am-u-sm-8">
<!--在表头上增加操作按钮-->
<button id="adds" class="add" value="增加"  onclick="add()"></button>


<table></table>

<div id="add-contents" onload="load1()" onclickOk="ok1()" onclickConsole="nok1()">
<div style="font-size:14;font-weight:bold;margin-top:20px;" class="pop-content">增加</div>
</div>

<div id="delete-contents" onload="load2()" onclickOk="ok2()" onclickConsole="nok2()">
<div style="font-size:14;font-weight:bold;margin-top:20px;" class="pop-content">你，确定要删除这条记录吗？</div>
</div>

<div id="revise-contents" onload="load3()" onclickOk="ok3()" onclickConsole="nok3()">
<div style="font-size:14;font-weight:bold;margin-top:20px;" class="pop-content">修改</div>
</div>

<div id="details-contents" onload="load4()" onclickOk="ok4()" onclickConsole="nok4()">
<div style="font-size:14;font-weight:bold;margin-top:20px;" class="pop-content">查看</div>
</div>

</div>

<button id="btn">点击刷新表格</button>
<div id="t3" class="am-u-sm-8">
<button id="add3" class="add" value="增加"></button>
<table></table>
</div>




<script src="<c:url value='/static/js/jquery.min.js'/>"></script>
<script src="<c:url value='/static/js/jquery/jquery.min.js'/>"></script>
<script src="<c:url value='/static/js/jquery.json-2.2.js'/>"></script>
<script src="<c:url value='/static/js/amazeui/amazeui.min.js'/>"></script>
<script src="<c:url value='/static/js/amazeui/amazeui.datatables.min.js'/>"></script>
<script src="<c:url value='/static/js/amazeui/dataTables.responsive.min.js'/>"></script>
<script src="<c:url value='/static/js/table/table.js'/>"></script>
<script>
 


	function add(){
		alert("增加")
	}
	function revise(){
		alert("修改")
	}
	function remove(){
		alert("删除")
	}
	function details(){
		alert("查看")
	}

	function load1(){
		alert("load1")
	}
	function load2(){
		alert("load2")
	}
	function load3(){
		alert("load3")
	}
	function load4(){
		alert("load4")
	}

	function ok2(){
		alert("ok2")					
		
	}
	function ok3(){
		alert("ok3")
	}
	function ok4(){
		alert("ok4")
	}
	function nok1(){
		alert("nok1")
	}function nok2(){
		alert("nok2")
	}function nok3(){
		alert("nok3")
	}function nok4(){
		alert("nok4")
	}
		
	function ok1(){		
		table.render(function(){
			alert(1234567)
		})
	}
	
	$(function(){
		
	 
	var arr= [	
			{
				data : "travel_startdate",
				title : '开始时间',				
			},
			{
				data : "travel_enddate",
				title : '结束时间'
			},
			{
				data : "travel_reason",
				title : '出差原因'
				/* defaultContent:""//设置某一列可以为空 */
			},
			{
				data : "travel_apply_id",
				title : '出差原因'
				//"visible": false  //这个是隐藏某一列
			},
			{
				data : "travel_reason",
				title : '出差原因'
			},							
			/* {
				data : "time",
				title : '时间'
			}, */
			{   
				data : null,
				title : "操作",
				sWidth:"25%",
				"render" : function(data, type, row) { // 返回自定义内容 /pro/src/main/webapp/jsp/rest/model.html  source
					 
					var buttonHtml = "";
				if(row.travel_reason=="四四"){
					return buttonHtml = '<button class="details table_btn details1" value="查看" onclick="details()" style="float:left;margin-right:5px;"></button>';
					 
				}else{
					return buttonHtml = '<button class="details table_btn details1" value="查看" onclick="details()" style="float:left;margin-right:5px;"></button>'+
					 '<button  class="revise table_btn revise1" value="修改" onclick="revise()" style="float:left;margin-right:5px;"></button>'+
					'<button class="delete delete1 table_btn" value="删 除" onclick="remove()" style="float:left;margin-right:5px;"></button>';	
				}
					 									
				}
			} 
   ];
	
	var url="/attendance/api/travels?method=getlist";
	var page=""	//p代表页码   l 代表  每页显示多少条  i  代表 一共多少条，当前多少条	
    var apply={apply_status:"1"};
	
	var table=new DataGrid($('#t1'),page,url,arr,function(rows){
		 /*  
		 for(var i=0;i<rows.length;i++){
			if(rows[i].travel_enddate=="1517328000000"){
				rows[i].travel_enddate="结束时间"
			}
			rows[i].time=rows[i].travel_startdate+"--"+rows[i].travel_enddate
		}  */
		return rows;
		
	} );
	
	table.setTitle("中国质量协会")
	
	table.setParameters(apply);	
	
	table.setButtonEven(".www","#add-content");
	table.setButtonEven(".delete1","#delete-content");
	table.setButtonEven(".revise1","#revise-content");
	table.setButtonEven(".details1","#details-content");
	/* table.render(function(){
		alert(267676)
	}); */	

	
	
	var arrs= [	
		{
			data : "apply_status",
			title : '开始时间',				
		},
		{
			data : "maxdate",
			title : '结束时间'
		},
		{
			data : "mindate",
			title : '出差原因'                              
		},
		{
			data : "overtime_apply_id",
			title : '出差原因',
			"visible": false  //这个是隐藏某一列
		},
		{
			data : "overtime_reason",
			title : '出差原因'
		},									
		{
			data : null,
			title : "操作",
			sWidth:"25%",
			"render" : function(data, type, full) { // 返回自定义内容 /pro/src/main/webapp/jsp/rest/model.html  source
				 var buttonHtml = "";
				 return buttonHtml = '<button class="details detailss table_btn" value="查看" onclick="details()" style="float:left;margin-right:5px;"></button>'+
				 '<button class="revises revise table_btn" value="修改" onclick="revise()" style="float:left;margin-right:5px;"></button>'+
				'<button class="deletes delete table_btn" value="删除" onclick="remove()" style="float:left;margin-right:5px;"></button>';										
			}
		} 
];

			var urls="/attendance/api/overtime?method=getlist";
			var pages="pli"	//p代表页码   l 代表  每页显示多少条  i  代表 一共多少条，当前多少条	
			var applys={apply_status:1};
			var tables=new DataGrid($('#t2'),pages,urls,arrs,function(rows){	 
				return rows;
				
			} );

			tables.setParameters(applys);
			tables.setTitle("中国质量协会")
			/* tables.setButtonEven("#adds","#add-contents");
			tables.setButtonEven(".deletes","#delete-contents");
			tables.setButtonEven(".revises","#revise-contents");
			tables.setButtonEven(".detailss","#details-contents"); */
			/* tables.render(function(){
				$("td").click(function(){
					alert(11111)
				})
			}); */
			
	//点击某一个td  获取对应的隐藏的那一行的id,可以改为点击tr,button......
	/* $('#table tbody').on('click', 'td', function () {
        //先拿到点击的行号  
		var rowIndex = $(this).parents("tr").index();  
		//此处拿到隐藏列的id  
		var id = $('#table').DataTable().row(rowIndex).data().travel_apply_id;//和上面的data对应
	    alert(id)
    } );  */
    
    var dataSet3 = [
	       {
			     "name":"小明",
			     "age":"24",
			     "adress":"山西",
			     "sex":"man",
			     "height":"180cm"
		       },
		       {
			     "name":"小红",
			     "age":"24",
			     "adress":"北京",
			     "sex":"man",
			     "height":"180cm"
			   },
			   {
			     "name":"小李",
			     "age":"24",
			     "adress":"上海",
			     "sex":"man",
			     "height":"180cm"
			  },
			  {
			     "name":"小芳",
			     "age":"24",
			     "adress":"河南",
			     "sex":"man",
			     "height":"180cm"
			 },
			 {
			     "name":"小李",
			     "age":"24",
			     "adress":"上海",
			     "sex":"man",
			     "height":"180cm"
			  },
			  {
			     "name":"小芳",
			     "age":"24",
			     "adress":"河南",
			     "sex":"man",
			     "height":"180cm"
			 },
			 {
			     "name":"小李",
			     "age":"24",
			     "adress":"上海",
			     "sex":"man",
			     "height":"180cm"
			  },
			  {
			     "name":"小芳",
			     "age":"24",
			     "adress":"河南",
			     "sex":"man",
			     "height":"180cm"
			 },
			 {
			     "name":"小李",
			     "age":"24",
			     "adress":"上海",
			     "sex":"man",
			     "height":"180cm"
			  },
			  {
			     "name":"小芳",
			     "age":"24",
			     "adress":"河南",
			     "sex":"man",
			     "height":"180cm"
			 },
			 {
			     "name":"小李",
			     "age":"24",
			     "adress":"上海",
			     "sex":"man",
			     "height":"180cm"
			  },
			  {
			     "name":"小芳",
			     "age":"24",
			     "adress":"河南",
			     "sex":"man",
			     "height":"180cm"
			 },
			 {
			     "name":"小光",
			     "age":"45",
			     "adress":"河北",
			     "sex":"man",
			     "height":"180cm"
			 }
]   
			
    	var arr3= [	
			 {
					data : "name",
					title : '开始时间',				
				},
				{
					data : "age",
					title : '结束时间'
				},
				{
					data : "adress",
					title : '出差原因'                              
				},
				{
					data : "height",
					title : '出差原因',
					"visible": false  //这个是隐藏某一列
				},
				{
					data : "sex",
					title : '出差原因'
				},										
			 {
				data : null,
				title : "操作",
				sWidth:"25%",
				"render" : function(data, type, row) { // 返回自定义内容 /pro/src/main/webapp/jsp/rest/model.html  source
					
					var buttonHtml = "";
				if(row[0]=="小明"){
					return buttonHtml = '<button onclick="revise()" class="revise3 revise" value="修改" style="margin-right:5px;">修改</button>';
				}else{
					return buttonHtml = '<button onclick="revise()" class="revise3 revise " value="修改" style="margin-right:5px;">修改</button>'+
					'<button onclick="remove()" class="delete3 delete" value="删除" style="margin-right:5px;">删除</button>'
				}
					 										
				}
			} 
	];




				var page3="pli"	//p代表页码   l 代表  每页显示多少条  i  代表 一共多少条，当前多少条	
				
				var table3=new DataGrid($('#t3'),page3,"",arr3);
              /*  for(var i=0;i<dataSet3.length;i++){
            	   if(dataSet3[i].name=="小明"){
            		   dataSet3[i].name="小asda"
            	   }
               } */
               table3.setData(dataSet3);
               table3.setTitle("中国质量协会")
               table3.setButtonEven("#add3","#add-content");
           	   table3.setButtonEven(".delete3","#delete-content");
           	   table3.setButtonEven(".revise3","#revise-content");
           	
				table3.render(); 
				 
				$("table.dataTable.dtr-inline.collapsed>tbody>tr>td:first-child").click(function(){
		               setTimeout(function(){
		            	   var table3=new DataGrid($('#t3'),page3,"",arr3);
		            	   table3.setData(dataSet3);
			               table3.setTitle("中国质量协会")
			               table3.setButtonEven("#add3","#add-content");
			           	   table3.setButtonEven(".delete3","#delete-content");
			           	   table3.setButtonEven(".revise3","#revise-content");
						   table3.render();
							
		               },1)
				})
          
     
    $("#btn").click(function(){
    	/* var dttable = $('#t3 table').dataTable();
        dttable.fnClearTable(); //清空一下table
        dttable.fnDestroy();  */  
    	dataSet3[0].name="哈哈" ;
    	//alert(dataSet3[0].name)
    	/* table3.setData(dataSet3);
    	table3.render(); */
    	/* var dataSet4=dataSet3
    	console.log(dataSet4) */
    	 	  
			  //var table3=new DataGrid($('#t3'),page3,"",arr3);
              /* console.log(dataSet3)
              table3.setData(dataSet3); */
              
              //table3.setTitle("中国质量协会")
             /*  table3.setButtonEven("#add3","#add-content");
          	  table3.setButtonEven(".delete3","#delete-content");
          	  table3.setButtonEven(".revise3","#revise-content");
          	  table3.setButtonEven(".details3","#details-content");  */ 
          	
  			//table3.setData(dataSet3);
          	  
			table3.render(); 
			
    })

           
           	
			
	})				 


</script>
</body>
</html>