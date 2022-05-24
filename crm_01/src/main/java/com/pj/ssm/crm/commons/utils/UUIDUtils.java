package com.pj.ssm.crm.commons.utils;

import java.util.UUID;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 04 24 14:50
 **/
public class UUIDUtils {
    public static String getUUID(){
        return UUID.randomUUID().toString().replaceAll("-", "");
    }
}
