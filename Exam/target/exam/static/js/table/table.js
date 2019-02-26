//导出插件
/*The MIT License (MIT)

Copyright (c) 2014 https://github.com/kayalshri/

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.*/

(function($){
        $.fn.extend({
            tableExport: function(options) {
                var defaults = {
						separator: ',',
						ignoreColumn: [],
						tableName:'yourTableName',
						type:'csv',
						pdfFontSize:14,
						pdfLeftMargin:20,
						escape:'true',
						htmlContent:'false',
						consoleLog:'false'
				};
                
				var options = $.extend(defaults, options);
				var el = this;
				
				if(defaults.type == 'csv' || defaults.type == 'txt'){
				
					// Header
					var tdData ="";
					$(el).find('thead').find('tr').each(function() {
					tdData += "\n";					
						$(this).filter(':visible').find('th').each(function(index,data) {
							if ($(this).css('display') != 'none'){
								if(defaults.ignoreColumn.indexOf(index) == -1){
									tdData += '"' + parseString($(this)) + '"' + defaults.separator;									
								}
							}
							
						});
						tdData = $.trim(tdData);
						tdData = $.trim(tdData).substring(0, tdData.length -1);
					});
					
					// Row vs Column
					$(el).find('tbody').find('tr').each(function() {
					tdData += "\n";
						$(this).filter(':visible').find('td').each(function(index,data) {
							if ($(this).css('display') != 'none'){
								if(defaults.ignoreColumn.indexOf(index) == -1){
									tdData += '"'+ parseString($(this)) + '"'+ defaults.separator;
								}
							}
						});
						//tdData = $.trim(tdData);
						tdData = $.trim(tdData).substring(0, tdData.length -1);
					});
					
					//output
					if(defaults.consoleLog == 'true'){
						console.log(tdData);
					}
					var base64data = "base64," + $.base64.encode(tdData);
					window.open('data:application/'+defaults.type+';filename=exportData;' + base64data);
				}else if(defaults.type == 'sql'){
				
					// Header
					var tdData ="INSERT INTO `"+defaults.tableName+"` (";
					$(el).find('thead').find('tr').each(function() {
					
						$(this).filter(':visible').find('th').each(function(index,data) {
							if ($(this).css('display') != 'none'){
								if(defaults.ignoreColumn.indexOf(index) == -1){
									tdData += '`' + parseString($(this)) + '`,' ;									
								}
							}
							
						});
						tdData = $.trim(tdData);
						tdData = $.trim(tdData).substring(0, tdData.length -1);
					});
					tdData += ") VALUES ";
					// Row vs Column
					$(el).find('tbody').find('tr').each(function() {
					tdData += "(";
						$(this).filter(':visible').find('td').each(function(index,data) {
							if ($(this).css('display') != 'none'){
								if(defaults.ignoreColumn.indexOf(index) == -1){
									tdData += '"'+ parseString($(this)) + '",';
								}
							}
						});
						
						tdData = $.trim(tdData).substring(0, tdData.length -1);
						tdData += "),";
					});
					tdData = $.trim(tdData).substring(0, tdData.length -1);
					tdData += ";";
					
					//output
					//console.log(tdData);
					
					if(defaults.consoleLog == 'true'){
						console.log(tdData);
					}
					
					var base64data = "base64," + $.base64.encode(tdData);
					window.open('data:application/sql;filename=exportData;' + base64data);
					
				
				}else if(defaults.type == 'json'){
				
					var jsonHeaderArray = [];
					$(el).find('thead').find('tr').each(function() {
						var tdData ="";	
						var jsonArrayTd = [];
					
						$(this).filter(':visible').find('th').each(function(index,data) {
							if ($(this).css('display') != 'none'){
								if(defaults.ignoreColumn.indexOf(index) == -1){
									jsonArrayTd.push(parseString($(this)));									
								}
							}
						});									
						jsonHeaderArray.push(jsonArrayTd);						
						
					});
					
					var jsonArray = [];
					$(el).find('tbody').find('tr').each(function() {
						var tdData ="";	
						var jsonArrayTd = [];
					
						$(this).filter(':visible').find('td').each(function(index,data) {
							if ($(this).css('display') != 'none'){
								if(defaults.ignoreColumn.indexOf(index) == -1){
									jsonArrayTd.push(parseString($(this)));									
								}
							}
						});									
						jsonArray.push(jsonArrayTd);									
						
					});
					
					var jsonExportArray =[];
					jsonExportArray.push({header:jsonHeaderArray,data:jsonArray});
					
					//Return as JSON
					//console.log(JSON.stringify(jsonExportArray));
					
					//Return as Array
					//console.log(jsonExportArray);
					if(defaults.consoleLog == 'true'){
						console.log(JSON.stringify(jsonExportArray));
					}
					var base64data = "base64," + $.base64.encode(JSON.stringify(jsonExportArray));
					window.open('data:application/json;filename=exportData;' + base64data);
				}else if(defaults.type == 'xml'){
				
					var xml = '<?xml version="1.0" encoding="utf-8"?>';
					xml += '<tabledata><fields>';

					// Header
					$(el).find('thead').find('tr').each(function() {
						$(this).filter(':visible').find('th').each(function(index,data) {
							if ($(this).css('display') != 'none'){					
								if(defaults.ignoreColumn.indexOf(index) == -1){
									xml += "<field>" + parseString($(this)) + "</field>";
								}
							}
						});									
					});					
					xml += '</fields><data>';
					
					// Row Vs Column
					var rowCount=1;
					$(el).find('tbody').find('tr').each(function() {
						xml += '<row id="'+rowCount+'">';
						var colCount=0;
						$(this).filter(':visible').find('td').each(function(index,data) {
							if ($(this).css('display') != 'none'){	
								if(defaults.ignoreColumn.indexOf(index) == -1){
									xml += "<column-"+colCount+">"+parseString($(this))+"</column-"+colCount+">";
								}
							}
							colCount++;
						});															
						rowCount++;
						xml += '</row>';
					});					
					xml += '</data></tabledata>'
					
					if(defaults.consoleLog == 'true'){
						console.log(xml);
					}
					
					var base64data = "base64," + $.base64.encode(xml);
					window.open('data:application/xml;filename=exportData;' + base64data);

				}else if(defaults.type == 'excel' || defaults.type == 'doc'|| defaults.type == 'powerpoint'  ){
					//console.log($(this).html());
					var excel="<table>";
					// Header
					$(el).find('thead').find('tr').each(function() {
						excel += "<tr>";
						$(this).filter(':visible').find('th').each(function(index,data) {
							if ($(this).css('display') != 'none'){					
								if(defaults.ignoreColumn.indexOf(index) == -1){
									excel += "<td>" + parseString($(this))+ "</td>";
								}
							}
						});	
						excel += '</tr>';						
						
					});					
					
					
					// Row Vs Column
					var rowCount=1;
					$(el).find('tbody').find('tr').each(function() {
						excel += "<tr>";
						var colCount=0;
						$(this).filter(':visible').find('td').each(function(index,data) {
							if ($(this).css('display') != 'none'){	
								if(defaults.ignoreColumn.indexOf(index) == -1){
									excel += "<td>"+parseString($(this))+"</td>";
								}
							}
							colCount++;
						});															
						rowCount++;
						excel += '</tr>';
					});					
					excel += '</table>'
					
					if(defaults.consoleLog == 'true'){
						console.log(excel);
					}
					
					var excelFile = "<html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:x='urn:schemas-microsoft-com:office:"+defaults.type+"' xmlns='http://www.w3.org/TR/REC-html40'>";
					excelFile += "<head>";
					excelFile += "<!--[if gte mso 9]>";
					excelFile += "<xml>";
					excelFile += "<x:ExcelWorkbook>";
					excelFile += "<x:ExcelWorksheets>";
					excelFile += "<x:ExcelWorksheet>";
					excelFile += "<x:Name>";
					excelFile += "{worksheet}";
					excelFile += "</x:Name>";
					excelFile += "<x:WorksheetOptions>";
					excelFile += "<x:DisplayGridlines/>";
					excelFile += "</x:WorksheetOptions>";
					excelFile += "</x:ExcelWorksheet>";
					excelFile += "</x:ExcelWorksheets>";
					excelFile += "</x:ExcelWorkbook>";
					excelFile += "</xml>";
					excelFile += "<![endif]-->";
					excelFile += "</head>";
					excelFile += "<body>";
					excelFile += excel;
					excelFile += "</body>";
					excelFile += "</html>";

					var base64data = "base64," + $.base64.encode(excelFile);
					window.open('data:application/vnd.ms-'+defaults.type+';filename=exportData.doc;' + base64data);
					
				}else if(defaults.type == 'png'){
					html2canvas($(el), {
						onrendered: function(canvas) {										
							var img = canvas.toDataURL("image/png");
							window.open(img);
							
							
						}
					});		
				}else if(defaults.type == 'pdf'){
	
					var doc = new jsPDF('p','pt', 'a4', true);
					doc.setFontSize(defaults.pdfFontSize);
					
					// Header
					var startColPosition=defaults.pdfLeftMargin;
					$(el).find('thead').find('tr').each(function() {
						$(this).filter(':visible').find('th').each(function(index,data) {
							if ($(this).css('display') != 'none'){					
								if(defaults.ignoreColumn.indexOf(index) == -1){
									var colPosition = startColPosition+ (index * 50);									
									doc.text(colPosition,20, parseString($(this)));
								}
							}
						});									
					});					
				
				
					// Row Vs Column
					var startRowPosition = 20; var page =1;var rowPosition=0;
					$(el).find('tbody').find('tr').each(function(index,data) {
						rowCalc = index+1;
						
					if (rowCalc % 26 == 0){
						doc.addPage();
						page++;
						startRowPosition=startRowPosition+10;
					}
					rowPosition=(startRowPosition + (rowCalc * 10)) - ((page -1) * 280);
						
						$(this).filter(':visible').find('td').each(function(index,data) {
							if ($(this).css('display') != 'none'){	
								if(defaults.ignoreColumn.indexOf(index) == -1){
									var colPosition = startColPosition+ (index * 50);									
									doc.text(colPosition,rowPosition, parseString($(this)));
								}
							}
							
						});															
						
					});					
										
					// Output as Data URI
					doc.output('datauri');
	
				}
				
				
				function parseString(data){
				
					if(defaults.htmlContent == 'true'){
						content_data = data.html().trim();
					}else{
						content_data = data.text().trim();
					}
					
					if(defaults.escape == 'true'){
						content_data = escape(content_data);
					}
					
					
					
					return content_data;
				}
			
			}
        });
    })(jQuery);
        
