package com.pj.ssm.crm.settings.service;

import com.pj.ssm.crm.settings.domain.User;
import org.springframework.jdbc.support.nativejdbc.OracleJdbc4NativeJdbcExtractor;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 04 21 17:22
 **/
public interface UserService {
    Object queryUserByLoginActAndPwd(Map<String, Object> map, String isRemPwd, HttpServletRequest request, HttpServletResponse response, HttpSession session);
    List<User> queryAllUsers();
    String queryIDByUserName(String userName);
    User queryUserByUserNamePwd(Map<String, Object> map);
    int updateLoginPwdByLoginActNewPwd(Map<String, Object> map);
}
