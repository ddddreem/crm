package com.pj.ssm.crm.settings.web.interceptor;

import com.pj.ssm.crm.commons.utils.Contants;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 04 23 20:10
 **/
public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        // 登陆验证
        if(httpServletRequest.getSession().getAttribute(Contants.SESSION_USER) == null || httpServletRequest.getSession().getAttribute(Contants.SESSION_USER) == "") {
            // 这里不能使用视图解析器，所以路径需要加上项目项目部署的名称
            // controller中的方法借助springMVC来重定向，会自动给你加上项目的名称
            httpServletResponse.sendRedirect(httpServletRequest.getContextPath()); // 重定向时，url必须加项目的名称
            return false;
        }
//        }else{
//            httpServletRequest.getRequestDispatcher("/workbench/index.do").forward(httpServletRequest, httpServletResponse);
//            httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + "/workbench/index.do");
//        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
