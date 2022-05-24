package com.pj.ssm.crm.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 04 21 14:08
 **/
@Controller
public class IndexController {

    /**
     * 理论上，给controller方法分配URL：http://127.0.0.1:8080/crm/
     * 为了简便，协议://ip:port/应用名称必须省去，用/代替应用根目录下的/
     * 注意：这里的根目录指的是项目部署后从webapp开始算起
     */
    @RequestMapping("/")
    public String index(){
        // 请求转发
        return "index";
    }
}
