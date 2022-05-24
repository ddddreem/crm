package com.pj.ssm.crm.settings.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 20 20:31
 **/
@Controller
public class SystemSettingsController {

    // 跳转系统设置页面
    @RequestMapping("/settings/systemSettingsIndex.do")
    public String systemSettingsIndex(){
        return "settings/index";
    }


    // 跳转权限管理界面
    @RequestMapping("/settings/qx/qxManageIndex.do")
    public String qxManageIndex(){
        return "settings/qx/index";
    }
}
