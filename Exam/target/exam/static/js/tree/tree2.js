
$(document).ready(function(){	
var setting = {              
            async: {  
                enable: true,//开启异步加载模式  
                contentType: "application/json", //Ajax 提交参数的数据类型。  
                type: "post",   
                dataType: "json",//Ajax 获取的数据类型  
                url : "/attendance/api/person?method=getlist",
                dataFilter:ajaxDataFilter,
                //自动提交当前节点的id  
                //假设 异步加载 父节点(node = {id:1, name:"test"}) 的子节点时，将提交参数 id=1  
                autoParam: ["org_ucode=parameters"],
                //otherParam:{"parameters":{"org_ucode":"1"}}
            },  
              
            //Ajax 返回的数据格式中，页面主要参数的设置  
            data:{
				key: {
    				name: "org_full_name",//设置节点名称
    				isParent:"type"
    			},
				simpleData:{
					enable: true,
					idKey:"org_ucode",//设置节点id
					pIdKey:"parent_ucode"//设置父节点id
				}
			},  
            
            //树形图动作  
            view: {  
                expandSpeed: "fast", //节点展开的速度  
                selectedMulti: false //设置是否允许同时选中多个节点。  
            }, 
            //增加多选框
           check: {
     	       enable: true,
     	       /*chkStyle: "checkbox",
     	       chkboxType: { "Y": "s", "N": "ps" }*/
     	     },  
            //回调函数的设置  
            callback: {  
                //onClick: zTreeOnClick, //点击事件，当点击节点，做的事情。  
            	

            }  
     	    
	}
	 

	
            
			function ajaxDataFilter(treeId, parentNode, responseData) {				
				if (responseData.rows) {									
					for (var i = 0; i < responseData.rows.length; i++) {
						responseData.rows[i].org_ucode={"parent_ucode":responseData.rows[i].org_ucode};
						if(responseData.rows[i].type==0){
							if(responseData.rows[i].parent_ucode==1){
								responseData.rows[i].icon ="../static/images/caq.jpg";
							}else{
								responseData.rows[i].icon ="../static/images/2.png";
							}
							responseData.rows[i].type=true;		        	
							responseData.rows[i].nocheck=true
						}else{
							responseData.rows[i].type=false;
							responseData.rows[i].nocheck=false
							responseData.rows[i].icon ="../static/images/person.jpg";
						}
					}
				}
				//console.log(responseData.rows)
				return responseData.rows;
			};
		
			
	   function refreshNode() {  
		    var zTree = $.fn.zTree.getZTreeObj("treeDemo"),  
		    type = "refresh",  
		    // 刷新完之后是否展开子节点   true 不展开 ，false 展开
		    silent = false,  
		    nodes = zTree.getSelectedNodes();  
		   // 根据 zTree 的唯一标识 tId 快速获取节点 JSON 数据对象  
		    var parentNode = zTree.getNodeByTId(nodes[0].tId);  
		    // 选中指定节点  
		     zTree.selectNode(parentNode);  
		     //强制刷新
		     zTree.reAsyncChildNodes(parentNode, type, silent);  
		} 
	   
	   
	   
	     
           
           
           
		$.fn.zTree.init($("#treeDemo"),setting);
//		
//		$(".ztree").find("a").each(function(idx,item){
//			$($(item).find("span")[0]).bind("click",function(event){
//				console.log('== clicked');
//			    event.target.style="margin-right:2px;background-image:url('../static/images/download.jpg');background-repeat: no-repeat;"+
//			     " "+
//			        ";background-size:cover;vertical-align:top;*vertical-align:middle";
//			});
//		})
//		$(".ztree li span.button.section_ico_open").css({"margin-right":"2px", 
//	        "background-image":"url(../static/images/download.jpg) no-repeat scroll 0 0 transparent",
//	        "background-size":"cover",
//	        "vertical-align":"top",
//	        "*vertical-align":"middle"})
//	        
//			$(".ztree li span.button.section_ico_close").css({"margin-right":"2px", 
//			                "background-image":"url(../static/images/download.jpg) no-repeat scroll 0 0 transparent",
//			                "background-size":"cover",
//			                "vertical-align":"top",
//			                "*vertical-align":"middle"})
//			                
//			$(".ztree li span.button.person_ico_docu").css({"margin-right":"2px", 
//	        "background-image":"url(../static/images/person.jpg) no-repeat scroll 0 0 transparent",
//	        "background-size":"cover",
//	        "vertical-align":"top",
//	        "*vertical-align":"middle"}) 
			
		
		
		
		/*function zTreeOnClick(event, treeId, treeNode) {
			//console.info(treeNode);
			refreshNode();
		};
			*/  
		
}) 
 

		
	   
   
   
   
   
   
   
   