//js 函数
function formatDate(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();
    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;
    return [year, month, day].join('-');
}
//js 函数
function formatDateHourAndMinute(date) {
    var d = new Date(date);
    var hour = '' + d.getHours();
    var minute = '' + d.getMinutes();
    if(hour.length<2)
        hour='0'+hour;
    if(minute.length<2)
        minute='0'+minute;
    return [hour, minute].join(':');
}
//获取json数组长度
function getJsonLength(jsonData){
    var jsonLength = 0;
    for(var item in jsonData){
        jsonLength++;
    }
    return jsonLength;
}
function showNoReadCount(apppath,userid){
    if(userid==""){
        $("#msgNum").text("");
        $("#msgNum").hide();
        $("#msgNum1").text("");
        $("#msgNum1").hide();
    }else{
        userid=parseInt(userid);
        var data={
            "userId":userid
        };
        $.ajax({
            url:apppath+"/findNoReadCount",
            data:data,
            type:"get",
            success:function (result) {
                //console.log(result);
                var noReadCount=result.extend.noReadCount;
                if(noReadCount==0){
                    $("#msgNum").text("");
                    $("#msgNum").hide();
                    $("#msgNum1").text("");
                    $("#msgNum1").hide();
                }else{
                    $("#msgNum").text(""+noReadCount);
                    $("#msgNum").show();
                    $("#msgNum1").text(""+noReadCount);
                    $("#msgNum1").show();
                }
            }
        });
    }
}

