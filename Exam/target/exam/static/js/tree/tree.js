var Tree=(function(element,url,isChecked,data,checkboxType){
	var idKey= data.idKey
	var pIdKey=data.pIdKey
	
	
	
	var setting = {              
            async:{  
                enable: true,//开启异步加载模式  
                contentType: "application/json", //Ajax 提交参数的数据类型。  
                type: "post",   
                dataType: "json",//Ajax 获取的数据类型  
                url : url,
                //dataFilter:ajaxDataFilter,
                //自动提交当前节点的id  
                //假设 异步加载 父节点(node = {id:1, name:"test"}) 的子节点时，将提交参数 id=1  
                autoParam: ["paras=parameters"],
                //otherParam:{"parameters":{"parent_ucode":"1"}}
            },  
              
            //Ajax 返回的数据格式中，页面主要参数的设置  
            data:{
				key:{
    				name: data.name,//设置节点名称
    				isParent:data.isParent
    			},
				simpleData:{
					enable: true,
					idKey:idKey,//设置节点id
					pIdKey:pIdKey//设置父节点id
				}
			},  
            
            //树形图动作  
            view: {  
                expandSpeed: "fast", //节点展开的速度  
                selectedMulti: false //设置是否允许同时选中多个节点。
            }, 
            //增加多选框
           check: {
     	       enable: isChecked,
     	       /*chkStyle: "checkbox",*/
     	       chkboxType: checkboxType
     	     },  
            //回调函数的设置  
            callback: {  
            	/*onClick: eval("("+_setClick+")"), //点击事件，当点击节点，做的事情。  
            	onCheck: eval("("+_setCheck+")")*/
            }  
     	    
    };
	//刷新子节点
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
	//字段映射
	var nodeType
	var nodeTypeMap={}
	var defaultNodeType={}
	this.setNodeType=function(_nodeType,_nodeTypeMap,_defaultNodeType){			
		nodeType = _nodeType
		nodeTypeMap = _nodeTypeMap
		defaultNodeType = _defaultNodeType		
		var keys = Object.keys(_nodeTypeMap);
		for(var n = 0;n<keys.length;n++){
			var key = keys[n];
			var value = _nodeTypeMap[key];			
			
		}
											
		
	}
			
	//单击节点事件	
	this.setClick=function(setClick){		
		setting.callback.onClick=setClick	
		
	} 
	

	//点击多选框事件	
	this.setCheck=function(setCheck){		
		setting.callback.onCheck=setCheck	
	}
	
    //请求参数 	
	this.ajaxParameters=function(row){
		return eval("({" + pIdKey + ":row." + idKey + "})");
	}
	
	//添加对应图标
	this.canSelected=function(row){
		var aa=[];
		var bb=[];
		var keys = Object.keys(nodeTypeMap);
		for(var n = 0;n<keys.length;n++){
			var key = keys[n];
			var value = nodeTypeMap[key];
			aa.push(key)
			bb.push(value)
		}				
			if(row[nodeType]==aa[0]) {	
				row.icon =bb[0].icon;
				row.nocheck=true
			}else if(row[nodeType]==aa[1]){
				row.icon =bb[1].icon;
				row.nocheck=false
			}else{
				row.icon =defaultNodeType.icon;
			}
		
		
	}
	


	this.render = function() {
			(function(_ajaxParameters,_canSelected) {
				setting.async.dataFilter = function(treeId, parentNode, responseData) {
				
				if (responseData.rows) {
					for (var i = 0; i < responseData.rows.length; i++) {
						var row = responseData.rows[i];						
						row.paras = _ajaxParameters(row);					  
						_canSelected(row)
						if (row[data.isParent] == "1") {
							
							row[data.isParent]=true;
						} else {
							
							row[data.isParent]=false;
						}

					}
				}
				return responseData.rows;
			};
		})(this.ajaxParameters,this.canSelected);
			
			
			
			
		$(document).ready(function(){
			  
			  
			  $.fn.zTree.init(element,setting);
			  
			   
		});
		
	}

}) 

		
	   
   
   
   
   
   
   
   