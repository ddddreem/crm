package com.pj.ssm.crm.settings.service.impl;

import com.pj.ssm.crm.commons.domain.ReturnObject;
import com.pj.ssm.crm.commons.utils.Contants;
import com.pj.ssm.crm.commons.utils.DateFormatUtils;
import com.pj.ssm.crm.commons.utils.UserUtils;
import com.pj.ssm.crm.settings.domain.User;
import com.pj.ssm.crm.settings.mapper.UserMapper;
import com.pj.ssm.crm.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.*;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 04 21 17:22
 **/
@Service("userService")
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public Object queryUserByLoginActAndPwd(Map<String, Object> map, String isRemPwd, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        User user = userMapper.selectUserByLoginActAndPwd(map);
        ReturnObject returnObject = new ReturnObject();
        if(user == null){
            // 如果数据库中查无此用户，登陆失败
            returnObject.setCode(Contants.RETURNOBJECT_FAILURE);
            returnObject.setMessage("用户名或密码错误！");
        }else{
            String now = DateFormatUtils.DateToString(new Date());
            if(user.getExpireTime().compareTo(now) < 0){
                // 登陆失败，用户已过期
                returnObject.setCode(Contants.RETURNOBJECT_FAILURE);
                returnObject.setMessage("用户已过期！");
            }else if(user.getLockState().equals("0")){
                // 登陆失败，用户已被锁定
                returnObject.setCode(Contants.RETURNOBJECT_FAILURE);
                returnObject.setMessage("用户已被锁定！");
            }else if(!user.getAllowIps().contains(request.getRemoteAddr())){
                // 登陆失败，ip受限
                returnObject.setCode(Contants.RETURNOBJECT_FAILURE);
                returnObject.setMessage("ip受限！");
            }else{
                // 登陆成功
                returnObject.setCode(Contants.RETURNOBJECT_SUCCESS);
                // 把User保存到session中
                session.setAttribute(Contants.SESSION_USER, user);
                // 如果需要记住密码，则往外写cookie
                if(isRemPwd.equals("true")){
                    UserUtils.sendCookieToBroswer(response, Contants.COOKIE_USERNAME, user.getLoginAct(), 10*24*60*60);
                    UserUtils.sendCookieToBroswer(response, Contants.COOKIE_PASSWORD, user.getLoginPwd(), 10*24*60*60);
//                    Cookie cookieUserName = new Cookie(Contants.COOKIE_USERNAME, user.getLoginAct());
//                    Cookie cookieUserPassword = new Cookie(Contants.COOKIE_PASSWORD, user.getLoginPwd());
//                    cookieUserName.setMaxAge(10*24*60*60);
//                    cookieUserPassword.setMaxAge(10*24*60*60);
//                    response.addCookie(cookieUserName);
//                    response.addCookie(cookieUserPassword);
                }else{
                    // 没有选择记住密码，则删除cookie
                    UserUtils.sendCookieToBroswer(response, Contants.COOKIE_USERNAME, user.getLoginAct(), 0);
                    UserUtils.sendCookieToBroswer(response, Contants.COOKIE_PASSWORD, user.getLoginPwd(), 0);
                }
            }
        }
        return returnObject;
    }

    @Override
    public List<User> queryAllUsers() {
        return userMapper.selectAllUsers();
    }

    @Override
    public String queryIDByUserName(String userName) {
        return userMapper.selectIDByUserName(userName);
    }

    @Override
    public User queryUserByUserNamePwd(Map<String, Object> map) {
        return userMapper.selectUserByUserNamePwd(map);
    }

    @Override
    public int updateLoginPwdByLoginActNewPwd(Map<String, Object> map) {
        return userMapper.updateLoginPwdByLoginActNewPwd(map);
    }
}
