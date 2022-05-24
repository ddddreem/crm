package com.pj.ssm.crm.commons.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 04 22 7:30
 **/
public class DateFormatUtils {
    /**
     * 时间转换成特定格式的字符串
     */
    public static String DateToString(Date date){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sdf.format(date);
    }
}