//base64

/*jslint adsafe: false, bitwise: true, browser: true, cap: false, css: false,
debug: false, devel: true, eqeqeq: true, es5: false, evil: false,
forin: false, fragment: false, immed: true, laxbreak: false, newcap: true,
nomen: false, on: false, onevar: true, passfail: false, plusplus: true,
regexp: false, rhino: true, safe: false, strict: false, sub: false,
undef: true, white: false, widget: false, windows: false */
/*global jQuery: false, window: false */
//"use strict";

/*
* Original code (c) 2010 Nick Galbreath
* http://code.google.com/p/stringencoders/source/browse/#svn/trunk/javascript
*
* jQuery port (c) 2010 Carlo Zottmann
* http://github.com/carlo/jquery-base64
*
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without
* restriction, including without limitation the rights to use,
* copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the
* Software is furnished to do so, subject to the following
* conditions:
*
* The above copyright notice and this permission notice shall be
* included in all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
* OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
* NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
* HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
* OTHER DEALINGS IN THE SOFTWARE.
*/

/* base64 encode/decode compatible with window.btoa/atob
*
* window.atob/btoa is a Firefox extension to convert binary data (the "b")
* to base64 (ascii, the "a").
*
* It is also found in Safari and Chrome.  It is not available in IE.
*
* if (!window.btoa) window.btoa = $.base64.encode
* if (!window.atob) window.atob = $.base64.decode
*
* The original spec's for atob/btoa are a bit lacking
* https://developer.mozilla.org/en/DOM/window.atob
* https://developer.mozilla.org/en/DOM/window.btoa
*
* window.btoa and $.base64.encode takes a string where charCodeAt is [0,255]
* If any character is not [0,255], then an exception is thrown.
*
* window.atob and $.base64.decode take a base64-encoded string
* If the input length is not a multiple of 4, or contains invalid characters
*   then an exception is thrown.
*/

