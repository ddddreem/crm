package com.pj.ssm.crm.commons.domain;

import com.pj.ssm.crm.commons.utils.Contants;

import java.util.HashMap;
import java.util.Map;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 04 24 14:38
 **/
// 返回给页面的信息通用类
public class Msg {
    private String code; // 状态码信息 1成功，0失败

    private String msg; // 提示信息

    // 用户需要返回给客户端的信息
    private Map<String, Object> extend = new HashMap<>();

    public static Msg success(){
        Msg result = new Msg();
        result.setCode(Contants.TO_PAGE_CODE_SUCCESS);
        result.setMsg("操作成功！");
        return result;
    }
    public static Msg fail(){
        Msg result = new Msg();
        result.setCode(Contants.TO_PAGE_CODE_FAILED);
        result.setMsg("系统繁忙,请稍后重试...");
        return result;
    }

    public Msg add(String key, Object value){
        this.getExtend().put(key, value);
        return this;
    }
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
