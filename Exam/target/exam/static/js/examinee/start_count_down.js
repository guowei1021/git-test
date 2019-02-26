/**
 * 获取服务器时间
 * @returns {Date}
 */
function getServerDate_1(){
    var xhr = null;
    if(window.XMLHttpRequest){
        xhr = new window.XMLHttpRequest();
    }else{ // ie
        xhr = new ActiveObject("Microsoft")
    }

    xhr.open("GET","/",false)//false不可变
    xhr.send(null);
    var date = xhr.getResponseHeader("Date");
    return new Date(date);
}

/*倒计时JS*/

var time_now_server;
var time_now_client;
var time_end;
var time_server_client;
var timerID;

time_now_client = new Date();//客户端时间
time_now_client = time_now_client.getTime();//客户端毫秒值

//time_now_server = getServerDate();//服务器时间
time_now_server = getServerDate_1().getTime();//服务器时间毫秒值

time_server_client = time_now_server - time_now_client;//服务器时间和本地时间差

setTimeout("show_time()", 1000);


function show_time() {
    var timer = document.getElementById("start_count_down");
    if (!timer) {
        return;
    }

    var time_distance;
    var str_time;
    var int_day;
    var int_hour;
    var int_minute;
    var int_second;
    var time_now = new Date();

    //不断的校正服务器端和客户端的时差
    //time_server_client = getServerDate_1().getTime()-time_now.getTime();

    time_now = time_now.getTime() + time_server_client;

    time_distance = time_end - time_now;

    if (time_distance > 0) {
        int_day = Math.floor(time_distance / 86400000);
        time_distance -= int_day * 86400000;
        int_hour = Math.floor(time_distance / 3600000);
        time_distance -= int_hour * 3600000;
        int_minute = Math.floor(time_distance / 60000);
        time_distance -= int_minute * 60000;
        int_second = Math.floor(time_distance / 1000);

        if (int_hour < 10)
            int_hour = "0" + int_hour;
        if (int_minute < 10)
            int_minute = "0" + int_minute;
        if (int_second < 10)
            int_second = "0" + int_second;
        str_time = int_day + "天" + int_hour + "小时" + int_minute + "分钟" + int_second + "秒";

        timer.innerHTML = str_time;

        timerID = setTimeout("show_time()", 1000);
    } else {

        clearTimeout(timerID);

        if(exam_endtime==undefined){
            $("#start_count_down").text("");
        }

        var now_server_time = getServerDate_1().getTime();//服务器当前时间

        if (now_server_time > exam_endtime) {//当前时间大于考试结束时间
            $('#start_exam').removeAttr("onclick");
            $('#start_button').css('background', '#cccccc');
            timer.innerHTML = "考试已结束！";
            //当前时间在考试开始时间和结束时间之间，且考生未提交答卷
        } else if (Math.floor(now_server_time / 1000) >= Math.floor(time_end / 1000) && Math.floor(now_server_time / 1000) < Math.floor(exam_endtime / 1000) && submit_flag != "2") {
            timer.innerHTML = "考试已开始！";
            $('#start_button').css('background', '#0082C9');
            $('#start_exam').attr("onclick", "startExam();");
        } else if (submit_flag == "2" && Math.floor(now_server_time / 1000) < Math.floor(exam_endtime / 1000)) {//已提交答卷,考试时间还未结束
            $("#start_count_down").text("考试已结束！");
            $('#start_exam').removeAttr("onclick");
            $('#start_button').css('background', '#cccccc');
            $('#button_text').text('已交卷');
        }else{
            $('#start_exam').removeAttr("onclick");
            $('#start_button').css('background', '#cccccc');
        }
    }
}
