package com.pj.ssm.crm.commons.domain;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 04 21 18:01
 **/
public class ReturnObject {
    private String code; // 处理成功或失败的标记
    private String message; // 提示信息
    private Object retData; // 其他数据

    public ReturnObject() {
    }

    public ReturnObject(String code, String message, Object retData) {
        this.code = code;
        this.message = message;
        this.retData = retData;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public void setRetData(Object retData) {
        this.retData = retData;
    }

    public String getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }

    public Object getRetData() {
        return retData;
    }
}
