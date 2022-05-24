package com.pj.ssm.crm.settings.web.controller;

import com.pj.ssm.crm.commons.domain.Msg;
import com.pj.ssm.crm.commons.utils.Contants;
import com.pj.ssm.crm.commons.utils.UserUtils;
import com.pj.ssm.crm.settings.domain.User;
import com.pj.ssm.crm.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 04 21 14:38
 **/
@Controller
//@RequestMapping("settings/qx/user")
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * url要和controller方法处理完请求之后，响应信息返回的页面的资源目录保持一致
     */
    @RequestMapping("/settings/qx/user/toLogin.do")
    public String toLogin(){
        return "settings/qx/user/login";
    }

    /**
     * springMVC 定义了一个可变参数列表，自动给你传入了httpservletrequest、httpservletresponse和session
     * 供程序员使用，且是自动注入进来的
     */
    @RequestMapping("/settings/qx/user/login.do")
    @ResponseBody
    public Object login(String loginAct, String loginPwd, String isRemPwd, HttpServletRequest request, HttpServletResponse response, HttpSession session){
        Map<String, Object> map = new HashMap<>();
        map.put("loginAct", loginAct);
        map.put("loginPwd", loginPwd);
        return userService.queryUserByLoginActAndPwd(map, isRemPwd, request, response, session);
    }

    // 安全退出
    @RequestMapping("/settings/qx/user/safeLogout.do")
    public String safeLogout(HttpServletResponse response, HttpSession session){
        // 删除cookie
        UserUtils.sendCookieToBroswer(response, Contants.COOKIE_USERNAME, "", 0);
        UserUtils.sendCookieToBroswer(response, Contants.COOKIE_PASSWORD, "", 0);
        // 销毁session
        session.invalidate();
        return "redirect:/";
    }

    // 更新密码
    @RequestMapping("/settings/qx/user/updatePassword.do")
    public @ResponseBody Msg updatePassword(String oldPwd, String newPwd, HttpSession session, HttpServletResponse response){
        User user = (User) session.getAttribute(Contants.SESSION_USER);
        Map<String, Object> map = new HashMap<>();
        map.put("loginAct", user.getLoginAct());
        map.put("loginPwd", oldPwd);
        if(userService.queryUserByUserNamePwd(map) != null){
            // 如果不为空,则进行密码修改操作
            map.put("newPwd", newPwd);
            int count = userService.updateLoginPwdByLoginActNewPwd(map);
            if(count > 0){
                // 删除cookie
                UserUtils.sendCookieToBroswer(response, Contants.COOKIE_USERNAME, "", 0);
                UserUtils.sendCookieToBroswer(response, Contants.COOKIE_PASSWORD, "", 0);
                // 销毁session
                session.invalidate();
                return Msg.success();
            }
            return Msg.fail();
        }
        return Msg.fail();
    }
}
