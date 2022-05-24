package com.pj.ssm.crm.workbench.web.controller;

import com.pj.ssm.crm.commons.domain.Msg;
import com.pj.ssm.crm.commons.utils.Contants;
import com.pj.ssm.crm.commons.utils.DateFormatUtils;
import com.pj.ssm.crm.commons.utils.UUIDUtils;
import com.pj.ssm.crm.settings.domain.User;
import com.pj.ssm.crm.workbench.domain.ActivityRemark;
import com.pj.ssm.crm.workbench.service.ActivityRemarkService;
import com.pj.ssm.crm.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;

/**
 * @Description: 此处添加描述 //TODO
 * @Author: Dreem
 * @Date: 2022 04 30 11:03
 **/
@Controller
public class ActivityRemarkController {
    @Autowired
    ActivityRemarkService activityRemarkService;

    @RequestMapping("/workbench/activity/saveCreateActivityRemark.do")
    public @ResponseBody Msg saveCreateActivityRemark(ActivityRemark remark, HttpSession session){
        User user = (User) session.getAttribute(Contants.SESSION_USER);
        remark.setEditFlag(Contants.REMARK_EDIT_FLAG_HAS_NOT_EDITED);
        remark.setId(UUIDUtils.getUUID());
        remark.setCreateBy(user.getId());
        remark.setCreateTime(DateFormatUtils.DateToString(new Date()));
        try{
            int count = activityRemarkService.saveCreateActivityRemark(remark);
            if(count > 0) return Msg.success().add("createRemark", remark);
            else return Msg.fail();
        }catch (Exception e){
            e.printStackTrace();
            return Msg.fail();
        }
    }

    @RequestMapping("/workbench/activity/deleteActivityRemarkById.do")
    public @ResponseBody Msg deleteActivityRemarkById(String id){
        try{
            int count = activityRemarkService.deleteActivityRemarkById(id);
            if(count > 0) return Msg.success().add("count", count);
            else return Msg.fail();
        }catch (Exception e){
            e.printStackTrace();
            return Msg.fail();
        }
    }

    @RequestMapping("/workbench/activity/updateActivityRemarkById.do")
    public @ResponseBody Msg updateActivityRemarkById(ActivityRemark activityRemark, HttpSession session){
        User user = (User) session.getAttribute(Contants.SESSION_USER);
        activityRemark.setEditFlag("1");
        activityRemark.setEditBy(user.getId());
        activityRemark.setEditTime(DateFormatUtils.DateToString(new Date()));
        try{
            int count = activityRemarkService.updateActivityRemarkById(activityRemark);
            if(count > 0) return Msg.success().add("updateRemark", activityRemark);
            else return Msg.fail();
        }catch (Exception e){
            e.printStackTrace();
            return Msg.fail();
        }
    }
}
