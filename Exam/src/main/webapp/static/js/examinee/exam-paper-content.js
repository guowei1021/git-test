//渲染试卷
function showpaper(content) {
	$('#paper_case_id').val(content.paper_case_id)
	var chapter = content.chapter;//章节
	$('#title').text(content.paper_case_name);//试卷名称
	var str = '';
	for (var i = 0; i < chapter.length; i++) { //章节
		var chapter_name = chapter[i].chapter_name; //章节名称
		var chapter_id = chapter[i].id; //章节id
		var chapter_grade = chapter[i].chapter_grade; //章节分数
		var chapter_sort = chapter[i].sort; //章节排序
		var chapter_type = chapter[i].type; //章节类型(单选,多选)
		str += '<div class="chapter" id="' + chapter_id + '" chapter_grade="' + chapter_grade + '"><h2>' + chapter_name + '（' + chapter_grade + '分）</h2><div style="margin-left: 50px;">';
		var question = chapter[i].question; //题目

		for (var j = 0; j < question.length; j++) {//循环题目
			var topic = question[j].topic;
			var grade = question[j].grade;
			str += '<li class="question-li" id=' + question[j].id + '><span>' + topic + '（' + grade + '分）</span>'; //题干
			var option = question[j].option;

            //图片
            var str_1 = "";
            var imgs = question[j].imgs;
            if(imgs!=undefined){
                for(var b = 0; b<imgs.length;b++){
                    str_1 += '<div style="text-align: center;float:left;width: 25%">' +
                        '<img style="vertical-align: middle;width: 200px;" src="'+imgs[b].src+'">' +
                        '<p style="padding: 0;margin: 0;">'+imgs[b].name+'</p>' +
                        '</div>';
                }
            }
            str += '<div>'+str_1+'<div style="clear: both;"></div></div>';
			str+='<ol>';
			for (var a = 0; a < option.length; a++) {
				if (question[j].type == "0") {
					str += ' <li type="A"><p>' +
						'<label class="option-label"> <input type="radio" id=' + option[a].id + ' name=' + question[j].id + '>' + option[a].option_content + '' +
						'</label>' +
						'</p></li>';
				} else {
					str += '<li type="A"><p>' +
						'<label class="option-label"> <input type="checkbox" id=' + option[a].id + ' name=' + question[j].id + '>' + option[a].option_content + '' +
						'</label>' +
						'</p></li>';
				}
			}

            str += '</ol></li>';


		}
		str += '</div></div>';
    }
	$('#exam_paper_content').append(str);
	/*//加载题号选题
	var tihao = '';
	for(var b = 0;b < question_id.length;b++){
		var number = b+1;onclick="javascript:document.getElementById("'+question_id[b]+'").scrollIntoView()"
		tihao += '<span class="round"> <a class="scroll" href="#'+question_id[b]+'"><span name="'+question_id[b]+'" style="color: #FF0000" class="shu-zi">'+number+'</span></a></span>';
	}
	$('#tihao').append(tihao);*/

}

//回显选中的选项
function echoOption(paper_content){
    var content = paper_content.split(",");
	for(var i=0;i<content.length;i++){
		$('#'+content[i]).attr("checked",true);
	}
}




/*//多选题选项点击事件
$("#exam_paper_content").on("click"," :checkbox",function(event){
	var name = $(this).attr("name");
	if($(this).is(":checked")){//如果有选项被选中,改变题号颜色
		$("span[name="+name+"]").css("color","#00ec00");
	}
	//获取没被选中的复选数量
	var options = $("input[name="+name+"]");
	var a = 0;
	for(var i = 0; i < options.length; i++) {
		console.log();
		if(!options[i].checked){
			a += 1;
		}
    }
	//如果没被选中的选项数量等于选项总数量,改变题号颜色
	if(a==options.length){
		$("span[name="+name+"]").css("color","#FF0000");
	}
})
//单选题选项点击事件
$("#exam_paper_content").on("click"," :radio",function(event){
	var name = $(this).attr("name");
	if($(this).is(":checked")){//如果有选项被选中,改变题号颜色
		$("span[name="+name+"]").css("color","#00ec00");
	}
})*/