package com.pj.ssm.crm.workbench.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 04 23 23:51
 **/
@Controller
public class MainController {

    @RequestMapping("/workbench/main/index.do")
    public String index(){
        return "workbench/main/index";
    }
}
