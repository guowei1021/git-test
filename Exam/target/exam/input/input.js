//错误信息回显
function inputErroe(element,content){
	element.blur(function(){
		var wrong=element.next()		   
		   wrong.text(content)
		   wrong.show();		   
		   setTimeout(function(){
			   wrong.hide();
			},5000)
	})	
	}

//获取url 参数值
var getParam = function (name) {
    var search = document.location.search;
    //alert(search);
    var pattern = new RegExp("[?&]" + name + "\=([^&]+)", "g");
    var matcher = pattern.exec(search);
    var items = null;
    if (null != matcher) {
        try {
            items = decodeURIComponent(decodeURIComponent(matcher[1]));
        } catch (e) {
            try {
                items = decodeURIComponent(matcher[1]);
            } catch (e) {
                items = matcher[1];
            }
        }
    }
    return items;
};
//下拉单选
var inputRadio=function(element,url,par,arr,array){
	element.attr("data-am-selected","{maxHeight: 200}")
	var radio_lable=element.attr("lable");
	element.wrap('<div class="wrap_radio"></div>')
	element.before('<label>'+radio_lable+'：'+'</label>')
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
				var url1=getParam("hyfl");
				
				if(url1!='undefined'&&url1!=null){
					var hyfl=url1.split(",");
						$(".type_number option").each(function(){
							var o = "no";
							for(var j=0;j<hyfl.length;j++){
								//alert($(this).val()+"前面当前"+hyfl[j])
								if($(this).val()==hyfl[j]){
									o = 'yes';
								}
							}
							if(o=='no'){
								$(this).remove();
							}
					})
				}
			    },        
			    error:function(data){
			    	//alert(JSON.parse(data.responseText).errors[0].message)
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


//输入框
function inputText(){
	var inputArr=$(".input")
	for(var i=0;i<$(".input").length;i++){
		var inputElement=inputArr.eq(i)
		var inputParent=inputElement.parent();
		if(inputParent.attr("inputDivWithLable")==undefined) {
			var lable = inputElement.attr("lable")//获取lable
			var require=inputElement.attr("require")//获取是否必填		
			inputElement.wrap("<div class='wrap_input' inputDivWithLable></div>")//最外面添加div
			$(".wrap_input").eq(i).prepend("<label>"+lable+'：'+"</label>")//添加lable标签
			inputElement.after("<span class='error'></span>")//错误信息回显
			$(".wrap_input").eq(i).css("position","relative")
			$(".error").eq(i).css({"position":"absolute","bottom":"-3px","left":"32%","color":"red","font-size":"12px","height":"12px"})//错误信息回显位置
			$(".wrap_input").eq(i).append("<span class='must' style='font-weight:bold;color:red;line-height:44px;'>&nbsp;&nbsp*</span>")//必填提示
			if(require=="false"||require==undefined){//判断是否必填
				$(".must").eq(i).hide();
			}
			$(".wrap_input").eq(i).append("<div style='clear:both;'></div>")//清除浮动
		}
	}
}
$(function(){
	//输入框
	inputText();	
	//模态框树形菜单
	//$(".input_tree").setAttribute("data-am-modal","{target: '#doc-modal-1', closeViaDimmer: 0}")	
	var treeInput='<div class="am-modal am-modal-no-btn" tabindex="-1" id="doc-modal-1">'+
	  '<div class="am-modal-dialog">'+
	    '<div class="am-modal-hd" style="font-size:14px">'+
		   '<span>请选择相关部门</span>'+
	      '<a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>'+
	    '</div>'+
	    '<div class="am-modal-bd tree_content">'+    
	      '<ul id="treeDemo" class="ztree"></ul>'+
	    '</div>'+
	    '<div class="am-u-sm-12" style="padding:0;margin:0;border-top:1px solid #999;">'+
				'<p class="am-u-sm-6 tree_console" data-am-modal-close style="padding:0;margin:0;border-right:1px solid #999;color:#3bb4f2;line-height:40px;text-align:center;font-size:14px;font-weight:bold;cursor:pointer;">取消</p>'+
				'<p class="am-u-sm-6 tree_ok"  data-am-modal-close style="padding:0;margin:0;color:#3bb4f2;line-height:40px;text-align:center;font-size:14px;font-weight:bold;cursor:pointer;">确定</p>'+
		'</div>'+
	  '</div>'+
	'</div>'
	  
	$("body").append(treeInput);
	var _tree_console=$(".tree_input").attr("tree_nok")
	
	var _tree_ok=$(".tree_input").attr("tree_ok")
    $(".tree_console").click(function(){
    	eval("("+_tree_console+")")
    })
    $(".tree_ok").click(function(){
    	eval("("+_tree_ok+")")
    })
    
	
    
    
    //多选框
	/*$.ajax({
	        url:"/attendance/api/costOrg?method=getlist",
	        type:"post",
	        dataType:"json",
	        data:$.toJSON({other:""}),
	        contentType:"application/json",
	        success:function(data){
	        	//var data=JSON.stringify(data.rows);
	        	
	        for(var i=0;i<data.rows.length;i++){       	 
	             $("#select_checkbox").append("<option value="+data.rows[i].cost_org_id+">"+data.rows[i].org_name_show+"</option>");
	          }
	        	$("#select_checkbox").multiselect();
	    	
	    	
	        },        
	        error:function(data){
	        	//alert(JSON.parse(data.responseText).errors[0].message)
	          
	        }
	    })
	*/
 
	
})
