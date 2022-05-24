package com.pj.ssm.crm.workbench.web.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pj.ssm.crm.commons.domain.Msg;
import com.pj.ssm.crm.commons.utils.Contants;
import com.pj.ssm.crm.commons.utils.DateFormatUtils;
import com.pj.ssm.crm.commons.utils.UUIDUtils;
import com.pj.ssm.crm.settings.domain.DicValue;
import com.pj.ssm.crm.settings.domain.User;
import com.pj.ssm.crm.settings.service.DicService;
import com.pj.ssm.crm.settings.service.UserService;
import com.pj.ssm.crm.workbench.domain.*;
import com.pj.ssm.crm.workbench.service.*;
import com.sun.tools.doclets.internal.toolkit.Content;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 05 15 17:41
 **/
@Controller
public class TranController {

    @Autowired
    private TranService tranService;

    @Autowired
    private UserService userService;

    @Autowired
    private ActivityService activityService;

    @Autowired
    private ContactsService contactsService;

    @Autowired
    private TranRemarkService tranRemarkService;

    @Autowired
    private TranHistoryService tranHistoryService;

    @Autowired
    private DicService dicService;

    @Autowired
    private CustomerService customerService;

    @RequestMapping("/workbench/transaction/tranIndex.do")
    public ModelAndView tranIndex(){
        ModelAndView mv = new ModelAndView();
        List<DicValue> stage = dicService.queryDicValueByTypeCode("stage");
        List<DicValue> type = dicService.queryDicValueByTypeCode("transactionType");
        List<DicValue> source = dicService.queryDicValueByTypeCode("source");
        mv.addObject("stage", stage);
        mv.addObject("type", type);
        mv.addObject("source", source);
        mv.setViewName("workbench/transaction/index");
        return mv;
    }

    @RequestMapping("/workbench/transaction/queryAllTrans.do")
    public @ResponseBody Msg queryAllTrans(Tran tran, String pn, String ps){
        int pageNo = Integer.parseInt(pn);
        int pageSize = Integer.parseInt(ps);
        PageHelper.startPage(pageNo, pageSize);
        List<Tran> trans = tranService.queryAllTrans(tran);
        PageInfo pageInfo = new PageInfo(trans, 5);
        return Msg.success().add("pageInfo", pageInfo);
    }

    // 交易明细页面
    @RequestMapping("/workbench/transaction/tranDetail.do")
    public ModelAndView tranDetail(String tranId){
        ModelAndView mv = new ModelAndView();
        List<DicValue> stage = dicService.queryDicValueByTypeCode("stage");
        mv.addObject("stage", stage);
        Tran tran = tranService.queryTranDetailById(tranId);
        ResourceBundle bundle = ResourceBundle.getBundle("properties/possibility");
        // 获取可能性
        String possibility = bundle.getString(tran.getStage());
        // 给查询的交易绑定可能性
        tran.setPossibility(possibility);
        List<TranRemark> tranRemarks = tranRemarkService.queryTranRemarksForDetailByTranId(tranId);
        List<TranHistory> tranHistories = tranHistoryService.queryTranHistoriesForDetailByTranId(tranId);
        String tranHisPossibility = "";
        for(TranHistory th:tranHistories){
            tranHisPossibility = bundle.getString(th.getStage());
            th.setPossibility(tranHisPossibility);
        }
        mv.addObject("tran", tran);
        mv.addObject("tranRemarks", tranRemarks);
        mv.addObject("tranHistories", tranHistories);
        mv.setViewName("workbench/transaction/detail");
        return mv;
    }

    // 跳转创建交易页面
    @RequestMapping("/workbench/transaction/toSaveTranPage.do")
    public ModelAndView toSaveTranPage(){
        ModelAndView mv = new ModelAndView();
        List<User> users = userService.queryAllUsers();
        List<DicValue> type = dicService.queryDicValueByTypeCode("transactionType");
        List<DicValue> stage = dicService.queryDicValueByTypeCode("stage");
        List<DicValue> source = dicService.queryDicValueByTypeCode("source");
        mv.addObject("users", users);
        mv.addObject("type", type);
        mv.addObject("stage", stage);
        mv.addObject("source", source);
        mv.setViewName("workbench/transaction/save");
        return mv;
    }

    // 获取阶段可能性
    @RequestMapping("/workbench/transaction/getPossibilityByStage.do")
    public @ResponseBody Msg getPossibilityByStage(String stageValue){
        //获取properties文件对象
        ResourceBundle bundle = ResourceBundle.getBundle("properties/possibility");
        return Msg.success().add("possibility", bundle.getString(stageValue));
    }

    // 提供自动补全客户名称功能
    @RequestMapping("/workbench/transaction/typeaheadPlugin.do")
    public @ResponseBody Msg typeaheadPlugin(String customerName){
        List<String> customerNames = customerService.queryAllCustomerName(customerName);
        return Msg.success().add("customerNames", customerNames);
    }

    @RequestMapping("/workbench/transaction/queryActivitiesForCreateTran.do")
    public @ResponseBody Msg queryActivitiesForCreateTran(String activityName){
        List<Activity> activitiesForTran = activityService.queryActivitiesByActivityName(activityName);
        return Msg.success().add("activitiesForTran", activitiesForTran);
    }

    // 根据联系人名称模糊查询联系人
    @RequestMapping("/workbench/transaction/queryContactsForCreateTran.do")
    public @ResponseBody Msg queryContactsForCreateTran(String contactName){
        List<Contacts> contacts = contactsService.queryContactsByContactName(contactName);
        return Msg.success().add("contactsForTran", contacts);
    }

    // 创建保存交易
    @RequestMapping("/workbench/transaction/saveCreateTran.do")
    public @ResponseBody Msg saveCreateTran(Tran tran, HttpSession session){
        User user = (User) session.getAttribute(Contants.SESSION_USER);
        tran.setCreateBy(user.getId());
        tran.setCreateTime(DateFormatUtils.DateToString(new Date()));
        tran.setId(UUIDUtils.getUUID());
        try{
            int count = tranService.saveCreateTran(tran);
            if(count > 0) return Msg.success();
            return Msg.fail();
        }catch(Exception e){
            e.printStackTrace();
            return Msg.fail();
        }
    }
}
