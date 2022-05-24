package com.pj.ssm.crm.settings.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 20 21:17
 **/
@Controller
public class AuthorityManageController {

    // 用户维权
    @RequestMapping("/settings/qx/user/userAuthority.do")
    public String userAuthority(){
        return "settings/qx/user/index";
    }
    // 角色维权
    @RequestMapping("/settings/qx/user/roleAuthority.do")
    public String roleAuthority(){
        return "settings/qx/role/index";
    }
    // 许可维权
    @RequestMapping("/settings/qx/user/permissionAuthority.do")
    public String permissionAuthority(){
        return "settings/qx/permission/index";
    }
}
