//时间毫秒值转日期格式
function getzf(num) {
    if (parseInt(num) < 10) {
        num = '0' + num;
    }
    return num;
}

function getMyDate(str) {
    var oDate = new Date(str),
        oYear = oDate.getFullYear(),
        oMonth = oDate.getMonth() + 1,
        oDay = oDate.getDate(),
        oHour = oDate.getHours(),
        oMin = oDate.getMinutes(),
        oSen = oDate.getSeconds(),
        oTime = oYear + '-' + getzf(oMonth) + '-' + getzf(oDay) + ' ' + getzf(oHour) + ':' + getzf(oMin) + ':' + getzf(oSen); //最后拼接时间
    return oTime;
}

//获取url 参数值
function getParam(name) {
    var search = document.location.search;
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

var answer_paper_id;

var locked_times;//锁定次数

$(function () {

    $(".down").css("background-color", "rgba(255,255,255,0.3)");

    //根据考试实例拿到试卷
    $.ajax({
        type: "POST",
        url: "/exam/api/examPaper/" + exam_id + "?method=get",
        async:false,
        //data : $.toJSON(reqSerObj), //将对象序列化成JSON字符串
        dataType: "json",
        contentType: 'application/json;charset=utf-8', //设置请求头信息
        success: function (data) {
            var row = data.row;

            if(data.result=="no_start"){
                alertOpen("本次考试未开始！",function () {
                    window.location.href = "../examinee/ex_enroll.html";
                });
            }

            if(data.result=="0"){//未报名本次考试，返回到首页
                alertOpen("您还未报名本次考试，请先报名本次考试！",function () {
                    window.location.href = "../examinee/ex_enroll.html";
                });
            }

            //允许离开考试页面次数赋值
            locked_times = row.locked_times;

            if(getServerDate().getTime() > row.endtime || row.submit_flag=="2"){//考试结束或已交卷，自动返回到首页！
                alertOpen("考试已结束！",function () {
                    window.location.href = "../examinee/ex_enroll.html";
                });
            }else{
                answer_paper_id = row.answer_paper_id;//答卷ID
                time_end = row.endtime;//结束的时间

                $('#answer_paper_id').val(row.answer_paper_id);

                if (row.is_connect == "0") {//不能续考，隐藏返回按钮和保存按钮
                   // $('#save').hide();
                    $('#go_back').hide();
                }
                var content;
                if (row.content != "" && row.content != null) {
                    content = JSON.parse(row.content);
                    showpaper(content);

                    //鼠标移入,显示图片
                    $('img').mouseover(function () {

                        $("#image").attr("src",$(this).attr("src"));

                        var x = event.clientX + document.body.scrollLeft + 20;
                        var y = event.clientY + $(window).scrollTop() - 5;

                        $("#image").css("left",x + "px");
                        $("#image").css("top",y + "px");
                        $("#image").css("display","block");
                    })
                    //鼠标移出,隐藏图片
                    $('img').mouseout(function () {
                        $("#image").attr("src","");
                        $("#image").css("display","none");
                    })

                }
                if (row.paper_content != null) {
                    echoOption(row.paper_content);
                }
            }
        },
        error: function (res) {
            //LoginNoAndError(res,true);
            $('#login-modal').modal({closeViaDimmer:false});
            //window.location.href = "../examinee/exam-list.jsp";
        }
    });

    //提交答卷
    $('#submit').click(function () {
        var question = $('#exam_paper_content .question-li');
        var tihao = [];
        for (var j = 0; j < question.length; j++) {
            var a = 0;
            var question_id = question[j].getAttribute("id")
            var options = $("input[name=" + question_id + "]");
            for (var i = 0; i < options.length; i++) {
                if (!options[i].checked) {
                    a += 1;
                }
            }
            if (a == options.length) {
                tihao.push(j + 1)
            }
        }
        if (tihao.length > 0) {
            var str = tihao.join('、');
            $("#msg_content").html("第" + str + "题没做，您确定要提交吗？");
            $("#affirm_modal").modal();
            //alertOpen("第" + str + "题没做，请做完再提交！");
            //return false;
        }else{
            $("#msg_content").html("提交答卷后，考题将不可更改！您确定要提交？");
            $("#affirm_modal").modal();
        }
    });
});

//保存答卷函数
function saveAnswerPaper(submit_flag) {
    var reqSerObj = {};
    //保存答卷
    if(submit_flag==1){
        var questions = [];
        $('#exam_paper_content input').each(function () {
            if ($(this).is(":checked")) {
                questions.push($(this).attr("id"));
            }
        });
        questions = questions.join(",")
        reqSerObj = {
            submit_flag: submit_flag,
            exam_case_id: exam_id,
            paper_content: questions
        };
    }else{//提交答卷
        var question = $('#exam_paper_content .question-li');
        var answer_paper = [];
        for (var j = 0; j < question.length; j++) {
            var opt_id = [];
            var question_id = question[j].getAttribute("id"); //题目id
            var options = $("input[name=" + question_id + "]");
            for (var i = 0; i < options.length; i++) {
                if (options[i].checked) {
                    var options_id = options[i].getAttribute("id"); //选项id
                    opt_id.push(options_id);
                }
            }
            opt_id = opt_id.join(",")
            var ques = {
                "ques_id": question_id,
                "opts_id": opt_id
            };
            answer_paper.push(ques);
        }
        reqSerObj = {
            exam_case_id: exam_id,
            submit_flag: submit_flag,
            paper_case_id: $('#paper_case_id').val(),
            answer_paper_id: $('#answer_paper_id').val(),
            answer_paper: answer_paper
        };
    }

    //同步服务器时间
    time_now_server = getServerDate();

    //答卷保存状态
    var saveStatus = "";

    $.ajax({
        type: "POST",
        url: "/exam/api/examPaper?method=post",
        async: false,
        data: $.toJSON(reqSerObj), //将对象序列化成JSON字符串
        dataType: "json",
        contentType: 'application/json;charset=utf-8', //设置请求头信息
        success: function (data) {
            if(data.result=="success"){
                saveStatus = "1";
            }else{
                saveStatus = "2";
            }
        },
        error: function (res) {
            saveStatus = "0";
        }
    });
    return saveStatus;
}

//确认提交答卷
$('#ok_submit').click(function () {
    var flag = saveAnswerPaper(2);
    if(flag=="1"){
        alertOpen("答卷已提交，考试已完成，考试成绩我们会另行通知.",function () {
            //window.location.href = "../examinee/exam-list.jsp";
            window.location.href = "../examinee/ex_enroll.html";
        });
    }else if(flag=="2"){
        alertOpen("超过考试结束时间提交试卷，本次考试成绩无效.",function () {
            //window.location.href = "../examinee/exam-list.jsp";
            window.location.href = "../examinee/ex_enroll.html";
        });
    }else{
        alertOpen("答卷提交失败，请联系系统管理员！");
    }
});

//保存答卷
$('#save').click(function () {

    var saveStatus = saveAnswerPaper(1);

    if (saveStatus == "1") {
        alertOpen("答卷已保存！");
    } else {
        alertOpen("答卷保存失败，请联系系统管理员！");
    }
})

//返回按钮
function backList() {
    window.location.href = "../examinee/ex_enroll.html";
}

/**
 * 每隔2分钟保存一次答卷
 */
setInterval("saveAnswerPaper(1)",1000*60*2);

/**
 * 离开页面时触发
 */
var new_leave_number;//更新后的离开次数

/*window.onblur = function() {// window 失去焦点
    var leave_number = getCookie(answer_paper_id);

    if(leave_number==undefined){//未存到cookie之前
        new_leave_number = 1;
        addCookie(answer_paper_id,new_leave_number,0);
        alertOpen("你已经开离开了本页面"+new_leave_number+"次！考试中途只能离开本页面"+locked_times+"次，离开次数到达"+locked_times+"次之后，系统将自动交卷。");
    }else{//cookie已有
        var old_leave_number = parseInt(getCookie(answer_paper_id));
        new_leave_number = old_leave_number+1;
        delCookie(answer_paper_id);
        addCookie(answer_paper_id,new_leave_number,0);
        if(new_leave_number >= locked_times){
            /!*alertOpen("您考试中途超过"+locked_times+"次离开本页面，系统已自动提交答卷！",function () {
                //saveAnswerPaper(2);
            })*!/
            var flag = saveAnswerPaper(2);
            if(flag=="1"){
                window.location.href = "../examinee/ex_enroll.html";
            }else if(flag=="2"){
                alertOpen("超过考试结束时间提交试卷，本次考试成绩无效.",function () {
                    //window.location.href = "../examinee/exam-list.jsp";
                    window.location.href = "../examinee/ex_enroll.html";
                });
            }else{
                alertOpen("答卷提交失败，请联系系统管理员！");
            }
        }else{
            alertOpen("你已经开离开了本页面"+new_leave_number+"次！考试中途只能离开本页面"+locked_times+"次，离开次数到达"+locked_times+"次之后，系统将自动交卷。");
        }
    }
};
window.onfocus = function() {// window 每次获得焦点
    var leave_number = getCookie(answer_paper_id);
    if(leave_number!=undefined && parseInt(leave_number) >= locked_times){
        /!*alertOpen("您考试中途超过"+locked_times+"次离开本页面，系统已自动提交答卷！",function () {
            saveAnswerPaper(2);
            window.location.href = "../examinee/ex_enroll.html";
        })*!/
        var flag = saveAnswerPaper(2);
        if(flag=="1"){
            window.location.href = "../examinee/ex_enroll.html";
        }else if(flag=="2"){
            alertOpen("超过考试结束时间提交试卷，本次考试成绩无效.",function () {
                //window.location.href = "../examinee/exam-list.jsp";
                window.location.href = "../examinee/ex_enroll.html";
            });
        }else{
            alertOpen("答卷提交失败，请联系系统管理员！");
        }
    }
}*/


//添加新的cookie
function addCookie(objName,objValue,objHours){
    var str = objName + "=" + escape(objValue);

    //为0时不设定过期时间，浏览器关闭时cookie自动消失
    if(objHours > 0){
        var date = new Date();
        var ms = objHours*3600*1000;
        date.setTime(date.getTime() + ms);
        str += "; expires=" + date.toString();
    }
    document.cookie = str;
};

//获取指定名称的cookie的值
function getCookie(objName){
    var arrStr = document.cookie.split("; ");
    for(var i = 0;i < arrStr.length;i ++){
        var temp = arrStr[i].split("=");
        if(temp[0] == objName) return unescape(temp[1]);
    }
};

//为了删除指定名称的cookie，可以将其过期时间设定为一个过去的时间
function delCookie(name){
    var date = new Date();
    date.setTime(date.getTime() - 10000);
    document.cookie = name + "=a; expires=" + date.toString();
};








