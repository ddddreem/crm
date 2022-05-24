package com.pj.ssm.crm.commons.utils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 04 23 18:09
 **/
public class UserUtils {
    // 往客户端写cookie
    public static void sendCookieToBroswer(HttpServletResponse response, String cookieName, String cookieVal, int maxTime){
        Cookie cookie = new Cookie(cookieName, cookieVal);
        cookie.setMaxAge(maxTime);
        response.addCookie(cookie);
    }
}