jQuery.base64 = (function($) {

  // private property
  var keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

  // private method for UTF-8 encoding
  function utf8Encode(string) {
      string = string.replace(/\r\n/g,"\n");
      var utftext = "";
      for (var n = 0; n < string.length; n++) {
          var c = string.charCodeAt(n);
          if (c < 128) {
              utftext += String.fromCharCode(c);
          }
          else if((c > 127) && (c < 2048)) {
              utftext += String.fromCharCode((c >> 6) | 192);
              utftext += String.fromCharCode((c & 63) | 128);
          }
          else {
              utftext += String.fromCharCode((c >> 12) | 224);
              utftext += String.fromCharCode(((c >> 6) & 63) | 128);
              utftext += String.fromCharCode((c & 63) | 128);
          }
      }
      return utftext;
  }
  function encode(input) {
      var output = "";
      var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
      var i = 0;
      input = utf8Encode(input);
      while (i < input.length) {
          chr1 = input.charCodeAt(i++);
          chr2 = input.charCodeAt(i++);
          chr3 = input.charCodeAt(i++);
          enc1 = chr1 >> 2;
          enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
          enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
          enc4 = chr3 & 63;
          if (isNaN(chr2)) {
              enc3 = enc4 = 64;
          } else if (isNaN(chr3)) {
              enc4 = 64;
          }
          output = output +
              keyStr.charAt(enc1) + keyStr.charAt(enc2) +
              keyStr.charAt(enc3) + keyStr.charAt(enc4);
      }
      return output;
  }

  return {
      encode: function (str) {
          return encode(str);
      }
  };

}(jQuery));




