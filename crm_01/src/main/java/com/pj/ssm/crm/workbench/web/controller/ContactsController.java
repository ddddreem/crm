package com.pj.ssm.crm.workbench.web.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pj.ssm.crm.commons.domain.Msg;
import com.pj.ssm.crm.settings.domain.DicValue;
import com.pj.ssm.crm.settings.domain.User;
import com.pj.ssm.crm.settings.service.DicService;
import com.pj.ssm.crm.settings.service.UserService;
import com.pj.ssm.crm.workbench.domain.Contacts;
import com.pj.ssm.crm.workbench.service.ContactsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 15 13:43
 **/
@Controller
public class ContactsController {

    @Autowired
    private ContactsService contactsService;

    @Autowired
    private UserService userService;

    @Autowired
    private DicService dicService;

    @RequestMapping("/workbench/contacts/contactsIndex.do")
    public ModelAndView contactsIndex(){
        ModelAndView mv = new ModelAndView();
        List<User> users = userService.queryAllUsers();
        List<DicValue> source = dicService.queryDicValueByTypeCode("source");
        List<DicValue> appellation = dicService.queryDicValueByTypeCode("appellation");
        mv.addObject("users", users);
        mv.addObject("source", source);
        mv.addObject("appellation", appellation);
        mv.setViewName("workbench/contacts/index");
        return mv;
    }

    @RequestMapping("/workbench/contacts/queryAllContacts.do")
    public @ResponseBody Msg queryAllContacts(Contacts conditionContact, String pn, String ps){
        int pageNo = Integer.parseInt(pn);
        int pageSize = Integer.parseInt(ps);
        PageHelper.startPage(pageNo, pageSize);
        List<Contacts> contacts = contactsService.queryAllContacts(conditionContact);
        PageInfo page = new PageInfo(contacts, 5);
        return Msg.success().add("pageInfo", page);
    }
}
