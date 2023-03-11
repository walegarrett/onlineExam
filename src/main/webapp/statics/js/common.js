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
//完成全选，全不选功能
$("#check_all").click(function () {
    //attr获取checked是undefined,dom原生的属性
    //以后使用prop修改和读取dom原生属性的值
    //alert($(this).prop("checked"));
    $(".check_item").prop("checked",$(this).prop("checked"));
});
//check_item
$(document).on("click",".check_item",function () {
    //判断当前选择的元素是否是5个
    var flag=$(".check_item:checked").length==$(".check_item").length;
    $("#check_all").prop("checked",flag);
});