function btn_style(){
	$(".add").addClass("am-btn am-btn-default am-btn-xs am-text-danger table-add");
	var add_value=$(".add").val();
	$(".add").text(add_value);
	$(".add").prepend('<span class="add-icon" style="margin-right:5px;color:#5ab66b;"></span>')
	$(".add-icon").addClass("am-icon-plus");
	
	//删除按钮样式
	$(".delete").addClass("am-btn am-btn-default am-btn-xs am-text-danger table-delete");
	var delete_value=$(".delete").val();
	$(".delete").text(delete_value);
	$(".delete").prepend('<span class="delete-icon" style="margin-right:5px;"></span>')
	$(".delete-icon").addClass("am-icon-trash-o");
	
	//修改按钮样式
	$(".revise").addClass("am-btn am-btn-default am-btn-xs am-text-secondary table-revise");
	var revise_value=$(".revise").val();
	$(".revise").text(revise_value);
	$(".revise").prepend('<span class="revise-icon" style="margin-right:5px;"></span>')
	$(".revise-icon").addClass("am-icon-pencil-square-o");
	
	//查看按钮样式
	$(".details").addClass("am-btn am-btn-default am-btn-xs am-text-secondary");
	var details_value=$(".details").val();
	$(".details").text(details_value);
	$(".details").prepend('<span class="details-icon" style="margin-right:5px;"></span>')
	$(".details-icon").addClass("am-icon-eye");
	
}
$(function(){
	
	$("body").append('<div class="nty_saving" style="position:reltive;width:100%;height:100%;display:none;position:fixed;;left:0;top:0;background:#333; background-color:rgba(0,0,0,.5); ;z-index:9999;">'+
            '<div  style="position:absolute;top:50%;left:50%;font-size:16px;margin-top:-60px;margin-left:-200px;width:400px;height:120px;color:#fff;line-height:120px;text-align:center;">'+
            '<i class="am-icon-spinner am-icon-pulse"></i><span style="display:inline;font-size:16px;padding-left:5px;">保存中</span>'+
            '</div>'+  
        '</div>')
	
	
	
	var pop='<div class="am-modal am-modal-no-btn" tabindex="-1" id="main">'+
	  '<div class="am-modal-dialog">'+
	    '<div class="am-modal-hd">'+
	      '<a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>'+
	    '</div>'+
			'<div style="min-height:50px;" class="content">'+
			'</div>'+
			'<div class="am-u-sm-12" style="padding:0;margin:0;border-top:1px solid #999;">'+
			'<p class="am-u-sm-6 ok" style="padding:0;margin:0;color:#3bb4f2;line-height:40px;border-right:1px solid #999;text-align:center;font-size:14px;font-weight:bold;cursor:pointer;">确定</p>'+
			'<p class="am-u-sm-6 console"  data-am-modal-close style="padding:0;margin:0;color:#3bb4f2;line-height:40px;text-align:center;font-size:14px;font-weight:bold;cursor:pointer;">取消</p>'+
			'</div>'+ 
	'</div>'+
'</div>'   
	$("body").append(pop);	//初始化的时候加
	if(document.body.clientWidth<=640){
		$(".am-modal-dialog").css("width","100%")
	}
	

});


