
/**
 * 获取服务器时间
 * @returns {Date}
 */
function getServerDate(){
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

time_now_server = getServerDate();//服务器时间
time_now_server = time_now_server.getTime();//服务器时间毫秒值

time_server_client = time_now_server - time_now_client;//服务器时间和本地时间差

setTimeout("show_time()", 1000);

function show_time() {

    var timer = document.getElementById("timer");
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
    //time_server_client = getServerDate().getTime()-time_now.getTime();

    time_now = time_now.getTime() + time_server_client;
    time_distance = time_end - time_now;

    if (time_distance > 0) {
        //console.log();
        if(Math.floor(time_distance / 1000) == 600){
            alertOpen("距离考试结束时间还剩10分钟！请合理安排答题时间！");
        }/*else if(Math.floor(time_distance / 1000) == 300){
            alertOpen("距离考试结束时间还剩5分钟！请各位同学仔细检查试卷，准备交卷！");
        }*/
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
    } else{

        if(time_end/1000 <= getServerDate().getTime()/1000){
            clearTimeout(timerID);

            timer.innerHTML = "考试已结束！";

            var staus = saveAnswerPaper(2);

            if(staus=="1"){
                window.location.href = "../examinee/ex_enroll.html";
            }else if(staus=="2"){
                alertOpen("超过考试结束时间提交试卷，本次考试成绩无效.",function () {
                    window.location.href = "../examinee/ex_enroll.html";
                });
            }
        }

        if(time_end > getServerDate().getTime()){
            time_server_client = getServerDate().getTime()-time_now.getTime();
        }
    }
}
