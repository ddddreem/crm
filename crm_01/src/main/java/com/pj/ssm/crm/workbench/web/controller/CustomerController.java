package com.pj.ssm.crm.workbench.web.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pj.ssm.crm.commons.domain.Msg;
import com.pj.ssm.crm.commons.utils.Contants;
import com.pj.ssm.crm.commons.utils.DateFormatUtils;
import com.pj.ssm.crm.settings.domain.DicValue;
import com.pj.ssm.crm.settings.domain.User;
import com.pj.ssm.crm.settings.service.DicService;
import com.pj.ssm.crm.settings.service.UserService;
import com.pj.ssm.crm.workbench.domain.Customer;
import com.pj.ssm.crm.workbench.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 15 11:11
 **/
@Controller
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    @Autowired
    private UserService userService;

    @RequestMapping("/workbench/customer/customerIndex.do")
    public ModelAndView customerIndex(){
        ModelAndView mv = new ModelAndView();
        List<User> users = userService.queryAllUsers();
        mv.addObject("users", users);
        mv.setViewName("workbench/customer/index");
        return mv;
    }

    @RequestMapping("/workbench/customer/queryAllCustomers.do")
    public @ResponseBody Msg queryAllCustomers(Customer customer, String pn, String ps){
        int pageNo = Integer.parseInt(pn);
        int pageSize = Integer.parseInt(ps);
        // 分页之前，设置去数据库中查询的数量
        PageHelper.startPage(pageNo, pageSize);
        List<Customer> customers = customerService.queryAllCustomers(customer);
        // 分页查询插件，封装分页的各种信息
        PageInfo page = new PageInfo(customers, 5);
        return Msg.success().add("pageInfo", page);
    }

    // 显示客户信息到模态框中
    @RequestMapping("/workbench/customer/queryCustomerForEditByCustomerId.do")
    public @ResponseBody Msg queryCustomerForEditByCustomerId(String customerId){
        Customer customer = customerService.queryCustomerForEditByCustomerId(customerId);
        if(customer != null){
            return Msg.success().add("editCustomer", customer);
        }
        return Msg.fail();
    }

    // 保存修改的客户信息
    @RequestMapping("/workbench/customer/saveCustomerByModifiedCustomer.do")
    public @ResponseBody Msg saveCustomerByModifiedCustomer(Customer modifiedCustomer, HttpSession session){
        User user = (User) session.getAttribute(Contants.SESSION_USER);
        modifiedCustomer.setEditBy(user.getId());
        modifiedCustomer.setEditTime(DateFormatUtils.DateToString(new Date()));
        try{
            int count = customerService.updateCustomerByModifiedCustomer(modifiedCustomer);
            if(count > 0) return Msg.success();
            return Msg.fail();
        }catch (Exception e){
            e.printStackTrace();
            return Msg.fail();
        }
    }
}