var DataGrid=(function(element,page,url,arr,setChangeDataFun) {
	element.addClass("table")
	var table=element.children("table")
	//给table添加样式
	element.find("table").addClass("am-table am-table-striped am-table-bordered am-table-compact am-text-nowrap")	
	this.button_add = null;
	this.button_del = null;
	

	
	var _setChangeDataFun =setChangeDataFun; 
		if(setChangeDataFun==null||setChangeDataFun=="undefined"||setChangeDataFun==""){
			_setChangeDataFun=function(rows){return rows;}
		}	
		//传参
	    var paras={}
	    this.setParameters=function(para){
	    	 paras=para
	    }
	    //排序
	    var sorts=[]
	    this.setSorts=function(sort){
	    	 sorts=sort
	    }
	    //
	    var pageNum=[10,20,50,100,200,300,400,500]
	    this.setPageNum=function(num){
	    	pageNum.unshift(num)
	    
	    }
	    //导出
	    this.tableExport=function(exports){
	    	var tableExport=element.find(".toolbar")
	    	console.log(table)//$(\'.test table\')
	    	tableExport.append('<button  onclick="$(\''+exports+'\').tableExport({ type: \'excel\', separator: \';\', escape: \'false\' })" style="color:#3bb4f2;" class="am-btn am-btn-default am-btn-xs am-text-danger"><span class="am-icon-cloud-download" style="margin-right:5px;color:#3bb4f2;"></span>导出</button>')
	    }
	    //按钮和模态框内容对起来	 
	    var buttonsEven = [];
	    this.setButtonEven=function(buttonelements,contentelement) {
	    	buttonsEven.push({"btn":buttonelements,"con":contentelement});
	    };
	    //添加表格标题
	    var _element=element;
	    this.setTitle=function(title){
		    if(_element.children(".toolbar").length>0){
		    	_element.children(".toolbar").before("<p style='text-align:left;font-size:14px;margin:0;padding:0;line-height:50px;'>"+title+"</p>")
		    }else{
		    	_element.children("table").before("<p style='text-align:left;font-size:14px;margin:0;padding:0;line-height:50px;'>"+title+"</p>")
		    }
	    }
	    //调取json
	    var dataSet
	    this.setData=function(_dataSet){
	    	dataSet=_dataSet
	    }
	    var dTable = {
				 //设置排序
				 //"ordering": true,
				 //"bAutoWidth":true,//自动计算列宽
				 //"order": [[ 0, "desc" ]],//asc 为升序
				 "dom":'rt<"bottom"'+page+'><"clear">',
				 "language" : {
	                    "sProcessing" : "处理中...",
	                    "sLengthMenu" : "显示 _MENU_ 项结果",
	                    "sZeroRecords" : "没有匹配结果",
	                    "sInfo" : "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
	                    "sInfoEmpty" : "",
	                    "sInfoFiltered" : "",
	                    "sInfoPostFix" : "",
	                    "sSearch" : "搜索:",
	                    "sUrl" : "",
	                    "sEmptyTable" : "表中数据为空",
	                    "sLoadingRecords" : "载入中...",
	                    "sInfoThousands" : ",",
	                    "oPaginate" : {
	                        "sFirst" : "首页",
	                        "sPrevious" : "上页",
	                        "sNext" : "下页",
	                        "sLast" : "末页"
	                    },
	                    "oAria" : {
	                        "sSortAscending" : ": 以升序排列此列",
	                        "sSortDescending" : ": 以降序排列此列"
	                    }
	                },
	                "retrieve":true,
	                "bPaginate": true,
	                "bSort":false,
	                "bStateSave" : false, //是否打开客户端状态记录功能,此功能在ajax刷新纪录的时候不会将个性化设定回复为初始化状态  
	                "bFilter":false,
	                "aLengthMenu":pageNum,
	                "bLengthChange": true,
					"pagingType": "full_numbers",
					"orderable": false,
					"responsive": true
					//"paging":false//禁止分页
									
				};
	    if(page==""){
	    	dTable.paging=false
	    }
	    if (url==null||url=="undefine"||url=="") {
	    	var col=[];
	    	col.push({data: "mapData", visible: false, defaultContent : "", title: "mapData"});		//增加第一列，存放map形式的整行数据，隐藏不显示出来，仅供行处理函数使用
	    	for(var m = 0;m<arr.length;m++){
	    		var colArr={};
	    		var keys = Object.keys(arr[m]);
	    		for(var n = 0;n<keys.length;n++){
	    			var _key = keys[n];
	    			var value = arr[m][_key];
	    			if(_key !="data"){
	    				colArr[_key]=value;	
	    			}
	    		}
	    		col.push(colArr)
	    	}
		    
	    	dTable.columns=col;
	    	
	    } else {
	    	dTable.columns=arr;
	    }
	    
	    
	    
	    function runModel(){
	    	btn_style();
	    	for(var i=0;i<buttonsEven.length;i++) {
		    	//var buttonEven = $(buttonsEven[i].btn).attr("onclick");
		    	(function(i){
		    		$(buttonsEven[i].btn).unbind("click");
		    		$(buttonsEven[i].btn).click(function (event) {
		    			var con=$(buttonsEven[i].con)
				    	var conclickOk = con.attr("onclickOk");
				    	var conclickConsole = con.attr("onclickConsole"); 
				    	var conload = con.attr("onload");
			    		$(".content").html("");
						$(".content").append(con.children(".pop-content").clone());
						$(".pop-content").hide();
				        $(".content .pop-content").show();	
				        if($(".content .pop-content .abc")){				        	
				        	$(".content .pop-content .abc").trigger("click");
				        }
					    $("#main").modal();
					    if (conload!=null && conload!="undefine" && conload!="") {
					    	eval("("+conload+")")
					    }
				    	
				    	$(".console").unbind("click");
				    	$(".console").click(function(){		
				    		if (conclickConsole!=null && conclickConsole!="undefine" && conclickConsole!="") {
						    	eval("("+conclickConsole+")")
						    }
				    		
				    		
				    	})
				    	$(".ok").unbind("click");
				    	$(".ok").click(function(){
				    		if (conclickOk!=null && conclickOk!="undefine" && conclickOk!="") {
				    			$(".nty_saving").show();
				    			eval("("+conclickOk+")")
						    }
				    		
				    		
				    	})
			    	})
		       })(i); 
		    	
	    	}
	    }
	    var afterRender;
	    firstRender=true;
	    this.render=function(_afterRender){
	    	  
	    	afterRender = _afterRender;
	    	
	    	if ($.fn.DataTable.isDataTable(table)) {
	    		$(table).DataTable().clear().destroy();
	    	}	
	    	if (url==null||url=="undefine"||url=="") {
	    		var row=[];	    		
	    		for(var j=0;j<dataSet.length;j++){
	    			var col=[];
	    			col.push(dataSet[j]);		//增加第一列，放map形式的整行数据
	    			for(var t=0;t<arr.length;t++){
	    				col.push(dataSet[j][arr[t].data]);
	    			}
	    			row.push(col)
	    		}
	    		dTable.data=row;
	    		
				if(firstRender){
					table.DataTable(dTable);
				} else {
					/*alertOpen(32)*/
					/*table.dataTable().fnClearTable(); //清空一下table
					table.dataTable().fnDestroy();*/ 
					
					dTable = {
		    				 //设置排序
		    				 //"ordering": true,
		    				 //"bAutoWidth":true,//自动计算列宽
		    				 //"order": [[ 0, "desc" ]],//asc 为升序
		    				 "dom":'rt<"bottom"'+page+'><"clear">',
		    				 "language" : {
		    	                    "sProcessing" : "处理中...",
		    	                    "sLengthMenu" : "显示 _MENU_ 项结果",
		    	                    "sZeroRecords" : "没有匹配结果",
		    	                    "sInfo" : "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
		    	                    "sInfoEmpty" : "",
		    	                    "sInfoFiltered" : "",
		    	                    "sInfoPostFix" : "",
		    	                    "sSearch" : "搜索:",
		    	                    "sUrl" : "",
		    	                    "sEmptyTable" : "表中数据为空",
		    	                    "sLoadingRecords" : "载入中...",
		    	                    "sInfoThousands" : ",",
		    	                    "oPaginate" : {
		    	                        "sFirst" : "首页",
		    	                        "sPrevious" : "上页",
		    	                        "sNext" : "下页",
		    	                        "sLast" : "末页"
		    	                    },
		    	                    "oAria" : {
		    	                        "sSortAscending" : ": 以升序排列此列",
		    	                        "sSortDescending" : ": 以降序排列此列"
		    	                    }
		    	                },
		    	                "retrieve":true,
		    	                "bPaginate": true,
		    	                "bSort":false,
		    	                "bStateSave" : false, //是否打开客户端状态记录功能,此功能在ajax刷新纪录的时候不会将个性化设定回复为初始化状态  
		    	                "bFilter":false,
		    	                "aLengthMenu":pageNum,
		    					"pagingType": "full_numbers",					
		    					"orderable": false,
		    					"responsive": true
		    					//"paging":true//禁止分页
		    									
		    				};
					
					var col=[];
					col.push({data: "mapData", visible: false, defaultContent : "", title: "mapData"});		//增加第一列，存放map形式的整行数据，隐藏不显示出来，仅供行处理函数使用
			    	for(var m = 0;m<arr.length;m++){
			    		var colArr={};
			    		var keys = Object.keys(arr[m]);
			    		for(var n = 0;n<keys.length;n++){
			    			var _key = keys[n];
			    			var value = arr[m][_key];
			    			if(_key !="data"){
			    				colArr[_key]=value;	
			    			}
			    		}
			    		col.push(colArr)
			    	}
				    
			    	if(page==""){
				    	dTable.paging=false
				    }
			    	dTable.columns=col;
		    		dTable.data=row;
		    	    
					table.DataTable(dTable);
				}
				firstRender=false;
				//table.DataTable(dTable);
	    		runModel();
	    		
	    		
	    	    //按钮和模态框内容对起来	 	    	   
	    	    
	    	    
	    	    
	    		
	    	} else {
	    		dTable.bServerSide = true;
				dTable.serverSide = true;
	    		dTable.ajax=function (data, callback, settings){		
					var param = {};
					if(page!=""){
						param.pageBean={};
						param.pageBean.start=(data.start / data.length) + 1;
						param.pageBean.pageSize=data.length;
						param.pageBean.sort=sorts;
					}
												
					param.parameters = paras;						
					$.ajax({
						url:url,							
						type:"post",
						contentType:"application/json",
						data:$.toJSON(param),								 
						success:function(result){
							//console.log(result)
							var returnData={}
							returnData.draw = data.draw;      //{draw,data,recordsTotal,recordsFiltered为必要的参数}
							returnData.data = _setChangeDataFun(result.rows)       //每页显示的数据
							returnData.recordsTotal = result.page.total;//返回数据全部记录
							returnData.recordsFiltered = result.page.total;//后台不实现过滤功能，每次查询均视作全部结果
							callback(returnData)														
							runModel();
							element.find(".am-form-select option").eq(0).hide()
							if(afterRender!=""&&afterRender!=null&&afterRender!="undefine" ){
								afterRender();
							}						    							
						;
						},
						error:function(data){
							try{
								LoginNoAndError(data,true)
							}catch (e) {
								alert(JSON.parse(data.responseText).errors[0].message)
							}
						}
					})
				};
				table.DataTable(dTable);
				
				
	    	}
	    	
	    	
	    }
	
})




