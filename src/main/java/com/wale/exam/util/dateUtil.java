package com.wale.exam.util;

import java.util.Date;

/**
 * @Author WaleGarrett
 * @Date 2020/8/9 9:43
 */
public class dateUtil {
    public static Date stringToDate(String strDate){
        int year=Integer.parseInt(strDate.substring(0,4));
        int month=Integer.parseInt(strDate.substring(5,7));
        int day=Integer.parseInt(strDate.substring(8,10));
        int hour=Integer.parseInt(strDate.substring(11,13));
        int minute=Integer.parseInt(strDate.substring(14,16));
        Date date=new Date();
//        date.setYear(year);
//        date.setMonth(month);
//        date.setDate(day);
//        date.setHours(hour);
//        date.setMinutes(minute);
        return date;
    }
}
